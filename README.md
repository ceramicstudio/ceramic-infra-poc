# Your Ceramic Quick Start Guide


## Global Needs

### Pre-reqs
[how to install gpg](https://mikeross.xyz/gpg-without-gpgtools-on-mac/)

### Setting up the repo

**mac/linux**
1. Create a new key-pair (be sure to avoid committing the private key to the repo)
    ```bash
    ssh-keygen -f ./ansible-key -t rsa -b 4096 -C ansible-key
    ```
1. Create a new secret in your repo called `ANSIBLE_PUBLIC_KEY` and paste the contents of `ansible-key.pub` into the value field.
1. Encrypt the private key with gpg (you will commit this to the repo)
    ```bash
    gpg --symmetric --cipher-algo AES256 ansible-key
    ```
1. Enter a super strong password, but keep it handy.
1. Create a new secret in your repo called `SSH_PASSPHRASE` and paste the super strong password you used above into the value field.
1. Make sure the encrypted private key is in the proper directory
    ```bash
    mv ansible-key.gpg .github/config/ansible-key.gpg    ```
1. Commit the encrypted private key to your repo in the .github/config directory
    ```bash
    git add .github/config/ansible-key.gpg
    git commit -m "Add encrypted ansible key"
    git push
    ```

### Configuring a cloud provider

<details>
<summary>AWS Instructions</summary>
You need to set the following info from your aws account
That means you also need an aws account!

`AWS_ACCESS_KEY_ID`

`AWS_SECRET_ACCESS_KEY`
</details>

<details>
<summary>GCP Instructions</summary>
Not yet implemented
</details>

<details>
<summary>Ditgial Ocean Instructions</summary>
Not yet implemented
</details>

## Deploying the infrastructure

Some general instructions about how to use Actions

 
