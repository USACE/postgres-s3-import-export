#!/usr/bin/env bash

today=`date +"%Y-%m-%d"`
S3_PATH=${AWS_S3_BUCKET}/${S3_DB_EXPORT_DIR}/${today}
TABLE_ARRAY=($EXPORT_TABLES)

TABLES=""
for i in "${TABLE_ARRAY[@]}"
do
    : 
   
   TABLES=$TABLES" -t $SCHEMA.$i"
done


printf "\n1) Running pg_dump, saving to local storage (export.dump).\n"
pg_dump ${TABLES} --format=c --compress 5 --username $PGUSER --schema $SCHEMA --data-only  > /app/data/export.dump
# echo ${TABLES}
printf "\n2) Copying export.dump to $S3_PATH/export.dump.\n\n"
aws --endpoint-url $AWS_S3_ENDPOINT s3 cp /app/data/export.dump s3://$S3_PATH/export.dump

printf "\nDONE.\n\n"