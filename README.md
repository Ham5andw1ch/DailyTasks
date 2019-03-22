# DailyTasks
A quick bash script for todo.txt that works on app platforms. It interfaces with [Dropbox Uploader](https://github.com/andreafabrizi/Dropbox-Uploader) to upload on platforms that aren't x86. 

The script is setup agnostic atm, but it does require an API key and that your todo files be placed in /todo/todo.txt on Dropbox. Besides that, it should be good to go.

# Features and use

This is a bash script. Simply give it execute permissions and run it. It will simply wait for the time to be midnight and then do its job. You can background it to allow it to be out of the way, or you can open it normally to see the debug printing. Running with the flag -t will run test mode, which forcibly runs the function to update todo.txt.

The script currently allows users to keep track of daily assignments as well as assigns a "streak" to each task. For every consecutive day you complete a task, your streak will be incremented. Drop a day, and your streak resets to 0. This is just here as an insentive device.

You can add tasks by making the **first** context of a task @daily. At midnight, any tasks flagged with daily will go through the process of tallying streaks. If @daily is not the first, anything before will get chopped off on consecutive days. 

**Note: even though you can add tasks, should you choose to mark them as complete, the program will not know they exist. The only way to add tasks is to make the first context daily and let it go unchecked until the end of the day. This is because the add system is piggybacking off of the missed streak system. Checking for completed new tasks is sadly setup dependent, but I can add features for my own setups.**

The streak will get added to the **end** of the task. If there are projects or contexts after the text, the program will not know this and will simply slap a number on the end.

# Missing Features

* At the moment, you cannot remove tasks through the app. I am going to make a special context called @remove that will essentially let users remove tasks when the script runs. Until then, you must remove them manually from ~/todo/streaks.txt 

* As mentioned above, you cannot check a task you added that day. I don't know if this will ever get implemented nicely. 

* A version using the todo.txt cli or the native Dropbox client. I wrote this with Raspberry Pis in mind, but the setup works anywhere that Dropox Uploader runs.

# WARNING

I HAVE NOT YET THOROUGHLY TESTED THIS PROGRAM. I AM CURRENTLY IN THE PROCESS OF TESTING IT ON A DAY TO DAY BASIS. I AM NOT LIABLE FOR ANY DAMAGES TO YOUR TODO LIST.

As a side note, should things go wrong, dropbox stores a backup of your files, so it should be easy to recover it. 
