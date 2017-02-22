#!/bin/bash

echo "Select the NAME of the path:";
read PATCH_NAME
echo "Select the branch to export:";
read BRANCH
echo "Select the START node for this patch:";
read FROM_NODE
echo "Select the END node for this patch:";
read TO_NODE

cd $TARGET_GIT_DIR


COMMIT_COUNT=$(git rev-list --count $TO_NODE);
COMMIT_HASH=$(git rev-parse $TO_NODE | head -c9);




FILES_TO_EXPORT=$(git diff --name-only --diff-filter=ACMRTUXB $FROM_NODE $TO_NODE)
FULL_FILE_NAME=$COMMIT_COUNT."$PATCH_NAME"_"$FROM_NODE".patch

git archive $BRANCH --output="$TARGET_PATCH_DIR""$FULL_FILE_NAME".tar.gz $FILES_TO_EXPORT


FILE_COUNT=$(tar -tzf "$TARGET_PATCH_DIR""$FULL_FILE_NAME".tar.gz | wc -l)
echo "Created $FULL_FILE_NAME ($FILE_COUNT files)"
