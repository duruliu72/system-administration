#!/usr/bin/env bash
current_env="a";
subsh_stdout_var=$(
current_env="b"
echo "${current_env}"
)
echo "${current_env}"
echo "${subsh_stdout_var}"

