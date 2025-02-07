#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "ERROR :: You must have sudo access to execute this script"
    exit 22
fi

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "Installing Git is....Failure"
    exit 1
else
    echo "Installing GIT IS....Success"
fi 

dnf install git -y

if [ $? -ne 0 ]
then
    echo "Installing GIT is....Failure"
    exit 1
else
    echo "Installing GIT is.....Success"
fi        