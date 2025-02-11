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

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Installing mysql"
else
    echo "mysql is already..... Installed"
fi   


dnf list installed git

  if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing git"
else
    echo "git is already..... Installed"
fi 