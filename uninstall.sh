#!/bin/sh

rm -rf ~/.lategame
sed '/lategame.sh/d' ~/.zshrc > tmp
mv tmp ~/.zshrc
