#!/bin/bash -x

function test_append {

for a in {1..100}
do
  echo $a >> $1 
done


}


function compress {
  dest="${i}_`date +"%Y-%m-%d_%H-%M-%S"`.gz"
  gzip -c $i > $dest 
  if [ $? -ne 0 ]; then
   exit 1 
  fi
  test_append $i 
}


function main {
 for i in $@
 do
   echo "preparing" 
   size_pre=$( stat --printf=%s $i )
   echo "compressing"
   if [ -f "$i" ]; then
     compress $i
   else
     echo "file doesn't exist"
  fi 
  echo "truncating"
  size_post=$( stat --printf=%s $i )
  truncatesize=$(expr $size_post - $size_pre )
  truncate $i -s $truncatesize
done
}




if [[ $# -gt 0 ]]; then
  main $@
else
  echo "enter the files to be rotated"
fi

