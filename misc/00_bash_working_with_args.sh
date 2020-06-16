#!/bin/bash

function print_args {
  echo " \$# would return the length of the \$@ arguments in the array - inside of the function: $#"
  echo " \${#vars} would return the length of the string itself: ${#vars}"
  echo " \${#vars[@] would return the length of the elements in the array:" ${#vars[@]}
}

echo " \$# would return the length of the \$@ arguments in the array: $# \t remember you are not inside of a function"

vars=($@)
if [[ $# -gt 1 ]]; then

  print_args $vars
else
  echo "please type args"
fi
