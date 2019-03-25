#!/bin/bash

while true
do
	dropbox_uploader.sh monitor /todo/ 30 > ~/todo/monitor.txt
	grep -e "todo.txt" -e "todoarc.txt" ~/todo/monitor.txt | while read LINE
	do
		echo Updating
		dropbox_uploader.sh download /todo/todo.txt ~/todo/todoMonitorTemp.txt
		mv ~/todo/todoMonitorTemp.txt ~/todo/todoMonitor.txt
	done
done

