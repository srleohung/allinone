# git

## How to change a git commit message? (Sourcetree)
1. Select the previous commit you want to change
2. Right click and select `Rebase children of ${id} interactively...`
3. Click `Edit message`, enter a new message and click `OK`
4. Check File status to make sure there are no new changes (If it changes, it will fail)
5. Click `OK`
6. Enter the command `git push --force`