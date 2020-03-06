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
bo=`tput smso`; nobo=`tput rmso`
ul=`tput smul`; noul=`tput rmul`

clear; cat <<EOF
Welcome to the first lesson on Unix/Linux command-line basics. In this
lesson, we will show you how to enter simple commands at the command line.

This window is broken into two ${ul}panes${noul}. You will see instructions in the
top pane and you will enter commands at the command line in the bottom pane.

You should see a line of text ending with the dollar sign $ below. This
is the command line prompt. It is waiting for you to type in a command.

EOF
get_Enter "Hit the <Enter> key to continue: "

clear; cat <<EOF
Click your mouse pointer on the bottom pane and type the word ${bo}date${nobo} at
the $ prompt, then hit the <Enter> key. You should see the current date
displayed on the line below the command line; then, a new command prompt
will appear. You have entered and run your first command-line command.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Loop to confirm that they typed a date command properly
while : ; do

  # Get the date output
  dateline=$(get_cmd_output)
  echo We got $dateline

  # Check that it ends with a space and four digits
  # Leave the loop if the date format seems OK
  echo $dateline | grep -s ' [0-9][0-9][0-9][0-9]$'
  if [ "$?" -eq 0 ]; then break; fi

  clear; cat <<EOF
Hmm, it looks like you didn't type in the ${bo}date${nobo} command properly, or you
didn't get the correct output from the ${bo}date${nobo} command.  Please click in the
bottom pane and try again.
EOF
  sleep 1

done

clear; cat <<EOF
Commands at the command line start with the command ${ul}name${noul}. If there are
any ${ul}arguments${noul} to the command, these are also typed in but with spaces to
separate the arguments from each other and from the command name.

Click in the bottom pane and, at the command line, enter the command

${bo}echo${nobo} ${bo}Hello${nobo} ${bo}world${nobo}

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
You should see that the ${bo}echo${nobo} command echoed the following arguments back
to the screen. Try using ${bo}echo${nobo} to print out some more messages. Also,
try making a few mistakes like this command:

${bo}echoHello world${nobo}

to see what happens when you forget the spaces between things.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

# Clear the bottom pane
send_cmd_to_pane 1 clear Enter

# Make a file with well-known contents
cat > tlearn_text_file <<EOF
This is a small text file with a
number of lines of text which
was created by the tlearn tool.
EOF

clear; cat <<EOF
Now let's look at the command used to list the contents of a ${ul}directory${noul}: ${bo}ls${nobo}.
(A directory is another name for a ${ul}folder${noul} of files).

Click on the bottom pane and enter the command ${bo}/bin/ls${nobo} at the command prompt.
That's a lower-case L, not a one digit, before the 's' character. You
should see a list of files that are in your current directory.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
${bo}/bin/ls${nobo} with no arguments shows all the files that are in the current
directory. To see more details about each file, e.g. its size, permissions
and ownership, you can run the command with the ${bo}-l${nobo} option, to tell ${bo}ls${nobo} to
give a long listing for each file. That's a lower-case L, not a one digit!

Click on the bottom pane and enter the command ${bo}/bin/ls -l${nobo}

You should see a list of files. Each line shows the details for one file.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
Let's look at the information that ${bo}ls -l${nobo} gives for one file which we
created for this lesson, ${bo}tlearn_text_file${nobo}:

-rw-r--r-- 1 wkt wkt    95 Mar  5 11:28 tlearn_text_file
                        ^         ^         ^
                        |         |         |
                        |         |      file's name
    size of the file in bytes   date the file was last modified

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
It's very likely that the Linux system you are using has set up an ${ul}alias${noul}
so that, whenever you type in the ${bo}ls${nobo} command, you actually run the command
with the ${bo}-l${nobo} option.

To find out, enter the command ${bo}alias ls${nobo} at the command prompt below.

If you see something like ${bo}alias ls='ls -lL'${nobo}, then this means that when
you type ${bo}ls${nobo} by itself, it gets converted into ${bo}ls -lL${nobo}. Try it!

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
The ${ul}options${noul} to a command start with a minus sign, and they modify the
command's behaviour (e.g. to tell ${bo}ls${nobo} to do long listings).  The ${ul}arguments${noul}
come after the options and tell the command what to work on.

Try this command at the command prompt below: ${bo}ls -l tlearn_text_file${nobo}
This does a long listing on the ${bo}tlearn_text_file${nobo} only.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
It's time to learn another command. To see the contents of one or more
files, use the ${bo}cat${nobo} command. At the prompt below, enter the command:

${bo}cat tlearn_text_file${nobo}

This will show you the contents of the ${bo}tlearn_text_file${nobo}.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
The ${bo}cat${nobo} command actually stands for ${ul}concatenate${noul}. It will join and output
several files which are named as arguments. For example, if you have files
called ${bo}file1${nobo}, ${bo}file2${nobo} and ${bo}file3${nobo}, you could do:

${bo}cat file1 file2 file3${nobo}

to see the contents of all three files, one after the other. Why this is
useful we see in the future.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
Another useful command is ${bo}wc${nobo}. This counts words, lines and the number of
bytes of the files named as arguments. Try this command at the prompt below:

${bo}wc tlearn_text_file${nobo}

You should see three numbers as the result: the number of lines in the file,
the number of words in the file and the file's byte size.

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
The ${bo}wc${nobo} command has three options: ${bo}-l${nobo}, ${bo}-w${nobo} and ${bo}-c${nobo}. Try each of these three
commands below and see if you can work out what each one does:

${bo}wc -l tlearn_text_file${nobo}
${bo}wc -w tlearn_text_file${nobo}
${bo}wc -c tlearn_text_file${nobo}

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
When you read the manual pages for Unix/Linux commands, the optional parts
are shown in square brackets [ ]. If there are many single-letter options
starting with a minus sign, they are shown consecutively. If the command
takes an arbitrary number of arguments, this is shown with three dots ...
Using this information, can you understand the syntax for these commands?

date                       echo word ...          cat file ...
ls [-l] [file1 ...]        wc [-lwc] file1 ...

EOF
get_Enter "Click back in this pane and hit the <Enter> key to continue: "

clear; cat <<EOF
That's all for this lesson on the command line. You now know five useful
command-line commands and how to run them. Use this knowledge and practice
these commands with their options and some arguments.

Now you can explore the other ${ul}tlearn${noul} lessons.

EOF
get_Enter "Hit the <Enter> key to end the lesson: "

# End the tmux session: close the two panes down.
# Clean up temporary files.
rm -f tlearn_text_file
end_tmux_session
exit 0
