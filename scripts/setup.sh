#!/bin/bash

#####################
# Install Git Hooks #
#####################
git_root_directory=$(git rev-parse --show-toplevel)

pre_commit_hook_string="\
#!/bin/bash \n\
./scripts/git_hooks/pre-commit.sh \n\
exit \$? \n\
"

pre_push_hook_string="\
#!/bin/bash \n\
./scripts/git_hooks/pre-push.sh \n\
exit \$? \n\
"

echo -e "$pre_commit_hook_string" > "$git_root_directory/.git/hooks/pre-commit"
echo -e "$pre_push_hook_string" > "$git_root_directory/.git/hooks/pre-push"

