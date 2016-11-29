#!/bin/sh
path=~/.lategame

file=$path/logs/$USER.log
tmpfile=$path/tmp

git -C $path/logs pull > /dev/null 2>&1

lastdate=$(cat $file | tail -n 1 | cut -f 1 -d ' ')
today=$(date "+%D")
points=$(head -n 1 $file)
hour=$(date "+%H")
fullhour=$(date "+%T")

if [[ "$USER" = "afourcad" ]]
then
	ref=15
else
	ref=10
fi

diff=$(($hour - $ref))

if [[ "$lastdate" != "$today" ]];
then
	echo "\033[34mBonjour $USER ! Tu es arrive entre $hour et $(($hour + 1)) heures."
	if [ $diff -eq 0 ]
	then
		echo "\033[33mBien joue ! Tu n'as aucun point de penalite !"
	elif [ $diff -lt 0 ]
	then
		echo "\033[35mTROP OUF ! Tu t'es enleve $((-$diff)) points de penalite !"
	else
		echo "\033[31mBah bravo ! On arrive en retard ! Tu as obtenu $diff points de penalite !"
	fi
	points=$(($points + $diff))
	if [ $points -le 0 ]
	then
		points=0
	fi
	echo "\033[34mTu as donc dorenavent \033[31m$points\033[34m points de penalite."
	echo "Maintenant arrete de lire ces conneries et bosse ! \033[31m<3\033[0m"
	date "+%D %T" >> $file
	sed "1s/.*/$points/" $file > $tmpfile
	mv $tmpfile $file
	git -C $path/logs add $file > /dev/null 2>&1
	git -C $path/logs commit -m "$today $fullhour [$points points]" > /dev/null 2>&1
	git -C $path/logs push > /dev/null 2>&1
fi
