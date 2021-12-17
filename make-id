#!/bin/bash

printf "\n"

if [[ ! "$# == 2" ]]
then
	printf "usage : ./make-id <category> <title>"
	exit 1
fi

if [[ $1 == "" || $2 == "" ]]
then
	printf "some arguments are empty"
	exit 0
fi

printf "\nMaking id with category and title string...\n"

escapeTitle(){
	printf "$1" |
	tr '[:upper:]' '[:lower:]' |
	sed -E 's/[^a-zA-Z0-9]/-/g' |
	sed -E 's/--*/-/g' |
	sed -E 's/^-//g; s/-$//g'
}

escapeCategory(){
	printf "$1" |
	tr '[:upper:]' '[:lower:]' |
	sed -E "s/(--).*//g" 
}

# get id
CATEGORY=$(escapeCategory "$1")
TITLE=$(escapeTitle "$2")
ID="$CATEGORY/$TITLE"
printf "article's id is, \n \"$ID\" \n"

