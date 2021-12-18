#!/bin/bash

printf "\n\n"

##########

# 2 arguments required
if [[ ! "$# == 2" ]]
then
	printf "usage : ./create-article <category> <title>"
	exit 1
fi

# arguments should not be empty
if [[ $1 == "" || $2 == "" ]]
then
	printf "some arguments are empty"
	exit 0
fi

##########

printf "creating article...\n\n"

# make string lowercase and use single "-" as delemeter
escape(){
	printf "$1" |
	tr '[:upper:]' '[:lower:]' |
	sed -E 's/[^a-zA-Z0-9]/-/g' |
	sed -E 's/--*/-/g' |
	sed -E 's/^-//g; s/-$//g'
}


# split string with "--"
splitCategory(){
	printf "$1" |
	tr '[:upper:]' '[:lower:]' |
	sed -E "s/(--).*//g" 
}

# escape the title
TITLE=$(escape "$2")

# split category string to make array

# get the first value of category array as string
MAINCATEGORY=$( splitCategory  |  escape "$1")

# get all the value of category array as string
SUBCATEGORY=$(escapeSubcategory "$1")

# concat main category and title to make id
ID="$CATEGORY/$TITLE"
printf "Category and Title Parsed Into \n \"$ID\" \n"

# get git config's user info
EMAIL=$(git config user.email)
NAME=$(git config user.name)

# parse meta.json
META=$(
	cat "./template/meta.json" |
	sed "s/Camel Cased Title/$2/g" | # the title string user entered
	sed "s/Name From Git/$NAME/g" | # name of git user
	sed "s/Email From Git/$EMAIL/g" | # email of git user
	if [[ $SUBCATEGORY = ""  ]]
	then
		sed "s/same-as-notion//g" # no subcategory
	else
		sed "s/same-as-notion/SUBCATEGORY/g" # insert subcategory
	fi
)

# make branch
if [[ ! $(git branch --list $ID) = "" ]]
then
	printf "branch already exists, changing branch \n \"$ID\" \n"
	git branch $ID
else
	printf "new branch created\n"
	git switch -c $ID
fi

# make category directory
if [[ ! -d "./$CATEGORY" ]]
then
	printf "new category directory \"./$CATEGORY\" created\n"
	mkdir "./$CATEGORY"
else
	printf "category already exists \"./$CATEGORY\""
fi

# make article directory
if [[ ! -d "./$CATEGORY/$TITLE" ]]
then
	printf "new article directory \"./$CATEGORY/$TITLE\" created \n"
	mkdir "./$CATEGORY/$TITLE"
else
	printf "the article already exists \"./$CATEGORY/$TITLE\" \n"
	exit 1
fi

# copy template to the directory
cp -a ./template/. ./$ID/
printf "./template/ copied to ./$ID/ \n"

# re-write meta.json in the directory
echo "$META" > "./$ID/meta.json"
printf "meta.json edited\n"

# copy ID to clipboard
echo $ID | pbcopy

# cd to the directory
cd ./$ID/

# exit and open new shell on the directory
printf "new article $ID is created with template\n"
$SHELL
exit 0
