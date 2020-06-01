#!/bin/bash

git_root_directory=$(git rev-parse --show-toplevel)

exit_code=0

include_directories="\
-I src \
-I godot-cpp/include/core \
-I godot-cpp/include/gen \
"

suppress_directories="\
--suppress=*:godot-cpp/* \
"

suppress_errors="\
--suppress=unusedFunction \
--suppress=missingIncludeSystem \
--suppress=unmatchedSuppression \
"

# Sample C11 cppcheck use if needed
# cppcheck_output=$(cppcheck --std=c11 --enable=all --error-exitcode=2 $suppress_errors src/*.c src/*.h)
cppcheck_output=$(cppcheck --std=c++14 --enable=all --error-exitcode=2 $include_directories $suppress_directories $suppress_errors src/)
exit_code=$?

echo "$cppcheck_output"
exit $exit_code
