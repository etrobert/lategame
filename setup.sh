#!/bin/sh

path=~/.lategame
file=$path/logs/$USER.log
ex=lategame.sh


if [[ ! -a $path ]]
then
	mkdir $path
fi
cp $ex $path
#git clone git@github.com:verdierm/lategame_logs.git $path/logs > /dev/null 2>&1
if [[ ! -a $file ]]
then
	echo "0" > $file
fi
if ! grep $ex ~/.zshrc > /dev/null
then
	echo "$path/$ex" >> ~/.zshrc
fi
