#!/usr/bin/env bash

if [ $MODE = "export" ]; then
  /app/export.sh
elif [ $MODE = "import" ]
then
  /app/import.sh
else
  echo "Unknown mode"
fi
