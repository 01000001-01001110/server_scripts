#!/bin/bash
#Alan's Default Ubuntu Sudoer Setup
#Version 0.0.1
#Date 3/30/2021
    echo " User Creation "
    # Am i Root user?
        if [ $(id -u) -eq 0 ]; then
            read -p "Enter username : " username
            read -s -p "Enter password : " password
            egrep "^$username" /etc/passwd >/dev/null
            if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
            else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
            fi
        else
            echo "Only root may add a user to the system."
            exit 2
        fi
    echo "                          "
    echo "  Add $username to sudoer  "
    usermod -aG sudo $username
