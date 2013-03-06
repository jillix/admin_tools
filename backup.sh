#!/bin/bash

if [ ! -z "$1" ]
then
    MACHINE_NAME="$1"
fi

if [ -z "$MACHINE_NAME" ]
then
    echo "Please provide a machine name. This will be passed to all backup scripts." 1>&2
    exit 1
fi

# overwrite an installed s3cmd in case a patched and more recent version is installed
PATH="$HOME/s3cmd:$PATH"
which s3cmd > /dev/null
if [ $? != 0 ]
then
    echo "Please install s3cmd or put it in the path" 1>&2
    exit 2
fi

function run_backup_scripts {

    for SCRIPT in "$1/admin/backup"/*
    do
        if [ -x "$SCRIPT" -a -f "$SCRIPT" ]
        then
            #echo "Running backup script: $SCRIPT"
            MACHINE_NAME="$MACHINE_NAME" $SCRIPT
            ERROR_CODE=$?
            if [ $ERROR_CODE != 0 ]
            then
                echo "Backup failed from machine: $MACHINE_NAME" 1>&2
                echo "while running the script: $SCRIPT" 1>&2
                exit $ERROR_CODE
            fi
        fi
    done
}


# this will search all the directories in the current working directory
for DIR in ./*
do
    if [ -d "$DIR/admin/backup" ]
    then
        run_backup_scripts "$DIR"
    fi
done

