#!/bin/bash

json='{"tag": "iki", "mesaj": "tes tags_at_commit sometags project"}'
while(true); do sleep 1; echo "$json"  > /proc/1/fd/1 2>/proc/1/fd/2;  done;
