#!/bin/bash

#  .
# ..: P. Chang, philip@physics.ucsd.edu

cores=20

JOBTXTFILE=joblist

# filter some jobs
if [ "x${1}" != "x" ]; then
  cat $1 | grep -v \# | grep $1 > /tmp/jobs.txt
else
  cat $1 | grep -v \# > /tmp/jobs.txt
fi

# run the job in parallel
xargs --arg-file=/tmp/jobs.txt \
      --max-procs=$cores  \
      --replace \
      --verbose \
      /bin/sh -c "{}"

#eof
