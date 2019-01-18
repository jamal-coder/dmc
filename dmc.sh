#!/bin/bash

############### Variables #################
myFile1=.info.txt
myFile2=.marks.txt
MAXSUB=20
MAXLIMIT=25

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
	declare -a subname
	declare -a subtotal
	declare -a subobtain
	gtotal=0
	gobtain=0
	percentage=0
}

function searchingRecord {
	grep -i "$1" $myFile1 | grep -i "$2" | awk -F ":" '{printf " Registeration No : %s\n Roll Number      : %s\n Student Name     : %s\n Father Name      : %s\n Class Refence    : %s\n Session          : %s\n Total Marks      : %s\n Marks Obtained   : %s\n Percentage(%)    : %s\n", $3, $4, $1, $2, $5, $6, $7, $8, $9}'
}

function obtainingRecord {
	case $1 in
		1) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $1}');;
		2) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $2}');;
		3) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $3}');;		
		4) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $4}');;	
		5) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $5}');;
		6) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $6}');;
		7) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $7}');;
		8) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $8}');;
		9) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $9}');;
		10) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $10}');;
		11) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $11}');;
		12) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $12}');;
		13) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $13}');;		
		14) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $14}');;	
		15) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $15}');;
		16) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $16}');;
		17) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $17}');;
		18) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $18}');;
		19) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $19}');;
		20) item=$(grep -i "$2" $4 | grep -i "$3" | awk -F ":" '{print $20}');;
	esac
	echo $item
}

# experimental functions
function experimental {
	echo $regno
	echo $rno
	echo $sname
	echo $fname
	echo $class
	echo $session
	echo $subno
	echo ${subname[@]}
	echo ${subtotal[@]}
	echo ${subobtain[@]}
	echo $gtotal
	echo $gobtain
	echo $percentage
}
function display {
	echo "$1 $2"
	wait "Press" 1
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
				
				while [[ $count -lt $subno ]]; do
					echo -n "${subname[count]}:${subtotal[count]}:${subobtain[count]}:" >> $myFile2
					(( count++ ))
				done
				echo -en "$regno:$rno:$sname\n" >> $myFile2
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
			regno=$(asking "Registration No     ")
			rno=$(asking "Roll No            ")
			if [[ $regno = "" || $rno = "" ]]; then
				sname=$(asking "Father or Student Name")
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
			# Getting record from files and assigning to the variables for further process
			if [[ $selection = [Yy] ]]; then
				if [[ $regno = "" ]]; then
					arg1="$rno"
					arg2="$sname"
				elif [[ $rno = "" ]]; then
					arg1="$regno"
					arg2="$sname"
				else
					arg1="$regno"
					arg2="$rno"
				fi
				# Obtaining record from database file 1 and assigning to variables for further process
				sname=$(obtainingRecord 1 "$arg1" "$arg2" "$myFile1")
				# If later on in the use the maximum character of a name exceeds change the value of MAXLIMIT at the start of the script
				if [[ ${#sname} -gt $MAXLIMIT ]]; then
		 			line
		 			wait "Refine your search upto one record please. Press <Enter> to proceed." 1
		 			line
		 			continue
		 		fi
				fname=$(obtainingRecord 2 "$arg1" "$arg2" "$myFile1")
				regno=$(obtainingRecord 3 "$arg1" "$arg2" "$myFile1")
				rno=$(obtainingRecord 4 "$arg1" "$arg2" "$myFile1")
				class=$(obtainingRecord 5 "$arg1" "$arg2" "$myFile1")
				session=$(obtainingRecord 6 "$arg1" "$arg2" "$myFile1")
				gtotal=$(obtainingRecord 7 "$arg1" "$arg2" "$myFile1")
				gobtain=$(obtainingRecord 8 "$arg1" "$arg2" "$myFile1")
				percentage=$(obtainingRecord 9 "$arg1" "$arg2" "$myFile1")
				subno=$(obtainingRecord 10 "$arg1" "$arg2" "$myFile1")
				# Obtaining record from database file 2 and assigning to variables for further process
				count=0
				# No of subject is multiplied by 3 to get exect number of record in the database
				MAX=$(( subno * 3 ))
				# loop variable is set to obtaing number of record according to the database sequance
				loop=1
				#######################################################################################
				# Problem is here when I want to get info or more then 7 subjects it doesn't work
				#######################################################################################
				while [[ $count -lt $subno ]]; do
					subname[$count]=$(obtainingRecord "$loop" "$arg1" "$arg2" "$myFile2")
					display "$loop" "${subname[count]}"
					# loop variable is increased by one to get next record
					((loop++))
					subtotal[$count]=$(obtainingRecord "$loop" "$arg1" "$arg2" "$myFile2")
					display "$loop" "${subtotal[count]}"
					# loop variable is increased by one to get next record
					((loop++))
					subobtain[$count]=$(obtainingRecord "$loop" "$arg1" "$arg2" "$myFile2")
					display "$loop" "${subobtain[count]}"
					# loop variable is increased by one to get next record
					((loop++))
					((count++))
				done
				#<<<<---------------- Start from Here ------------------->>>>>>
				clear
				count=0
				line
				echo " 1 > Student Name    : $sname"
				echo " 2 > Father Name     : $fname"
				echo " 3 > Roll No         : $rno"
				echo " 4 > Registration No : $regno"
				echo " 5 > Class           : $class"
				echo " 6 > Session         : $session"
				line 1
				printf " %-10s %-40s %-20s %-20s\n" "Sr. No." "Subject" "Total Marks" "Obtained Marks"
				line 1
				while [[ $count < $subno ]]; do
					printf "  %-10d %-40s %-20d %-20d\n" "$((count+1))" "${subname[$count]}" "${subtotal[$count]}" "${subobtain[$count]}"
					(( count++ ))
				done
				line 1
				printf "   %-50s %-20d %-20d(%d Per)\n" " " "$gtotal" "$gobtain" "$percentage"
				line 1
				#experimental
				wait "Press Enter to proceed.." 1
			else
				wait "Try again..." 1
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