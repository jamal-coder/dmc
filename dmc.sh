#!/bin/bash

############### Variables #################
myFile1=.info.txt
myFile2=.marks.txt
MAXSUB=20

############### Functions #################
# wait funciton will do two works based on second argument
function wait {
	if [[ $2 -eq 1 ]]; then
		read -p " $1 " dummy
	else
		echo " $1 "
	fi
}

function asking {
	read -p " Enter $1 	: " item
	echo $item
}

function line {
	if [[ $1 -eq 1 ]]; then
		echo "------------------------------------------------------------------------------------------------------"
	else
		echo "--------------------------------------------------------------------"
	fi
}

function yesno {
	while true; do
		read -p " $1" choice
		if [[ $choice = [Yy] || $choice = [Nn] ]]; then
			echo $choice
			break
		else
			wait "You must Enter [Y or y] for Yes or [N or n]for no, press <Enter> to try again..." 1
		fi
	done
}

function clearVariables {
	regno=""
	rno=""
	sname=""
	fname=""
	class=""
	subno=0
	count=0
	subname=()
	subtotal=()
	subobtain=()
	gtotal=0
	gobtain=0
	percentage=0
}

function searchingRecord {
	grep -i "$1" $myFile1 | grep -i "$2" | awk -F ":" '{printf " Registeration No : %s\n Roll Number      : %s\n Student Name     : %s\n Father Name      : %s\n Class Refence    : %s\n Session          : %s\n Total Marks      : %s\n Marks Obtained   : %s\n Percentage(%)    : %s\n", $3, $4, $1, $2, $5, $6, $7, $8, $9}'
}

# experimental function
function experimental {
	regno="A-2019"
	rno="23"
	sname="Muhammad Jamal"
	fname="Muhammad Kamal"
	class="9th (F)"
	session="2018-19"
	subno=2
	subname=("English" "Maths")
	subtotal=(100 100)
	subobtain=(92 96)
	gtotal=200
	gobtain=188
	#percentage=94
}
############## Main Program ###############
while true; do
	clear
	echo " Main Menu"
	echo " ---------"
	echo " <1> Create DMC."
	echo " <2> Search, Edit, Delete"
	echo " <3> Help"
	echo " <4> Quit"
	echo
	read -p " Enter your Choice [1-4] : " choice

	case $choice in
		1)
			# Refreshing variables for next turn
			clearVariables
			clear
			line
			echo " Details Marks Certificate (DMC) Preparation Section"
			line
			#Taking user input
			regno=$(asking "Registration No")
			rno=$(asking "Roll No  ")
			sname=$(asking "Student Name")
			fname=$(asking "Father Name")
			class=$(asking "Class    ")
			session=$(asking "Session  ")
			# Program will repeatedly ask if user didn't enter any number or more then the maximum no of subjects
			while [[ $subno -eq 0 || $subno -gt $MAXSUB ]]; do
				subno=$(asking "No of Subjects")
			done
			# Asking user for subjects input
			echo -e "\n Enter the following information"
			while [[ $count -lt $subno ]]; do
				line
				echo " Subject No."$(( count+1 ))
				# To enter loop we are giving imaginary big number to obtained marks
				subobtain[$count]=100000000000000

				# User must enter subject name
				while [[ ${subname[$count]} = "" ]]; do
					subname[$count]=$(asking "Subject Name")
					# Error message if user didn't enter subject name
					if [[ ${subname[$count]} = "" ]]; then
						wait "Error: Subject must have a name"
					fi
				done
			
				# User must enter total marks and more then 0
				while [[ ${subtotal[$count]} = "" || ${subtotal[$count]} -eq 0 ]]; do
					subtotal[$count]=$(asking "Total Marks")
					# Error message if user didn't enter total marks
					if [[ ${subtotal[$count]} = "" || ${subtotal[$count]} -eq 0 ]]; then
						wait "Error: You must enter total marks"
					fi
				done
				gtotal=$(( gtotal+"${subtotal[count]}" ))
			
				while [[ ${subobtain[$count]} -gt ${subtotal[$count]} ]]; do
					
					subobtain[$count]=$(asking "Marks Obtained")
					
					# If user enters obtained marks more then total marks an error message will be displayed
					if [[ ${subobtain[$count]} -gt ${subtotal[$count]} ]]; then
						wait "Error: Marks Obtained can't be more then Total Marks."	
					fi
				done
				gobtain=$(( gobtain+"${subobtain[count]}" ))
			
				(( count++ ))
			done
			count=0
			clear
			line 1
			echo " Details Marks Certificate"
			line 1
			printf "%15s %-30s %15s %-30s\n" "Student Name :" "$sname" "Father Name :" "$fname"
			printf "%15s %-30s %15s %-30s\n" "Registration :" "$regno" "Roll Number :" "$rno"
			printf "%15s %-30s %15s %-30s\n" "Study Class  :" "$class" "Session/Year:" "$session"
			line 1
			printf " %-10s %-40s %-20s %-20s\n" "Sr. No." "Subject" "Total Marks" "Obtained Marks"
			line 1
			while [[ $count < $subno ]]; do
				printf "  %-10d %-40s %-20d %-20d\n" "$((count+1))" "${subname[$count]}" "${subtotal[$count]}" "${subobtain[$count]}"
				(( count++ ))
			done
			line 1
			percentage=$(echo "$gobtain / $gtotal" | bc -l)
			percentage=${percentage:1:2}
			printf "   %-50s %-20d %-20d(%d Per)\n" " " "$gtotal" "$gobtain" "$percentage"
			line 1
			count=0
			read -p " Do you want to save DMC [Y or y] : " choice
			if [[ $choice = [Yy] ]]; then
				echo "$sname:$fname:$regno:$rno:$class:$session:$gtotal:$gobtain:$percentage:$subno" >> $myFile1
				echo -n "$regno:$rno" >> $myFile2
				while [[ $count -lt $subno ]]; do
					echo -n ":${subname[count]}:${subtotal[count]}:${subobtain[count]}" >> $myFile2
					(( count++ ))
				done
				echo >> $myFile2
				echo " Database is updating..."
				sleep 3
			else
				line 1
				wait "You didn't choose [Y] or [y] to save database, so database didn't updated, Press <Enter> to proceed..." 1
				
			fi
			;;
		2)
			# Refreshing variables
			clearVariables
			clear
			line
			echo " Record Searching Seciton"
			line
			regno=$(asking "Registration No")
			rno=$(asking "Roll No  ")
			if [[ $regno = "" || $rno = "" ]]; then
				sname=$(asking "Studnet Name")
			fi
			if [[ ($regno = "" && $sname = "") || ($rno = "" && $sname = "") ]]; then
				wait "You must enter at least two information for search. Press <Enter> to continue.." 1
				continue
			fi
			clear
			line
			echo " Search Results"
			line
			if [[ $regno = "" ]]; then
				searchingRecord "$sname" "$rno"
			elif [[ $rno = "" ]]; then
				searchingRecord "$sname" "$regno"
			else
				searchingRecord "$regno" "$rno"
			fi
			line
			selection=$(yesno "Is this information correct [Y-N]: ")
			if [[ $selection = [Yy] ]]; then
				<<<<<----------------------- Will be started from here ----------------------->>>>>
			else
				wait "Try again.." 1
			fi
			;;
		3)
			;;
		4)
			clear
			echo " Allah Hafiz (Goodbye)"
			break
			;;
		*)
			echo
			wait "Wrong selection, please select from [1-4], press <Enter> key to proceed.." 1
			;;
	esac		
done