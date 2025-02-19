#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR="/home/ec2-user/app-logs"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "Installing $2....$R Failure $N"
        exit 1
    else 
        echo -e "Installing $2.... $G Success $N"
    fi
}

CHECK_ROOT() {
    if [ $USERID -ne 0 ]
    then 
     echo "ERROR :: You must have sudo access to execute this script"
     exit 1
    fi
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files to be deleted: $FILES_TO_DELETE"

while read -r file
do
  echo "Deleting file: $file" &>>$LOG_FILE_NAME
  rm -rf $file
done <<< $FILES_TO_DELETE &>>$LOG_FILE_NAME


