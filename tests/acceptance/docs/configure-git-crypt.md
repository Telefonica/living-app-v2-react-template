# Git Crypt:
1. Install git-crypt: <br>
   Linux:
   ```bash
      sudo apt install git-crypt
   ```
   Mac:
   ```bash
      brew install git-crypt
   ```

2. Add ".gitattributes" to the project root (This file is already included in template - Check that all secrets files are included)
   ```
      **/settings/*private*.json filter=git-crypt diff=git-crypt
      **/settings/**/*private*.json filter=git-crypt diff=git-crypt
      **/settings/**/properties/*private*.json filter=git-crypt diff=git-crypt
      **/resources/kubeconfigs/* filter=git-crypt diff=git-crypt
      **/settings/*toolium.cfg filter=git-crypt diff=git-crypt
      .gitattributes !filter !diff
   ```

3. Initialize git-crypt
   ```
      git-crypt init
   ```

4. Export the key:
   ```bash
      git-crypt export-key ~/carpeta/key.key
   ```

5. Get base64 project key, and add it to github.<br>
   Linux:
   ```bash
   git-crypt export-key ./tmp-key && cat ./tmp-key | base64 | xclip && rm ./tmp-key
   cat ./project-key.key | base64
   ```
   Mac:
   ```bash
   git-crypt export-key ./tmp-key && cat ./tmp-key | base64 | pbcopy && rm ./tmp-key
   cat ./project-key.key | base64
   ```
