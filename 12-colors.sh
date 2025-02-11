#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "Installing $2....$R Failure"
        exit 1
    else 
        echo -e "Installing $2.... $G Success"
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
    echo -e "mysql is already..... $Y Installed"
fi   


dnf list installed git

  if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing git"
else
    echo -e "git is already..... $Y Installed"
fi 