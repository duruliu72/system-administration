#!/usr/bin/env bash
IFS=','
args_at="$@"
args_star="$*"

print_section_header(){
   local section_name="$1"
   echo "=================================" 
   echo "=  Section ${section_name}      ="
   echo "=================================" 
}
 print_section_header "1: Ysubg \$@ Variable"
 echo "---> Output of \$@: $@"
 echo "     Output of \$@ in a for loop:"
for arg in ${args_at};do
 echo " $arg"
done

print_section_header "2: Ysubg \$* Variable"
echo "---> Output of \$*: $*"
echo "     Output of \$* in a for loop:"
for arg in ${args_star};do
	echo "${arg}"
done
