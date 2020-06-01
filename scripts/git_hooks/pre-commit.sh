#!/bin/bash

pre_commit_stash_name="pre_commit_stash"
git_root_directory=$(git rev-parse --show-toplevel)
c_and_cpp_file_extensions=(c h cc hh cpp hpp)

####################
# Helper functions #
####################

function is_element_in_array() {
  local return_code=1
  local element_to_match=$1
  shift
  local array=("$@")
  for array_element in ${array[@]}; do
    if [ $element_to_match = $array_element ]; then
      return_code=0
      break
    fi
  done
  return $return_code
}

###################
# Executed script #
###################
exit_code=0

git_diff_output=$(git diff --name-only --cached)
[ ! -z "$git_diff_output" ]; are_staged_changes_present=$?

if [ $are_staged_changes_present -eq 0 ]; then
  # Stash changes in case nothing applies and things must be reverted
  tmp=$(git stash push)
  tmp=$((git stash apply --index) 2>&1)

  tmp=$((git commit --no-verify -m "pre-commit script temporary commit of raw changes") 2>&1)
  raw_commit_hash=$(git rev-parse HEAD)

  git_diff_unstaged_output=$(git diff --name-only)
  [ ! -z "$git_diff_unstaged_output" ]; are_unstaged_changes_present=$?
  if [ $are_unstaged_changes_present -eq 0 ]; then
    tmp=$(git stash push -m $pre_commit_stash_name)
  fi

  git reset --soft HEAD~1

  # For some reason, replacing whitespace is necessary for the split to work properly
  git_diff_output=$(echo $git_diff_output | sed -e 's/ / /g')

  # Split the `git diff` output into an array with newline as delimiter
  IFS=' ' read -r -a git_diff_filenames <<< "$git_diff_output"

  declare -a files_to_format

  # Get changed files that have a C/C++ file extension
  for git_diff_filename in "${git_diff_filenames[@]}"; do
    git_diff_file_extension=$(echo $git_diff_filename | sed -e 's/.*\.//g')
    # If git_diff_filename has a C/C++ file extension
    is_element_in_array "$git_diff_file_extension" "${c_and_cpp_file_extensions[@]}"
    if [ $? -eq 0 ]; then
      files_to_format+=($git_diff_filename) 
    fi
  done

  # clang-format command using .clang-format file if found, Google style otherwise
  clang_format_command_string="$git_root_directory/tools/clang-format.exe --style=file --fallback-style=Google" 

  clang_format_dry_run_output=""
  # If $files_to_format is not empty
  if [ ${#files_to_format[@]} -ne 0 ]; then
    clang_format_dry_run_output=$(($clang_format_command_string --dry-run ${files_to_format[@]}) 2>&1)
  fi

  # If dry run of clang-format contains changes
  if [ ! -z "$clang_format_dry_run_output" ]; then
    # Perform clang-format command with inplace edit
    tmp=$(($clang_format_command_string -i ${files_to_format[@]}) 2>&1)
    git add -u -- ${files_to_format[@]}

    formatted_files_string=$(git diff --name-only "$raw_commit_hash")
    formatted_files_string=$(echo $formatted_files_string | sed -e 's/ /\n/g')

    echo "Files have been automatically formatted and committed."
    echo "To see raw changes, compare with Git hash: $raw_commit_hash ."
    echo -e "Formatted files include:\n\e[1m\e[34m$formatted_files_string\n\e[0m"

    if [ $are_unstaged_changes_present -eq 0 ]; then
      tmp=$(git stash drop stash@{1})
      echo "Unstaged changes have been stashed under stash@{0} named \"$pre_commit_stash_name\"."
      echo "Access these changes by using \"git stash apply stash@{0}\" or \"git stash pop stash@{0}\"."
    else
      tmp=$(git stash drop stash@{0})
    fi
  else
    if [ $are_unstaged_changes_present -eq 0 ]; then
      # Undo everything; commit as-is
      tmp=$(git stash push)
      tmp=$(git stash drop)
      tmp=$(git stash drop)
      tmp=$((git stash apply --index) 2>&1)
    fi
    tmp=$(git stash drop stash@{0})
  fi
fi

exit $exit_code

