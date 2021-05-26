# CLI guessing game

# imports
import random, strformat, strutils

# Set sentences
let too_high_sentences = @["Hey It is a bit lower than that", "LOWER!!", "Go back down a bit", "It is less", "Need to go down bro"]
let too_low_sentences = @["Hey bro!, your too low", "It is a bit higher", "HIGHER!!", "Go up a bit", "Let's go higher"]

# Custom function to get user input
proc read(args: string): string =
  stdout.write(args)
  result = stdin.readline()

# global vars
var to_guess: int
var done = false
var guesses: int

# Actual code
let difficulty = read("Please enter difficulty level (1/2/3) > ")
randomize()
if difficulty == "1":
    echo "You choosed the difficulty 1"
    to_guess = rand(1..100)
elif difficulty == "2":
    echo "You choosed the difficulty 2"
    to_guess = rand(1..500)
elif difficulty == "3":
    echo "You choosed the difficulty 3"
    to_guess = rand(1..1000)
else:
    echo "Please choose an interger between 1 and 3"
    quit()

echo ""

proc game() = 
    let answer = read("Try to guess > ")
    let n = parseInt(answer)
    randomize()
    if n > to_guess:
        echo sample(too_high_sentences)
    elif n == to_guess:
        echo &"You guessed it ! It was {to_guess}, you guessed it in {guesses}"
        done = true
    else:
        echo sample(too_low_sentences)
    
    guesses += 1

when isMainModule:
    while not done:
        game()
    echo ""
    echo "Exiting, Thanks for playing !!! "