#!/usr/bin/env bash
#Get the process ID of the parent shell
parent_pid=$$;
#Use command substitution to get the process ID of the subshell

(
subshell_pid=$BASHPID
echo "Inside subshell: subshell_pid=${subshell_pid}"
)
echo "Outside subshell: parent_pid=${parent_pid}"
