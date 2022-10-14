#!/bin/sh

# Decrypt the file
mkdir $HOME/secrets
# --batch to prevent interactive command
# --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase="$SSH_PASSPHRASE" \
--output $HOME/secrets/ansible-key ansible-key.gpg

chmod 600 $HOME/secrets/ansible-key