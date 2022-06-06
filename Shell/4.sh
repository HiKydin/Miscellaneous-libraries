#!/bin/bash
if [ -e $1 ]
	then
		echo "exist"
else
	touch $1
	echo "//date: `date`" > $1
	echo "//author: gec" >> $1
	echo "//path: `pwd`" >> $1
	echo " " >> $1
	echo "#include <stdio.h>" >> $1
	echo " " >> $1
	echo "int main(int argc, char *argv)" >> $1
	echo "{" >> $1
	echo " " >> $1
	echo "	return 0;" >> $1
	echo "}" >> $1
	gedit $1
fi
