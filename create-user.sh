#!/bin/zsh

# this is meant to be run as root

username=$1

if [ "$username" == "" ]; then
    echo "Username required at position 1."
    exit 1
fi


# create the user
adduser "$username"

# create .ssh dir
mkdir "/home/$username/.ssh"
touch "/home/$username/.ssh/authorized_keys"
chmod 600 "/home/$username/.ssh/authorized_keys"
chown -R "$username":"$username" "/home/$username/.ssh"

# give user sudo access
usermod -aG adm "$username"
usermod -aG systemd-journal "$username"
usermod -aG sudo "$username"

echo "You still need to add the users public key to /home/$username/.ssh/authorized_keys"
