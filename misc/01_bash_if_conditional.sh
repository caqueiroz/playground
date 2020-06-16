#!/bin/bash 
echo "bare in mind bash and korn shell"
echo "\$var=something"
var=something
echo " [[ \"\$var\" == \"*somethi*\" ]] "
if [[ "$var" == somethi* ]]; then
  echo "\$var = $var"
else
  echo "var not equal $var"
fi
echo "double brackets, same features as single brackets but you can do some string operations and including some regex and string with spaces"
echo -e "\n\n\n \\n using echo -e or printf to print a new line \n\n\n "
echo "-z -> true if \$var is empty" 
echo "-n -> true if \$var length is greater than 0"
echo "-f -> true when file exists and it is a regular file"
echo "-h -> true if it a symbolic link"
echo "-d -> true if it is a directory"
echo "-r, -w, -> true if it is a file and readable or writable"
echo "-e -> true if it is a file regardless socket, device, etc"
echo -e "\n\n"
echo "Arithmetic: -gt -lt -eq"

echo -e "\n\n\n"

echo "parentisis is more related to korn shell"
echo "shell with parentisis: if (( \$? == 0 ))"
echo "(( NUM > NUM1))   ((NUM < NUM1))    ((NUM != NUM2)) >= and  <="
echo "|| and &&"


function double_brackets {
  if [[ $1 == *special* ]]; then
    echo "the word special matches to the content of the variable and the variable content is $1"
  else
    echo "the variable does not contain the word special in it, it contains $1"
fi

}
echo -e "\n\n\n calling double_brackets function passing speciality as parameter"
double_brackets speciality
if (( $? == 0 )); then
  echo "execution successful with exit code 0"
fi

