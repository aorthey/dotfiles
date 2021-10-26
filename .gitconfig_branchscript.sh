#!/usr/bin/bash
printf "%0.s#" {1..80}
echo
git branch -vv
printf "%0.s#" {1..80}
echo
for ref in $(git for-each-ref --sort=authorname --format='%(authorname) %(refname)' | grep "Andreas Orthey")
do
    if [[ $ref == *"origin"* ]]; then
      git --no-pager log $ref -n 1 --oneline
    fi
done


