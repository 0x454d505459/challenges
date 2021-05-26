# But what id be interested in seeing you make is,
# A python script that opens a window, in which you can type, this window has a second text box but in that box it outputs (live) the 'dark speech' version of the text

# Dark speech works like this:
#  - Every word is reversed on it's own, "hello" would become "olleh"
#  - If the word starts with a capital letter it will still start witl a capital letter, "Conan" would become "Nanoc"

# Imports
import nigui, strutils, sequtils

#Init
app.init()

# Creating nodes
let w = newWindow("Challenge n°1 | Dark speech")
let container = newLayoutContainer(Layout_Vertical)
let entry = newTextBox()
let area = newTextArea()

#Setting the window up
w.width = 600.scaleToDpi
w.height = 400.scaleToDpi

#Setting up the nodes
entry.widthMode=WidthMode_Expand
area.editable=false

#Adding the nodes to they're respective containers
w.add(container)
container.add(entry)
container.add(area)



#str manipulation

proc reverse[char](sequence: seq[char]): seq[char] =
    result = @[]
    for r in countdown(sequence.len - 1, 0):
        result.add(sequence[r])

# Event handler for return key
entry.onKeyDown = proc(event: KeyboardEvent) =
    if Key_Return.isDown():
        let sequenced = toSeq(entry.text)
        var reversed = reverse(sequenced)
        var final: string

        for i in reversed:
            if i == reversed[0]:
                final &= toUpperAscii(i)
            else:
                final &= toLowerAscii(i)
        entry.text=""
        area.addLine(final)

#Showing the window and runing the app
w.show()
app.run()
