#!/bin/bash

# Uses dmenu and notify-send to edit and display reminders with remind.
# Usage:
# 	remindMenu.sh  [--dir directory] [dmenu options]
#
# 	The --dir option tells the script where to look for your reminder files. This must be the first option Default: $HOME
# 	All other options are passed directly to each instance of dmenu.
# 
# Bugs/Features:
# 	* Editing and deleting operations only act on single lines

# Configuration variables
colWidth=180    # Text width (# of characters) for remind output
actions=( "List events" "Add event" "Edit event" "Delete event" )   # Array of possible actions
remDir=$HOME

# Parse optional directory argument
if [[ $1 == "--dir" ]]; then
	remDir=$2
	shift 2
fi

# Read all remaining arguments to pass them to dmenu
for i in "$@"; do
	DMENU_ARGS="$DMENU_ARGS$i "
done

# Prompt for action
action="$( printf "%s\n" "${actions[@]}" | rofi -dmenu -p 'Choose an action: ' $DMENU_ARGS )"

case $action in
	"${actions[0]}") # List
		lRange="$( rofi -dmenu -p 'Which events?: ' <<< $'Today\nThis Week\nNext 4 Weeks\nThis Month' $DMENU_ARGS )"
		case $lRange in
			'Today') # List today's events
				summary="Today:"
				output="$( remind "$remDir/reminders.rem" | tail -n+3 | sed -e 's/today //g' )"
				if [ -z "$output" ]; then
					summary="No events today."
				fi
				;;
			'This Week') # List this week's events
				summary="This week:"
				output="$( remind -w$colWidth -c+1 "$remDir/reminders.rem" )"
				;;
			'Next 4 Weeks') # List events in the next 4 weeks
				summary="Next 4 weeks:"
				output="$( remind -w$colWidth -c+4 "$remDir/reminders.rem" )"
				;;
			'This Month') # List events in the current month
				summary=" "
				output="$( remind -w$colWidth -c "$remDir/reminders.rem" )"
				;;
			*) # Catchall -- exit
				;;
		esac
		dunstify -u low -t 4000 -r 2599 -i /usr/share/icons/Papirus-Dark/24x24/actions/bell.svg "$summary" "$output"
		;;
	"${actions[1]}") # Add
		# Select reminder file
		while [ ! -f $remDir ]; do
			remDir="$remDir/$( ls -aC1 "$remDir" | rofi -dmenu -p 'Reminder file: ' $DMENU_ARGS )"
		done

		# Get event trigger
		DATE="$(date +%Y-%m-%d)"
		TIME="$(date +%R)"
		trigger="$( rofi -dmenu -l 2 -p 'Event trigger: ' <<< "REM $DATE +0 *0 UNTIL $DATE AT $TIME +0 *0" $DMENU_ARGS )"

		# Get event body
		body="$( rofi -dmenu -p 'Event body: ' <<< $'MSG %" %" %b %2' $DMENU_ARGS )"

		# Confirm reminder entry
		confirm='N'
		confirm="$( rofi -dmenu -p "$trigger $body | Write to ${remDir##*/} ?" $DMENU_ARGS <<< $'y\nN' )"

		# Write reminder to reminder file
		if [ "${confirm,,}" = "y" ]; then
			echo "$trigger $body" >> $remDir
			# Actually write the file
		fi
		;;
	"${actions[2]}") # Edit
		# Select reminder file
		while [ ! -f $remDir ]; do
			remDir="$remDir/$( ls -aC1 "$remDir" | rofi -dmenu -p 'Reminder file: ' $DMENU_ARGS )"
		done

		# Select reminder entry (Only selects a single line)
		oldEvent="$( cat "$remDir" | rofi -dmenu -l $( cat "$remDir" | wc -l ) -p 'Select an event:' $DMENU_ARGS )"

		# Edit line
		newEvent="$( rofi -dmenu -l 2 -p 'New event:' $DMENU_ARGS <<< "$oldEvent" )"

		# Confirm edit
		confirm='N'
		confirm="$( rofi -dmenu -p "$newEvent | Write to ${remDir##*/} ?" $DMENU_ARGS <<< $'y\nN' )"

		# Overwrite reminder to reminder file
		if [ "${confirm,,}" = "y" ]; then
			sedNew="$( sed -e 's/[\/&]/\\&/g' <<< $newEvent )"
			sedOld="$( sed -e 's/[]\/$*.^.^|[]/\\&/g' <<< $oldEvent )"
			sed -i 's/'"$sedOld"'/'"$sedNew"'/g' "$remDir"
		fi
		;;
	"${actions[3]}") # Delete
		# Select reminder file
		while [ ! -f $remDir ]; do
			remDir="$remDir/$( ls -aC1 "$remDir" | rofi -dmenu -p 'Reminder file: ' $DMENU_ARGS )"
		done

		# Select reminder entry (Only selects a single line)
		oldEvent="$( cat "$remDir" | rofi -dmenu -l $( cat "$remDir" | wc -l ) -p 'Select an event:' $DMENU_ARGS )"

		# Confirm reminder deletion
		confirm='N'
		confirm="$( rofi -dmenu -p "$oldEvent | Delete event from ${remDir##*/} ?" <<< $'y\nN' $DMENU_ARGS )"

		# Write reminder to reminder file
		if [ "${confirm,,}" = "y" ]; then
			sedOld="$( sed -e 's/[]\/$*.^.^|[]/\\&/g' <<< $oldEvent )"
			sed -i '/'"$sedOld"'/d' "$remDir"
		fi
		;;
	*) # Catchall -- exit
		;;
esac	
