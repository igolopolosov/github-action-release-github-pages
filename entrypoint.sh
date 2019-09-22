#!/bin/sh -l

REPOSITORY_PATH="https://${GITHUB_ACCESS_TOKEN}@github.com/igolopolosov/igolopolosov.github.io.git"


echo "⭐️ Clone igolopolosov.github.io"
cd $GITHUB_WORKSPACE
git clone $REPOSITORY_PATH

git config --global user.email "${COMMIT_EMAIL}"
git config --global user.name "${COMMIT_NAME}"

echo "⭐️ Clean old files"
cd ./igolopolosov.github.io
rm bundle*
rm index.html

echo "⭐️ Copying started"
cd ../igor
cp -R ./dist ./igolopolosov.github.io

echo "⭐️ Commit changes"
cd ../igolopolosov.github.io
git add .
git commit -m "Make auto release"

echo "⭐️ Push changes"
git push $REPOSITORY_PATH master
