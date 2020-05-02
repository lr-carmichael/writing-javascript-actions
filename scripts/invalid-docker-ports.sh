#!/bin/bash

## get all the ports that are exposed
exposed_ports=$(for line in `grep -A1 'ports\:' ./local_dev/docker-compose.yml | grep -v 'ports\:' | grep -v '\-\-'`
do
  echo "${line}";
# remove starting quotes, remove lines with -, remove empty lines, trim after :  
done | sed 's/^"//g' | sed 's/^-//g' | sed '/^$/d' | sed 's/:.*//')

# check range of ports for restricted range
for port in `echo ${exposed_ports} | sed 's/ /\n/g'`
do
  if (( ${port} >= 20000 && ${port} <= 36384 )); then
  # make it fail:
  #if (( ${port} >= 20000 && ${port} <= 41333 )); then
    echo "${port} is in a restricted range for Hyper-V"
    exit 1
  fi
done
