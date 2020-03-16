#!/bin/bash -x
echo "Welcome To TicTakToe"
declare -a array
playCount=0;

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
	if [[  ${array[0]} = ${array[4]} && ${array[0]} = ${array[8]} ]]
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
		((playCount--))
	fi;
}

function suggestPossibleHorizontalMoves()
{
local possibleMoves=""
	for (( i=0; i<${#array[@]}; i+=3 ))
	do
		if [[ ( ${array[$i]} == ${array[$i+1]} && ${array[$i]} == "$systemLetter" ) || ( ${array[$i]} == ${array[$i+1]} && ${array[$i]} == "$userLetter" ) ]]
		then
			possibleMoves=${array[$i+2]}
		elif [[ ( ${array[$i]} == ${array[$i+2]} && ${array[$i]}  == "$systemLetter" ) || ( ${array[$i]} == ${array[$i+2]} && ${array[$i]} == "$userLetter" ) ]]
		then
			possibleMoves=${array[$i+1]}
		elif [[ ( ${array[$i+1]} == ${array[$i+2]} &&  ${array[$i+1]}  == "$systemLetter" ) || ( ${array[$i+1]} == ${array[$i+2]} &&  ${array[$i+1]} == "$userLetter" ) ]]
		then
			possibleMoves=${array[$i]}
		fi;
	done
		if [[ $possibleMoves != "" ]]
		then
			emptyCheck="$( checkIsEmpty $possibleMoves )"
			if [[ $emptyCheck == "true" ]]
			then
				echo $possibleMoves
			fi;
		else
			suggestPossibleVerticalMoves
		fi;
}

function suggestPossibleVerticalMoves()
{
local possibleMoves=""
   for (( j=0; j<3; j++ ))
   do
      if [[  ( ${array[$j]} == ${array[$j+3]} && ${array[$j]} == "$systemLetter" )  ||  ( ${array[$j]} == ${array[$j+3]} && ${array[$j]} == "$userLetter" )  ]]
      then
         possibleMoves=${array[$j+6]}
      elif [[ ( ${array[$j]} == ${array[$j+6]} && ${array[$j]} == "$systemLetter" ) || ( ${array[$j]} == ${array[$j+6]} && ${array[$j]} == "$userLetter" ) ]]
      then
         possibleMoves=${array[$j+3]}
      elif [[ ( ${array[$j+3]} == ${array[$j+6]} &&  ${array[$j+3]} == "$systemLetter" )  || ( ${array[$j+3]} == ${array[$j+6]} &&  ${array[$j+3]} == "$userLetter" ) ]]
      then
         possibleMoves=${array[$j]}
      fi;
   done
		checkPositionEmpty="$( checkIsEmpty $possibleMoves )"
		if [[ $checkPositionEmpty == "true" ]]
		then
      echo $possibleMoves
		fi;
}

function suggestPossibleCrossMoves()
{
local possibleMoves=""
	if [[ ${array[0]} == ${array[4]} && ${array[0]} == "$systemLetter"  ]]
	then
		possibleMoves=${array[8]}
	elif [[ ${array[4]} == ${array[8]} && ${array[4]} == "$systemLetter" ]]
	then
		possibleMoves=${array[0]}
   elif [[ ${array[0]} == ${array[8]} && ${array[0]} == "$systemLetter" ]]
	then
		possibleMoves=${array[4]}
	elif [[ ${array[2]} == ${array[4]} && ${array[2]} == "$systemLetter" ]]
	then
		possibleMoves=${array[6]}
	elif [[ ${array[4]} == ${array[6]} && ${array[4]} == "$systemLetter" ]]
   then
      possibleMoves=${array[2]}
	elif [[ ${array[2]} == ${array[6]} && ${array[2]} == "$systemLetter" ]]
   then
      possibleMoves=${array[4]}
	fi;
		if [[ $possibleMoves != "" ]]
		then
		checkEmpty="$( checkIsEmpty $possibleMoves )"
			if [[ $checkEmpty == "true" ]]
			then
				echo $possibleMoves
			fi;
		else
			blockElementInCross
		fi;
}

function blockElementInCross()
{
local possibleMoves=""
	if [[ ${array[0]} == ${array[4]} && ${array[0]} == "$userLetter" ]]
	then
		possibleMoves=${array[8]}
	elif [[  ${array[4]} == ${array[8]} && ${array[4]} == "$userLetter" ]]
	then
		possibleMoves=${array[0]}
	elif [[ ${array[0]} == ${array[8]} && ${array[0]} == "$userLetter" ]]
	then
		possibleMoves=${array[4]}
	elif [[ ${array[2]} == ${array[4]} && ${array[2]} == "$userLetter" ]]
	then
		possibleMoves=${array[6]}
	elif [[ ${array[4]} == ${array[6]} && ${array[4]} == "$userLetter" ]]
	then
		possibleMoves=${array[2]}
	elif [[ ${array[2]} == ${array[6]} && ${array[2]} == "$userLetter" ]]
	then
		possibleMoves=${array[4]}
	fi;
		if [[ $possibleMoves != "" ]]
      then
      checkEmpty="$( checkIsEmpty $possibleMoves )"
         if [[ $checkEmpty == "true" ]]
         then
            echo $possibleMoves
         fi;
		else
			checkCornerAndCenter
		fi;
}

function checkCornerAndCenter()
{
local possibleMove=""
	for (( element=0; element<${#array[@]}; element+=2 ))
	do
		isPositionEmpty="$( checkIsEmpty $element )"
			if [[ $isPositionEmpty == "true" ]]
			then
				possibleMove="$element"
				break
			fi;
	done
		if [[ $possibleMove != "" ]]
		then
		echo $possibleMove
		else
			suggestPossibleSidesMoves
		fi;
}

function suggestPossibleSidesMoves()
{
local sideMove=""
	for (( side=1; side<=${#array[@]}; side+=2 ))
	do
		checkEmpty="$( checkIsEmpty $side )"
		if [[ $checkEmpty == "true" ]]
		then
			sideMove="$side"
			break
		fi
	done
		echo $sideMove
}

function systemPlay()
{
	horizotalMove="$( suggestPossibleHorizontalMoves )"
	crossMove="$( suggestPossibleCrossMoves )"
	if [[ $horizotalMove != "" ]]
	then
		array[$horizotalMove]="$systemLetter"
		displayBoard
	elif [[ $crossMove != "" ]]
	then
			array[$crossMove]="$systemLetter"
			displayBoard
	else
			playCount=$(($playCount-1))
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

while [[ playCount -le 9 ]]
do
	userPlay
	playCount=$(( $playCount+1 ))
	checkIsWin="$( checkWinningConditions )"
	if [[ $checkIsWin == "win" ]]
	then
		echo You Win
		break
	fi;
	systemPlay
	playCount=$(( $playCount+1 ));
	checkWin=$( checkWinningConditions )
	if [[ $checkWin == win ]]
	then
		echo system win
		break
   fi;
done
