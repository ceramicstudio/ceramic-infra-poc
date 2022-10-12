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
