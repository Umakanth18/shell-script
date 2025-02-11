#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "ERROR :: You must have sudo access to execute this script"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install Mysql -y
    id [ $? -ne 0 ]
    then
        echo "Installing Mysql....Failure"
        exit 1
    else 
        echo "Installing Mysql is....Success"
    fi
else
    echo "Mysql is already..... Installed"
fi   


  dnf list installed git

  if [ $? -ne 0 ]
then
    dnf install git -y
    id [ $? -ne 0 ]
    then
        echo "Installing git....Failure"
        exit 1
    else 
        echo "Installing git is....Success"
    fi
else
    echo "git is already..... Installed"
fi 



