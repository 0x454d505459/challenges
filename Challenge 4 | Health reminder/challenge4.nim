import strformat, os, strutils, random, times

let 
    red = "\e[31m"
    # yellow = "\e[33m"
    # cyan = "\e[36m"
    green = "\e[32m"
    blue = "\e[34m"
    def = "\e[0m"

var messages: seq[string]
var logs: seq[string]
var time_to_wait: int

let help = """
----------------- BEGIN OF HELP -----------------

-t=4 Set the time to wait between notifications in
milliseconds

------------------ END OF HELP ------------------
"""

type EKeyboardInterrupt = object of CatchableError

proc handler() {.noconv.} =
  raise newException(EKeyboardInterrupt, "Keyboard Interrupt")

setControlCHook(handler)


if paramCount() < 1:
    echo help
    quit(1)

if paramStr(1).startsWith("-t="):
    let tmp = paramStr(1).split("=")
    time_to_wait = parseInt(tmp[1])
else:
    echo help
    quit(1)

proc load_messages() =
    if not os.fileExists("./messages.txt"):
        echo &"{red}messages.txt file not found, please create a messages file with one messages per line{def}"
        quit()

    let msg_file = readFile("./messages.txt")
    if msg_file == "":
        echo &"{red}messages.txt file empty, please add some messages to the file{def}"
        quit()

    let lines = msg_file.splitLines()
    var x = 0
    for line in lines:
        messages.add(line)
        x+=1
    echo &"{blue}INFO{def}: loaded {x} messges"


when isMainModule:
    load_messages()
    while true:
        randomize()
        try:
            var message = sample(messages)
            discard os.execShellCmd(&"""notify-send -a 'Health Manager' 'Taking care of you...' '{message}' -t 20000 -i './heart.png'""")
            logs.add(&"{times.now().getDateStr} -- {times.now().getClockStr()}:       {message}")
            sleep(time_to_wait)
        except EKeyboardInterrupt:
            var file_content = """
"""
            for e in logs:
                file_content &= e & "\n"
            writeFile("health.log", file_content)
            echo &"\n{green}Bye, Take care of you ;) {def}"
            quit(1)
