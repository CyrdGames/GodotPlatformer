# GodotPlatformer
Platformer game using the Godot game engine

# Development
We use clang-format to lint and cppcheck which run on a pre-commit hook.

Please install `cppcheck` (version 2.0 or later) and ensure that it is added to PATH for the linter to work properly during development.

After that, run the `setup.sh` script, and the pre-commit hook for the linter should be set up.

```
./scripts/setup.sh
```
