#!/bin/bash
read -p "please input two string" str1 str2
if [ $str1 = $str2 ]
	then
		echo "equal"
elif [ $str1 > $str2 ]
	then
		echo $str1
#elif [ $str2 > $str1 ]
#	then
else
		echo $str2
fi
