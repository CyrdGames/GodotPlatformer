#!/bin/bash

# FIXME: see if cpplint is needed/what we want
# pip install cpplint

#####################
# Install Git Hooks #
#####################
git_root_directory=$(git rev-parse --show-toplevel)

pre_commit_hook_string="\
#!/bin/bash \n\
git_root_directory=\$(git rev-parse --show-toplevel) \n\
\$git_root_directory/scripts/git_hooks/pre-commit.sh \n\
exit \$? \n\
"

echo -e "$pre_commit_hook_string" > "$git_root_directory/.git/hooks/pre-commit"
