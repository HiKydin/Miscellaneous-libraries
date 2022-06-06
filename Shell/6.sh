#!/bin/bash
n=0
for i in `seq 1 100`
do
	n=` expr $n + $i`
done
	echo "$n"
