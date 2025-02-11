#!/bin/bash

USERID=$(id -u)

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo "Installing $2....Failure"
        exit 1
    else 
        echo "Installing $2....Success"
    fi
}

if [ $USERID -ne 0 ]
then 
    echo "ERROR :: You must have sudo access to execute this script"
    exit 1
fi

dnf list installed Mysql

if [ $? -ne 0 ]
then
    dnf install Mysql -y
    VALIDATE $? "Installing Mysql"
else
    echo "Mysql is already..... Installed"
fi   


dnf list installed git

  if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git"
else
    echo "git is already..... Installed"
fi 