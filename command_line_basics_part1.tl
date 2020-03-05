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
Welcome to the first lesson on Unix/Linux command-line basics. In this
lesson, we will show you how to enter simple commands at the command line.

This window is broken into two panes. You will see instructions in the top
pane and you will enter commands at the command line in the bottom pane.

You should see a line of text ending with the dollar sign $ below. This
is the command line prompt. It is waiting for you to type in a command.

EOF
get_Enter "Hit the <Enter> key to continue: "

clear
cat <<EOF
Click your mouse pointer on the bottom pane and type the word ${ul}date${noul}
at the $ prompt, then hit the <Enter> key. You should see the current date
displayed on the line below the command line; then, a new command prompt will
appear. You have entered and run your first command-line command.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Loop to confirm that they typed a date command properly
while : ; do

  # Get the second-last last non-empty text line from the bash pane
  pane_contents="$(get_pane_contents 1)"
  dateline=`echo "$pane_contents" | grep -v '^$' | tail -2 | head -1`

  # Check that it ends with a space and four digits
  # Leave the loop if the date format seems OK
  echo $dateline | grep -s ' [0-9][0-9][0-9][0-9]$'
  if [ "$?" -eq 0 ]; then break; fi

  clear
  cat <<EOF
Hmm, it looks like you didn't type in the ${ul}date${noul} command properly,
or you didn't get the correct output from the ${ul}date${noul} command.
Please click in the bottom pane and try again.
EOF
  sleep 1

done

clear
cat <<EOF
Commands at the command line start with the command name. If there are any
arguments to the command, these are also typed in but with ${ul}spaces${noul}
to separate the arguments from each other and from the command name.

Click in the bottom pane and, at the command line, enter the command
${ul}echo${noul} ${ul}Hello${noul} ${ul}world${noul}

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
You should see that the ${ul}echo${noul} command echoed the following
arguments back to the screen. Try using ${ul}echo${noul} to print out
some more messages. Also, try making a few mistakes like this command:

${ul}echoHello${noul} ${ul}world${noul}

to see what happens when you forget the spaces between things.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Clear the bottom pane
send_cmd_to_pane 1 clear

# Make a file with well-known contents
cat > tlearn_text_file <<EOF
This is a small text file with a
number of lines of text which
was created by the tlearn tool.
EOF

clear
cat <<EOF
Now let's look at the command used to list the contents of a directory: ${ul}ls${noul}.
(A ${ul}directory${noul} is another name for a ${ul}folder${noul} of files).

Click on the bottom pane and enter the command ${ul}/bin/ls${noul} at the command prompt.
That's a lower-case L, not a one digit, before the 's' character. You should
see a list of files that are in your current directory.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
${ul}/bin/ls${noul} with no arguments shows all the files that are in the current
directory. To see more details about each file, e.g. its size, permissions and
ownership, you can run the command with the ${ul}-l${noul} option, to tell ${ul}ls${noul}
to give a long listing for each file. That's a lower-case L, not a one digit!

Click on the bottom pane and enter the command ${ul}/bin/ls -l${noul}.

You should see a list of files. Each line shows the details for one file.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
Let's look at the information that ${ul}ls -l${noul} gives for one
file which we created for this lesson, ${ul}tlearn_text_file${noul}:

-rw-r--r-- 1 wkt wkt    95 Mar  5 11:28 tlearn_text_file
                        ^         ^         ^
                        |         |         |
                        |         |      file's name
    size of the file in bytes   date the file was last modified

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear
cat <<EOF
That's all for this lesson. Now you can explore
the other ${ul}tlearn${noul} lessons.

EOF
get_Enter "Hit the <Enter> key to end the lesson: "

# End the tmux session: close the two panes down.
# Clean up temporary files.
end_tmux_session
rm -f tlearn_text_file
exit 0
