1. Make sure you have Go installed on your system.
2. Create pre-commit file and add it in .git/hooks
```
ln -s $(pwd)/scripts/pre-commit .git/hooks/pre-commit
```
3. Grant execution rights to the script file if not already done
```
chmod +x scripts/pre-commit
```
4. Let's try to test the script
```
.git/hooks/pre-commit
```
5. If you want this script to work, write the following command in the console
```
git config --local hooks.gitleaksenabled true
```
if you want to disable the script
```
git config --local hooks.gitleaksenabled false
```
6. Now you can use gitleaks