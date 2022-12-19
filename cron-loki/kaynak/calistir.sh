#!/bin/bash

json='{"tag": "redmine-clone", "mesaj": "redmine clone oldu"}'
#while(true); do sleep 1; echo "$json"  > /proc/1/fd/1 2>/proc/1/fd/2;  done;
echo "$json"  > /proc/1/fd/1 2>/proc/1/fd/2
