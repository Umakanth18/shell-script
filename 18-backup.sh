#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if user is not providing no. of days we are taking 14 days as default

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIME_STAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

USAGE(){
   echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional>"
   exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/

if [ $# -lt 2 ]
then 
    USAGE
fi    

if [ ! -d $SOURCE_DIR ]
then 
   echo -e " $R $SOURCE_DIR $N Does not exist....Please check"
   exit 1
fi

if [ ! -d $DEST_DIR ]
then 
   echo -e " $R $DEST_DIR $N Does not exist....Please check"
   exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] # true if there are files to zip
then 
   echo "Files are: $FILES"
   ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
   find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
   if [ -f "$ZIP_FILE" ]
   then 
       echo -e "Successfully created Zip file for files older than $DAYS"
       while read -r file
       do
           echo "Deleting file: $file" &>>$LOG_FILE_NAME
           rm -rf $file
           echo: "Deleted file: $file"
       done <<< $FILES_TO_DELETE &>>$LOG_FILE_NAME
    else
       echo -e "$R ERROR: $N Filed to create Zip file "
       exit 1
    fi

else   
   echo "No Files found older tahn $DAYS"
fi