#!/bin/sh -l

if [ "$4" != "latest" ]; then
    apk add --no-cache "clang$4-extra-tools"
else
    apk add --no-cache clang-extra-tools
fi

clang-format --version

# if check only

if [ "$1" = "true" ]; then
    echo "Checking formatting..."
    git clang-format --diff --style="$2" --extensions="$3" -v HEAD^
    exit 0
fi

# if check and format

if [ "$1" = "false" ]; then
    echo "Formatting files..."
    cd "$GITHUB_WORKSPACE" || exit 2
    git diff HEAD^ --name-only
    git clang-format --style="$2" --extensions="$3" -v HEAD^
    exit 0
fi
