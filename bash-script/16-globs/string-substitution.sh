#!/usr/bin/env bash
original_string="The quick brown dog."
echo "Original string: ${original_string}"
modified_string="${original_string/dog/fox}"
echo "Modified string: ${modified_string}"
string="Hello, World"
echo "Original string: ${string}"
substring="${string:0:5}"
echo "Substring: ${substring}"
