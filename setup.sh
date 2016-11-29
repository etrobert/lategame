#!/bin/sh

path=~/.lategame
file=$path/$USER.log
ex=lategame.sh

if [[ ! -a $path ]]
then
	mkdir $path
fi
cp $ex $path
if [[ ! -a $file ]]
then
	echo "0" > $file
fi
if ! grep $ex ~/.zshrc > /dev/null
then
	echo "$path/$ex" >> ~/.zshrc
fi
