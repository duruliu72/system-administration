#!/usr/bin/env bash

ehco "Hello!"
if [[ ! $? -eq 0 ]]; then
	echo "Error: Failed to run command."
	exit 1
fi

echo "Command ran successfully"
exit 0

