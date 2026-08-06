#!/usr/bin/env bash

echo "Number of arguments: $#"
echo "All arguments: $@"

for arg in "$@";do
	echo "Argument: $arg"
done
