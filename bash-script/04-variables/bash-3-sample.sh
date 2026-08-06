#!/usr/bin/env bash
IFS=','
args_at=$@
echo "--> Output of \$@: $@"
echo "    Output of \$@ in a for loop:"
for arg in ${args_at};do
	echo "     ${arg}"
done

