#!/bin/bash
set -xe
git diff-tree --no-commit-id --name-only -r $CODEBUILD_RESOLVED_SOURCE_VERSION
