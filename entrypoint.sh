#!/bin/sh -l

echo "⭐️ Start"

echo "⭐️ Configure git"

apk add jq
COMMIT_EMAIL=`jq '.pusher.email' ${GITHUB_EVENT_PATH}`
COMMIT_NAME=`jq '.pusher.name' ${GITHUB_EVENT_PATH}`
COMMIT_MESSAGE=`jq '.commits[0].message' ${GITHUB_EVENT_PATH}`

git config --global user.email "${COMMIT_EMAIL}"
git config --global user.name "${COMMIT_NAME}"

REPOSITORY_PATH="https://${GITHUB_ACCESS_TOKEN}@github.com/igolopolosov/$GITHUB_PAGES_REPO_NAME.git"

echo "⭐️ Clone $GITHUB_PAGES_REPO_NAME"
cd $GITHUB_WORKSPACE
git clone $REPOSITORY_PATH

echo "⭐️ Clean old files"
cd ./$GITHUB_PAGES_REPO_NAME
rm bundle*
rm index.html

echo "⭐️ Copying started"
cd ../dist
cp -R * ../$GITHUB_PAGES_REPO_NAME

echo "⭐️ Commit changes"
cd ../$GITHUB_PAGES_REPO_NAME
git add .
git commit -m "Release: $COMMIT_MESSAGE"

echo "⭐️ Push changes"
git push $REPOSITORY_PATH master

echo "⭐️ Finish"
