#!/usr/bin/env bash
readonly MIN_ARGS=1
readonly MAX_ARGS=10

if [[ $# -ne "${MIN_ARGS}" || $# -gt "${MAX_ARGS}" ]]; then
	echo "Expected between ${MIN_ARGS} and ${MAX_ARGS}"
	exit 1
fi
echo "Command line arguments within expected range"


exit 0

