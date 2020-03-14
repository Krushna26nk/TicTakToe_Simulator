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

function suggestPossibleHorizontalMoves()
{
local possibleMoves=""
	for (( i=0; i<${#array[@]}; i+=3 ))
	do
		if [[ ${array[$i]} == ${array[$i+1]} && ${array[$i]} == "$systemLetter" ||  ${array[$i]} == ${array[$i+1]} && ${array[$i]} == "$userLetter"  ]]
		then
			possibleMoves=${array[$i+2]}
		elif [[ ${array[$i]} == ${array[$i+2]} && ${array[$i]} == "$systemLetter" ||  ${array[$i]} == ${array[$i+2]} && ${array[$i]} == "$userLetter" ]]
		then
			possibleMoves=${array[$i+1]}
		elif [[ ${array[$i+1]} == ${array[$i+2]} &&  ${array[$i+1]} == "$systemLetter" ||  ${array[$i+1]} == ${array[$i+2]} &&  ${array[$i+1]} == "$userLetter"  ]]
		then
			possibleMoves=${array[$i]}
		fi;
	done
		echo $possibleMoves
}

function suggestPossibleVerticalMoves()
{
local possibleMoves=""
   for (( j=0; j<3; j++ ))
   do
      if [[ ${array[$j]} == ${array[$i+3]} && ${array[$j]} == "$systemLetter" ||  ${array[$j]} == ${array[$i+3]} && ${array[$j]} == "$userLetter" ]]
      then
         possibleMoves=${array[$j+6]}
      elif [[ ${array[$j]} == ${array[$j+6]} && ${array[$j]} == "$systemLetter" || ${array[$j]} == ${array[$j+6]} && ${array[$j]} == "$userLetter"  ]]
      then
         possibleMoves=${array[$j+3]}
      elif [[ ${array[$j+3]} == ${array[$j+6]} &&  ${array[$j+3]} == "$systemLetter" || ${array[$j+3]} == ${array[$j+6]} &&  ${array[$j+3]} == "$userLetter" ]]
      then
         possibleMoves=${array[$j]}
      fi;
   done
      echo $possibleMoves
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
	echo $possibleMoves
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
		echo $possibleMoves
}

function systemPlay()
{
	horizotalMove="$( suggestPossibleHorizontalMoves )"
	verticalMove="$( suggestPossibleVerticalMoves )"
	crossMove="$( suggestPossibleCrossMoves )"
	blockCrossElement="$( blockElementInCross )"
	if [[ $horizotalMove != "" ]]
	then
		emptyCheck="$( checkIsEmpty $horizotalMove)"
		if [[ $emptyCheck == "true" ]]
		then
		array[$horizotalMove]="$systemLetter"
		displayBoard
		fi
	elif [[ $verticalMove != "" ]]
	then
		isEmpty="$( checkIsEmpty $verticalMove )"
		if [[ $isEmpty == "true" ]]
		then
		array[$verticalMove]="$systemLetter"
		displayBoard
		fi
	elif [[ $crossMove != "" ]]
	then
		isPositionEmpty="$( checkIsEmpty $crossMove )"
		if [[ $isPositionEmpty == "true" ]]
		then
			array[$crossMove]="$systemLetter"
			displayBoard
		fi
	elif [[ $blockCrossElement != "" ]]
	then
		isEmpty="$( checkIsEmpty $c )"
		if [[ $blockCrossElement == "true" ]]
		then
			array[$blockCrossElement]="$systemLetter"
			displayBoard
		fi;
	else
		numberPosition=$(( RANDOM % 9 ))
		checkPositionIsEmpty="$( checkIsEmpty $numberPosition )"
		if [[ $checkPositionIsEmpty == "true" ]]
		then
			array[$numberPosition]="$systemLetter"
			displayBoard
		else
			count=$(($count-1))
			echo "position is already filled U can play"
		fi;
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
		echo You Win
		break
	elif [[ $count -eq 9 ]]
	then
		break
	fi;
	systemPlay
	count=$(( $count+1 ));
	checkWin=$( checkWinningConditions )
	if [[ $checkWin == win ]]
	then
		echo system win
		break
  	elif [[ $count -eq 9 ]]
  	then
      break
   fi;
done
