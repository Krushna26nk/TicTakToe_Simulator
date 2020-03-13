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

function suggestLetter()
{
local userLetter="";
value=$(( RANDOM % 2 ))
if [[ $value -eq 0 ]]
then
	userLetter="X"
elif [[ $value -eq 1 ]]
then
	userLetter="O"
fi;
	echo "you can play with letter $userLetter"
}

function toss()
{
number=$(( RANDOM % 2 ))
if [[ $number -eq 0 ]]
then
	echo "user play first"
elif [[ $number -eq 1 ]]
then
	echo "system can play first"
fi;
}
displayBoard
