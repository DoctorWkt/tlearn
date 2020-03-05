#!/bin/bash
# Get the tlearn dir and lesson name. Load the functions
tlearndir=$1; lesson=$2
source "$tlearndir/functions"

# Set the window size to at least 80 by 34
window_size_atleast 80 34

# Initialise the tmux session
# and create a 24-row pane.
# Keep focus in original pane.
init_tmux_session; new_pane 24; select_pane 0

# Get some escape sequences for bold and underline
bold=`tput smso`; nobold=`tput rmso`
ul=`tput smul`; noul=`tput rmul`

clear
cat <<EOF
Welcome to the second lesson on Unix/Linux command-line basics. In this
lesson, we will explore how to edit what you have typed on the command
line, and also some techniques to make you more efficient at using the
command line.

To start with, we are going to use a shorthand notation. When you see 
either the syntax ${ul}^L${noul} or ${ul}ctrl-L${noul}, this means to hold down the control key
and the L key at the same time. This is known as a "control L" character.

EOF
get_Enter "Click in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
At the command prompt below, type in a few commands like ${ul}date${noul} and ${ul}ls${noul}, just so
there is some text in the bottom pane.

Now type ctrl-L at the command prompt. You should see all the text disappear
and you are left with a new command prompt. This is how you can clear the
text from your command window.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Put some text on the user's command line
send_cmd_to_pane 1 echo Space appel Space bannana Space chery Space oRange Space Mayngo

clear
cat <<EOF
Now it's time to learn how to edit on the command line. I've added an ${ul}echo${noul}
command at your command prompt, with the names of the fruit misspelled. Use
the left and right arrow keys, the backspace and delete keys to correct the
spelling for the five types of fruit. Ensure all the letters are lowercase.
Then hit the <Enter> key to print the names out.

You don't have to move to the end of the line before you hit <Enter>, either!

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Loop to confirm that they correctly edited the line
while : ; do

  # Get the second-last last non-empty text line from the bash pane
  pane_contents="$(get_pane_contents 1)"
  echoline=`echo "$pane_contents" | grep -v '^$' | tail -2 | head -1`

  # Leave the loop if the text matches
  if [ "$echoline" = "apple banana cherry orange mango" ]; then break; fi

  clear
  cat <<EOF
Hmm, it looks like you didn't edit the command line correctly. I want to
see the ${ul}echo${noul} command display this on the screen:

                     apple banana cherry orange mango

but you printed out: $echoline

Please click in the bottom pane and try again. You can use the up arrow
to bring back the last command that you typed in.
EOF
  sleep 1
done

clear
cat <<EOF
The up arrow can be used to go back through the list of commands that you
have previously typed in. Once you have a line loaded at the command prompt,
you can hit <Enter> to run it again.

This list of commands is known as your command ${ul}history${noul}.

At the command prompt below, go back through your history and run a few
old commands.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
The ${ul}history${noul} command lists all of your previous commands, and
each one is given a consecutive number. Try this out at the command prompt.

As as short-cut, let's assume that you want to re-run the command with the
number 25 in your history. At your command prompt, you can type in ${ul}!25${noul} to
re-run command number 25. Try this out at the command prompt below.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
You can also type in ${ul}!da${noul} at the command prompt to re-run the most recent
command that started with "da". However, make sure this is really the command
that you want! You may accidentally run the wrong command and delete your files
or data.

Try this out at the command prompt below.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Make a file with well-known contents
cat > tlearn_text_file <<EOF
This is a small text file with a
number of lines of text which
was created by the tlearn tool.
EOF

clear
cat <<EOF
You can use the <Tab> key at the command prompt to complete (fill out) file
names if they are unique. I've put back the ${ul}tlearn_text_file${noul} in your directory.

At the prompt below, type in ${ul}ls -l tle${noul} and then hit the <Tab> key.
You should see the file's name completed for you. Now you can hit
<Enter> to get the long details of this file.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
Finally, there are several control characters for moving and editing:

ctrl-A Move to start of line      ESC-D  Delete word to right of cursor
ctrl-E Move to end of line	  ctrl-W Delete word to left of cursor
ESC-B  Move back one word         ctrl-K Delete from cursor to end of line
ESC-F  Move forward one word	  ctrl-U Delete from cursor to start of line

Try these out at the command prompt below.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
That's all for this lesson on the command line. You now know how to edit
what you have typed on the command line, how to get a list of previous
commands, how to run previous commands, and how to fill out filenames
on the command line.

Now you can explore the other ${ul}tlearn${noul} lessons.

EOF
get_Enter "Hit the <Enter> key to end the lesson: "

# End the tmux session: close the two panes down.
# Clean up temporary files.
rm -f tlearn_text_file
end_tmux_session
exit 0
