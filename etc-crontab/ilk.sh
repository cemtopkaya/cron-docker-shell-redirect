#!/bin/bash

json='{"commit_id": "b8f2b8b", "environment": "test", "tags_at_commit": "sometags", "project": "someproject", "current_date": "09/10/2014", "version": "someversion"}'
while(true); do sleep 1; echo "$json"  > /proc/1/fd/1 2>/proc/1/fd/2;  done;
