#! /bin/bash

echo -n "What is your name? : "
read name
echo -n "What is your e-mail address ? : "
read mail
echo -n "What is your favorit text editor ? (ex vim):"
read editor

git config --global user.name "$name"
git config --global user.email "$mail"
git config --global core.editor $editor
git config --global color.ui auto

cd ~
echo "alias gpl='git pull origin master'" >> ~/.bashrc
echo "alias gps='git push origin master'" >> ~/.bashrc

echo "git setting finished."
