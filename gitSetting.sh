#! /bin/bash

count=0
while true; do
	echo -n "gitで使用するユーザー名を入力してください : "
	read name
	while true; do
		echo -n "$name さんですね。(y/n) :"
		read check
		if [ "${check}" == "y" ]; then
			break
		elif [ "${check}" == "n" ]; then
			break
		else
			((count++))
			echo "yかnを入力します"
			if [ "${count}" == "3" ]; then
				echo "3回の誤入力があったため異常終了します"
				exit 1
			else
				echo "誤入力$count回目です 3回で終了します"
			fi
			continue
		fi
	done
	if [ "${check}" == "y" ]; then
		count=0
		break
	else
		continue
	fi
done

while true; do
	echo -n "gitで使用するメールアドレスを入力してください : "
	read mail
	while true; do
		echo -n "$mailでよろしいですか? (y/n) :"
		read check
		if [ "${check}" == "y" ]; then
			break
		elif [ "${check}" == "n" ]; then
			break
		else
			((count++))
			echo "yかnを入力します"
			if [ "${count}" == "3" ]; then
				echo "3回の誤入力があったため異常終了します"
				exit 1
			else
				echo "誤入力$count回目です 3回で終了します"
			fi
			continue
		fi
	done
	if [ "${check}" == "y" ]; then
		count=0
		break
	else
		continue
	fi
done

while true; do
	echo -n "gitで使用するテキストエディタの名前を入力してください (例 vimやnvim、gedit、emacs) : "
	read editor
	while true; do
		echo -n "$editorでよろしいですか? (y/n) :"
		read check
		if [ "${check}" == "y" ]; then
			break
		elif [ "${check}" == "n" ]; then
			break
		else
			((count++))
			echo "yかnを入力します"
			if [ "${count}" == "3" ]; then
				echo "3回の誤入力があったため異常終了します"
				exit 1
			else
				echo "誤入力$count回目です 3回で終了します"
			fi
			continue
		fi
	done
	if [ "${check}" == "y" ]; then
		count=0
		break
	else
		continue
	fi
done

exit 0

git config --global user.name "$name"
git config --global user.email "$mail"
git config --global core.editor $editor
git config --global color.ui auto

cd ~
echo "alias gpl='git pull origin master'" >> ~/.bashrc
echo "alias gps='git push origin master'" >> ~/.bashrc

echo "gitの設定が完了しました"

exit 0

