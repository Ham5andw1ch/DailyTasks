#!/bin/bash
updateTodo () {
	#Clean Directoy
	currentDate=$(date +"%Y-%m-%d")
	rm -rf ~/todo/todo*

	#Download the latest files
	dropbox_uploader.sh download /todo ~/
	
	
	#Go through streaks and increment streak count
	cat ~/todo/streaks.txt | while read line
	do
		taskName=$(echo $line | grep -oP ".*(?=( [0-9]+))") 
   		oldNumber=$(echo "$line" | awk 'NF>1{print $NF}')
		((oldNumber++))
		echo $oldNumber
		grep -v "$line" ~/todo/streaks.txt > ~/todo/streakscopy.txt
		mv ~/todo/streakscopy.txt ~/todo/streaks.txt
		echo "$taskName $oldNumber" >> ~/todo/streaks.txt
		echo "$currentDate @daily $taskName $oldNumber due:$currentDate" >> ~/todo/newStreaks.txt
	done
	
	#Check for tasks not done and remove streaks
	grep -oP "(?<=@daily ).*(?=(( due:.*)))" ~/todo/todo.txt | while read -r line ; do
    		echo "$line Not Completed"
		#Remove task from streaks
    		taskName=$(echo $line | grep -oP ".*(?=( [0-9]+))")
		echo "$taskName removing"
		grep -v "$taskName" ~/todo/streaks.txt > ~/todo/streakscopy.txt
		mv ~/todo/streakscopy.txt ~/todo/streaks.txt
		grep -v "$taskName" ~/todo/newStreaks.txt > ~/todo/streakscopy.txt
		mv ~/todo/streakscopy.txt ~/todo/newStreaks.txt
		echo "$taskName 0" >> ~/todo/streaks.txt
		echo "$currentDate @daily $taskName 0 due:$currentDate" >> ~/todo/newStreaks.txt
	done

	grep -vP "(?<=@daily ).*(?=(( due:.*)))" ~/todo/todo.txt > ~/todo/todocopy.txt
	mv ~/todo/todocopy.txt ~/todo/todo.txt
	echo "TODO AFTER REMOVE"
	cat ~/todo/todo.txt

	grep -oP "(?<=@daily ).*(?=(($)))" ~/todo/todo.txt | while read -r line ; do
    		echo "$line Not Completed"
		#Remove task from streaks
		grep -v "$line" ~/todo/streaks.txt > ~/todo/streakscopy.txt
		mv ~/todo/streakscopy.txt ~/todo/streaks.txt

		#THIS SHOULD NEVER HAPPEN. IF THIS EVER DOES ANYTHING, THE STREAKS FILE WAS TAMPERED WITH.
		grep -v "$line" ~/todo/newStreaks.txt > ~/todo/streakscopy.txt
		mv ~/todo/streakscopy.txt ~/todo/newStreaks.txt

		echo "$line 0" >> ~/todo/streaks.txt
		echo "$currentDate @daily $line 0 due:$currentDate" >> ~/todo/newStreaks.txt
	done
	
	grep -vP "(?<=@daily ).*(?=(($)))" ~/todo/todo.txt > ~/todo/todocopy.txt
	mv ~/todo/todocopy.txt ~/todo/todo.txt
	echo NewStreaks
	cat ~/todo/newStreaks.txt

	cat ~/todo/newStreaks.txt >> ~/todo/todo.txt
	rm ~/todo/newStreaks.txt	
	
	dropbox_uploader.sh upload ~/todo/todo.txt /todo/todo.txt
}

if [[ $1 == "-t" ]];
then
	updateTodo
else
	while true
	do
		currentTime=$(date +"%H%M%S")
		targetTime='000000'
		if [[ $currentTime == $targetTime ]];
		then	
			updateTodo
		fi
	done
fi

