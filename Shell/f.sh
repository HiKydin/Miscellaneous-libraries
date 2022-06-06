#!/bin/bash
a=34
b=66
add()
{
	echo "$1+$2=`expr $1 + $2`"
}
add $a $b
sub()
{
	echo "$1-$2=`expr $1 - $2`"
}
sub $a $b
mul()
{
	echo "$1*$2=`expr $1 \* $2`"
}
mul $a $b
div()
{
	echo "$1/$2=`expr $1 / $2`"
}
div $a $b
