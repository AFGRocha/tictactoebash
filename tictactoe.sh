#!/bin/bash

player_1="X"
player_2="O"

turn=1
game=true


moves=( 1 2 3 4 5 6 7 8 9 )

print_board () {
  clear
  echo "TIC-TAC-TOE:"
  echo ""
  echo " ${moves[0]} | ${moves[1]} | ${moves[2]} "
  echo "-----------"
  echo " ${moves[3]} | ${moves[4]} | ${moves[5]} "
  echo "-----------"
  echo " ${moves[6]} | ${moves[7]} | ${moves[8]} "
  echo ""
}

player_phase(){
  if [[ $(($turn % 2)) == 0 ]]
  then
    play=$player_2
    echo -n "Player 2 pick a valid square: "
  else
    echo -n "Player 1 pick a valid square: "
    play=$player_1
  fi

  read square
  space=${moves[($square -1)]} 
  
  if [[ $square =~ ^[1-9]+$  ]] && [[ $space =~ ^[1-9]+$  ]]
  then
    moves[($square -1)]=$play
    ((turn=turn+1))
  else
    echo "Not valid"
    player_pick
  fi
}

check_victory() {
    if  [[ ${moves[$1]} == ${moves[$2]} ]] && \
        [[ ${moves[$2]} == ${moves[$3]} ]]; then
     
        game=false
    fi
    if [ $game == false ]; then
        if [[ $(($turn - 1 % 2)) == 0 ]]
        then
            echo "Player 2 Wins"
        else
            echo "Player 1 Wins"
        fi
    fi
}
win_conditions() {
    check_victory 0 1 2
    if [ $game == false ]; then return; fi
    check_victory 3 4 5
    if [ $game == false ]; then return; fi
    check_victory 6 7 8
    if [ $game == false ]; then return; fi
    check_victory 0 4 8
    if [ $game == false ]; then return; fi
    check_victory 2 4 6
    if [ $game == false ]; then return; fi
    check_victory 0 3 6
    if [ $game == false ]; then return; fi
    check_victory 1 4 7
    if [ $game == false ]; then return; fi
    check_victory 2 5 8
    if [ $game == false ]; then return; fi
    
    if [ $turn -gt 9 ]; then 
        game=false
        echo "Draw"
    fi
}

ask_retry() {
    if [ $game == false ]; then
        echo -n "Play again? (Y or N):"
        read response
        echo $response
        if [ $response = "y" ] || [ $response = "Y" ]; then
            game=true
            turn=1
            moves=( 1 2 3 4 5 6 7 8 9 )
            print_board
        else
            return
        fi
    fi
}
print_board

while $game
do
    player_phase
    print_board
    win_conditions
    ask_retry
done