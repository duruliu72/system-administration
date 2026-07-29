#!/usr/bin/env bash
var="a"
subshell=$(var="b";echo "$var")
echo "${var}"
echo "${subshell}"
