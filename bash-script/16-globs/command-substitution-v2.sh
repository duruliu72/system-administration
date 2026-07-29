#!/usr/bin/env bash
if [[ -z "${1}" ]]; then
   echo "Please specify a directory."
   exit 1
fi
file_count=$(find ${1} -type f | wc -l)
echo "${file_count}"
