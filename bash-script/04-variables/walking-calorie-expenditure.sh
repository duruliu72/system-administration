#!/usr/bin/env bash

steps=$1
calories_per_step=0.04

calories_burned=$(echo "$steps * $calories_per_step" | bc -l)

echo "Calories burned for $steps: $calories_burned"

exit 0
