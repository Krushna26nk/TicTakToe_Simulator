#!/bin/bash -x
echo "Welcome To TicTakToe"
declare -a array

for (( count=0; count<9; count++ ))
do
	array[$count]=$count
done

function displayBoard()
{
	for (( element=0; element<9; element+=3 ))
	do
		echo "${array[$element]} | ${array[$element+1]} | ${array[$element+2]}"
		echo "---------"
	done
}


