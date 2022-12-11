#!/bin/bash

json='{"tag": "mirror", "mesaj": "gitlab mirror mesajı"}'
# while(true); do sleep 2; echo "$json"  > /proc/1/fd/1 2>/proc/1/fd/2;  done;
echo "$json"  > /proc/1/fd/1 2>/proc/1/fd/2
