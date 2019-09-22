# github-action-release-github-pages

This action commits files from your build folder of your repository to github pages repo. It creates new commit in github pages repo with content of build folder.

You can use this action when thress of this things are applicable to your case:

✅ your website source code and `github pages` are **different** repositories

✅ you can build your website before on previous steps

✅ you need to release / commit and push new build to `github pages` repo every time you change something in your source code

## Example usage

You can view an example of this below.

```yml
name: Build and Release
on: [push]
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [10.x]

    steps:
    - uses: actions/checkout@v1
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v1
      with:
        node-version: ${{ matrix.node-version }}
    - name: npm install, build
      run: |
        npm install
        npm run build
    - name: Release Github Pages
      uses: igolopolosov/github-action-release-github-pages@master
      env:
        GITHUB_ACCESS_TOKEN: ${{ secrets.GITHUB_ACCESS_TOKEN }}
        GITHUB_PAGES_REPO_AUTHOR: igolopolosov
        GITHUB_PAGES_REPO_NAME: igolopolosov.github.io
        GITHUB_PAGES_RELEASE_BRANCH: master
        PROJECT_BUILD_FOLDER: dist
        GITHUB_PAGES_CLEANUP_SCRIPT: "rm bundle* && rm index.html"
```

## Configuration

The `env` portion of the workflow **must** be configured before the action will work. You can add these in the `env` section found in the examples above. Any `secrets` must be referenced using the bracket syntax and stored in the GitHub repositories `Settings/Secrets` menu. You can learn more about setting environment variables with GitHub actions [here](https://help.github.com/en/articles/workflow-syntax-for-github-actions#jobsjob_idstepsenv).

Below you'll find a description of what each option does.

| Key  | Value Information | Type |
| ------------- | ------------- | ------------- |
| `GITHUB_ACCESS_TOKEN`  | In order to commit new release build of your page you must provide the action with a GitHub personal access token with read/write permissions. You can [learn more about how to generate one here](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line). This **should be stored as a secret.**  | `secrets` |
| `GITHUB_PAGES_REPO_AUTHOR`  | Name of GitHub user having github pages repository. | `env` |
| `GITHUB_PAGES_REPO_NAME`  | Just name of your github pages repository. Usually it's `%username%.github.io`. | `env` |
| `GITHUB_PAGES_RELEASE_BRANCH`  | The branch on github pages repo you wish to release to, for example `master`.  | `env` |
| `PROJECT_BUILD_FOLDER`  | The folder in your repository that you want to deploy. If your build script compiles into a directory named `build` you'd put it here. | `env` |
| `GITHUB_PAGES_CLEANUP_SCRIPT`  | Cleanup script to remove files from github pages repo which are going to be replaced with new build. It runs inside of Docker container which powers the action to run simple bash commands.  | `env` |
