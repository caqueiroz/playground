#!/bin/bash

function http_test {
echo $1
until $(curl --output /dev/null --silent --head --fail $1); do
  printf '.'
  sleep 5
done
}

if [ $# == 1 ]; then
    http_test $@
else
  echo "one argument, http://test.com:8080"
fi
     
