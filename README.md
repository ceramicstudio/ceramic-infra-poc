# TODO

- [ ] Add a README.md file to your repository
    - Should be a guide that explains how to configure and trigger an environment
- [X] Add a .gitignore file to your repository
- [X] Add .github/workflows/deploy-infrastructure.yml to your repository
- [X] Add .github/workflows/configure-node.yml to your repository
- [X] Add  .github/config/aws-s3-ipfs-policy.json
- [X] Add .github/config/aws-s3-ceramic-policy.json
- [X] Add ceramic-node.json to your repository, this will be the daemon config file once we copy it over with Ansible
- [ ] Figure out the ssh problem between ansible and github actions
- [ ] Attach appropriate IAM policies to the EC2 instance
- [ ] Open proper ports on the EC2 instance
- [ ] Setup repo secrets for ANSIBLE_PUBLIC_KEY
- [ ] https://docs.github.com/en/actions/security-guides/encrypted-secrets#storing-large-secrets


## Setting up SSH

[how to install gpg](https://mikeross.xyz/gpg-without-gpgtools-on-mac/)

**mac/linux**
1. Create a new key-pair (be sure to avoid committing the private key to the repo)
    ```bash
    ssh-keygen -f ./ansible-key -t rsa -b 4096
    ```
2. Encrypt the private key with gpg (you will commit this to the repo)
    ```bash
    ```bash
    gpg --symmetric --cipher-algo AES256 ansible-key
    ```
3. Enter a super strong password, but keep it handy.
4. Create a new secret in your repo called `SSH_PASSPHRASE` and paste the super strong password you used above into the value field.
5. Create a new secret in your repo called `ANSIBLE_PUBLIC_KEY` and paste the contents of `ansible-key.pub` into the value field.
6. Commit the encrypted private key to your repo in the .github/config directory
    ```bash
    git add .github/config/ansible-key.gpg
    git commit -m "Add encrypted ansible key"
    git push
    ```

 
