#!/bin/bash -x
echo "Welcome To TicTakToe"
declare -a array
count=0;
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

value=$(( RANDOM % 2 ))
if [[ $value -eq 0 ]]
then
	userLetter="X"
	systemLetter="O"
elif [[ $value -eq 1 ]]
then
	userLetter="O"
	systemLetter="X"
fi;

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

function checkIsEmpty()
{
argument=$1
	if [[ ${array[$argument]} != "$userLetter" && ${array[$argument]} != "$systemLetter" ]]
	then
		echo "true"
	else
		echo "false"
	fi;
}

function checkElementHorizontally()
{
local result=""
	for(( row=0; row<${#array[@]}; row+=3 ))
	do
		if [[ ${array[$row]} = ${array[$row+1]} && ${array[$row]} = ${array[$row+2]} ]]
		then
			result="win"
		fi;
	done
	echo $result
}

function checkElementVertically()
{
local result=""
	for (( coloumn=0; coloumn<${#array[@]}; coloumn++ ))
	do
		if [[ ${array[$coloumn]} = ${array[$coloumn+3]} && ${array[$coloumn]} = ${array[$coloumn+6]} ]]
		then
			result="win"
		fi;
	done
		echo $result
}

function checkElementInCross()
{
	if [[ ${array[0]} = ${array[4]} && ${array[0]} = ${array[8]} ]]
	then
		echo "win"
	elif [[ ${array[2]} = ${array[4]} && ${array[2]} = ${array[6]} ]]
	then
		echo "win"
	fi;
}

function userPlay()
{
	read -p "Enter the position:" position
	checkPositionIsEmpty="$( checkIsEmpty $position )"
	if [[ $checkPositionIsEmpty == "true" ]]
	then
		array[$position]="$userLetter"
		displayBoard
	else
		((count--))
	fi;
}

function systemPlay()
{
	numberPosition=$(( RANDOM % 9 ))
	checkPositionIsEmpty="$( checkIsEmpty $numberPosition )"
	if [[ $checkPositionIsEmpty == "true" ]]
	then
		array[$numberPosition]="$systemLetter"
		displayBoard
	else
		((count--))
		echo "position is already filled,U can play"
	fi;
}

function checkWinningConditions()
{
	checkHorizontal="$( checkElementHorizontally )"
	checkVertical="$(  checkElementVertically )"
	checkCross="$(  checkElementInCross )"
	if [[ $checkHorizontal == "win" || $checkVertical == "win" || $checkCross == "win" ]]
   then
		echo "win"
	fi;
}

for (( playCount=0; playCount<9; playCount++ ))
do
	userPlay
	count=$(( $count+1 ))
	checkIsWin="$( checkWinningConditions )"
	if [[ $checkIsWin == "win" ]]
	then
		echo "You Win"
		break
	elif [[ $count -eq 9 ]]
	then
		break
	fi;
	systemPlay
	count=$(( $count+1 ))
	checkWin="$( checkWinningConditions )"
	if [[ $checkWin == "win" ]]
	then
		echo "system win"
		break
   elif [[ $count -eq 9 ]]
   then
      break
   fi;
done




