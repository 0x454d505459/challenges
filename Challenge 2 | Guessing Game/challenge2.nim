# CLI guessing game

# imports
import random, strformat, strutils

# colors
let 
    red = "\e[31m"
    yellow = "\e[33m"
    cyan = "\e[36m"
    green = "\e[32m"
    blue = "\e[34m"
    def = "\e[0m"

# Logo

let logo = &"""
   ________  __________________ __________________
  / ____/ / / / ____/ ___/ ___// ____/  _/_  __/ /
 / / __/ / / / __/  \__ \\__ \/ __/  / /  / / / / 
/ /_/ / /_/ / /___ ___/ /__/ / /____/ /  / / /_/  
\____/\____/_____//____/____/_____/___/ /_/ (_)   
                                by 0x454d505459#5042         

"""

# Event handler for CTRL+C
type EKeyboardInterrupt = object of CatchableError

proc handler() {.noconv.} =
  raise newException(EKeyboardInterrupt, "Keyboard Interrupt")

setControlCHook(handler)


# Set sentences
let too_high_sentences = @[&"Hey It is a bit {red}lower{def} than that", &"{red}LOWER!!{def}", &"Go {red}back down{def} a bit", &"It is {red}less{def}", &"Need to go {red}down{def} bro"]
let too_low_sentences = @[&"Hey bro!, your {red}too low{def}", &"It is a bit {red}higher{def}", &"{red}HIGHER!!{def}", &"Go {red}up{def} a bit", &"Let's go {red}higher{def}*"]

# Custom function to get user input
proc read(args: string): string =
  stdout.write(args)
  result = stdin.readline()

# global vars
var to_guess: int
var done = false
var guesses: int

# Actual code
proc load() =
    guesses = 0
    let difficulty = read(&"Please enter difficulty level ({green}1{def}/{blue}2{def}/{red}3{def}) > ")
    randomize()
    if difficulty == "1":
        echo &"You choosed the difficulty {green}1{def}"
        to_guess = rand(1..100)
    elif difficulty == "2":
        echo &"You choosed the difficulty {blue}2{def}"
        to_guess = rand(1..500)
    elif difficulty == "3":
        echo &"You choosed the difficulty {red}3{def}"
        to_guess = rand(1..1000)
    else:
        echo &"Please choose an {yellow}interger{def} between {green}1{def} and {red}3{def}"
        quit()

    echo ""

proc game() = 
    let answer = read(&"Try to {cyan}guess{def} > ")
    let n = parseInt(answer)
    randomize()
    if n > to_guess:
        echo sample(too_high_sentences)
    elif n == to_guess:
        echo &"You {green}guessed it{def} ! It was {green}{to_guess}{def}, you guessed it in {red}{guesses+1} guesses{def}"
        let q = read(&"Do you want to {cyan}start{def} again ? ({green}y{def}/{red}n{def}) > ")
        if q == "y":
            echo ""
            load()
        else:
            done = true
    else:
        echo sample(too_low_sentences)
    
    guesses += 1

when isMainModule:
    try:
        echo &"{cyan}{logo}{def}"
        echo ""
        load()
        while not done:
            game()
        echo ""
        echo &"{yellow}Exiting{def}, {green}Thanks for playing !!!{def} "
    except EKeyboardInterrupt:
        echo ""
        echo &"{yellow}Exiting{def}, {green}Thanks for playing !!!{def} "
        quit()