#!/usr/bin/env bash

#elements="element1 element2 element3"
IFS=":"
elements="element1:element2:element3"

for element in ${elements}; do
	echo "${element} is now separeted from the elements list"
done
