#!/bin/bash



#./tool.sh
# print welcome message when programm is executed without any parameter
if [ $# -eq 0 ] #if I have no arguments
then 
	# echo "1047332-1057603"
 	echo "Welcome to the file content manipulator. Please read the README for details on how to use it."
fi



#./tool.sh -f <file>
# print datafile 's content
if [ $# -eq 2 ] # if I have two arguments
then
	DataFile="$2"
	grep -v "^#" $DataFile # grep those that are not comments
fi



#./tool.sh -f <file> -id <id>
# print name, surname, birthdate using id
if [[ $# -eq 4 ]] # if I have four arguments
then
	flag1=false
	if [[ "$1" == "-f" && "$3" == "-id" ]] # version: ./tool.sh -f <file> -id <id>
	then 
		DataFile="$2"
		userID="$4"
		flag1=true
	fi
	if [[ "$1" == "-id" && "$3" == "-f" ]] # version: ./tool.sh -id <id> -f <file> 
	then 
		DataFile="$4"
		userID="$2"
		flag1=true
	fi
	if [ "$flag1" == true ]
	then
			grep "^$userID" < $DataFile | cut -d'|' -f2,3,5 --output-delimiter=' '
	fi
fi


#./tool.sh --firstnames||lastnames -f <file>
# print firstnames||lastnames alphabetically
if [[ $# -eq 3 ]] # if I have three arguments
then
	if [[ "$2" == "-f" ]] # version: ./tool.sh --firstnames||--lastnames -f <file>
	then 
		DataFile="$3"
		typeOfNames="$1" 
	fi
	if [[ "$1" == "-f" ]] # version: ./tool.sh -f <file> --firstnames||--lastnames 
	then 
		DataFile="$2"
		typeOfNames="$3"
	fi
	if [[ "$typeOfNames" == "--firstnames" ]] # if command is about firstnames
	then
		grep -v "^#" $DataFile  | cut -d'|' -f2 | sort -u
	fi
	if [[ "$typeOfNames" == "--lastnames" ]] # if command is about lastnames
	then
		grep -v "^#" $DataFile | cut -d'|' -f3 | sort -u
	fi
fi



#./tool.sh --born-since <dateA>||--born-until <dateB> -f <file>
# print lines for people born after or before a cetrain date
if [[ $# -eq 4 ]] # if I have four arguments
then
	if [[ "$3" == "-f" ]]  # version: ./tool.sh (--born-since <dateA>||--born-until <dateB>) -f <file>
	then
	DataFile="$4"
	typeOfCommand="$1"
	Date="$2"
	fi
	if [[ "$1" == "-f" ]] # version: ./tool.sh -f <file> (--born-since <dateA>||--born-until <dateB>) 
	then
	DataFile="$2"
	typeOfCommand="$3"
	Date="$4"
	fi
	if [[ "$typeOfCommand" == "--born-since" ]] # if command is born-since type
	then
		grep -v "^#" $DataFile | sort -r -t'|' -k5 > sotrtedOnDates.dat # create temporary file reverse sorted according to date 
		grep -n "$Date" sotrtedOnDates.dat | cut -d':' -f1 > keepPeaople.dat # find people with the wanted date
		lastMatch=$(tail -n 1 < keepPeaople.dat) #find last line with wanted date
		rm keepPeaople.dat # delete temporary file
		head -n "$lastMatch" sotrtedOnDates.dat # print lines for people born since date
		rm sotrtedOnDates.dat # delete temporary file
	fi 
	if [[ "$typeOfCommand" == "--born-until" ]] # if command is born-until type
	then
		grep -v "^#" $DataFile | sort -t'|' -k5 > sotrtedOnDates.dat # create temporary file sorted according to date 
		grep -n "$Date" sotrtedOnDates.dat | cut -d':' -f1 > keepPeaople.dat # find people with the wanted date
		lastMatch=$(tail -n 1 < keepPeaople.dat) #find last line with wanted date 
		rm keepPeaople.dat # delete temporary file
		head -n "$lastMatch" sotrtedOnDates.dat  # print lines for people born until date
		rm sotrtedOnDates.dat # delete temporary file
	fi 
fi 



 
#./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
# print lines for people born between two dates
if [[ $# -eq 6 ]] # if I have six arguments
then
	flag2=false
	if [[ "$1" == "--born-since" && "$3" == "--born-until" && "$5" == "-f" ]] # version: ./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
	then
		DataFile="$6"
		sDate="$2"
		uDate="$4"
		flag2=true
	fi
	if [[ "$1" == "--born-until" && "$3" == "--born-since" && "$5" == "-f" ]] # version: ./tool.sh --born-until <dateB> --born-since <dateA> -f <file>
	then
		DataFile="$6"
		sDate="$2"
		uDate="$4"
		flag2=true
	fi
	if [[ "$1" == "-f" && "$3" == "--born-since" && "$5" == "--born-until" ]] # version: ./tool.sh -f <file> --born-since <dateA> --born-until <dateB> 
	then
		DataFile="$2"
		sDate="$4"
		uDate="$6"
		flag2=true
	fi
	if [[ "$1" == "-f" && "$3" == "--born-until" && "$5" == "--born-since" ]] # version: ./tool.sh -f <file> --born-until <dateB> --born-since <dateA> 
	then
		DataFile="$2"
		sDate="$6"
		uDate="$4"
		flag2=true
	fi
	if [[ "$1" == "--born-since" && "$3" == "-f" && "$5" == "--born-until" ]] # version: ./tool.sh --born-since <dateA> -f <file> --born-until <dateB> 
	then
		DataFile="$4"
		sDate="$2"
		uDate="$6"
		flag2=true
	fi
	if [[ "$1" == "--born-until" && "$3" == "-f" && "$5" == "--born-since" ]] # version: ./tool.sh --born-until <dateB> -f <file> --born-since <dateA> 
	then
		DataFile="$4"
		sDate="$6"
		uDate="$2"
		flag2=true
	fi
	if [ "$flag2" == true ]
	then
		grep -v "^#" $DataFile | sort -r -t'|' -k5 > s_sotrtedOnDates.dat # create temporary file reverse sorted according to date 
		grep -n "$sDate" s_sotrtedOnDates.dat | cut -d':' -f1 > s_keepPeaople.dat # find people 's id with the wanted date
		s_lastMatch=$(tail -n 1 < s_keepPeaople.dat) #find last line with wanted date
		rm s_keepPeaople.dat # delete temporary file
		head -n "$s_lastMatch" s_sotrtedOnDates.dat > new.dat # create new temporar file with lines for people born since <dateA>
		rm s_sotrtedOnDates.dat # delete temporary file
		grep -v "^#" new.dat | sort -t'|' -k5 > u_sotrtedOnDates.dat # create temporary file sorted according to <dateB> 
		rm new.dat  # delete temporary file
		grep -n "$uDate" u_sotrtedOnDates.dat | cut -d':' -f1 > u_keepPeaople.dat # find people with the wanted date
		u_lastMatch=$(tail -n 1 < u_keepPeaople.dat) #find last line with wanted date 
		rm u_keepPeaople.dat # delete temporary file
		head -n "$u_lastMatch" u_sotrtedOnDates.dat  # print lines for people born until <dateB> and since <dateA>
		rm u_sotrtedOnDates.dat # delete temporary file	
	fi
fi


# ./tool.sh --socialmedia -f <file> 
# print social socialmedia and its users
if [[ $# -eq 3 ]] # if I have three arguments
then
	flag3=false
	if [[ "$1" == "--socialmedia" && "$2" == "-f" ]] # version: ./tool.sh --socialmedia -f <file> 
	then 
		DataFile="$3"
		flag3=true
	fi
	if [[ "$1" == "-f" && "$3" == "--socialmedia" ]] # version: ./tool.sh-f <file> --socialmedia
	then 
		DataFile="$2"
		flag3=true
	fi
	if [ "$flag3" == true ]
	then
		grep -v "^#" $DataFile | cut -d'|' -f9 | sort > allSocialmedia.dat # create a file with socialmedia put alphabetically
		IFS=$'\n' read -d '' -r -a socialmedia < allSocialmedia.dat #put allSocialmedia.dat in an array
		sort -u allSocialmedia.dat > socialmediaOnce.dat # create a file with socialmedia put alphabetically appearing once
		IFS=$'\n' read -d '' -r -a socialM < socialmediaOnce.dat #put socialmediaOnce.dat in an array
		rm allSocialmedia.dat
		rm socialmediaOnce.dat
		socialmedialength=$((${#socialmedia[@]}-1))
		socialMlength=$((${#socialM[@]}-1))
		for x in `seq 0 $socialMlength` ;
		do 
			counter=0
			for y in `seq 0 $socialmedialength` ;
			do 
				if [ "${socialmedia[$y]}" == "${socialM[$x]}" ]
				then
					counter=$(($counter+1)) #count how many use a specific sociamedia
				fi
			done
			a=$counter
			echo -e "$counter\040${socialM[$x]}"
		done
	fi
fi





# ./tool.sh -f <file> --edit <id> <column> <value> 
#replace <column> with <value>
if [[ $# -eq 6 ]] # if I have six arguments
then
	flag4=false
	if [[ "$1" == "-f" && "$3" == "--edit" ]] # version: ./tool.sh -f <file> --edit <id> <column> <value>
	then 
		col="$5"
		val="$6"
		id="$4"
		DataFile="$2"
		flag4=true
	fi
	if [[ "$1" == "--edit" && "$3" == "-f" ]] # version: ./tool.sh --edit <id> -f <file> <column> <value>  
	then 
		col="$5"
		val="$6"
		id="$2"
		DataFile="$4"
		flag4=true
	fi
	if [[ "$1" == "-f" && "$5" == "--edit" ]] # version: ./tool.sh -f <file> <column> <value> --edit <id> 
	then 
		col="$3"
		val="$4"
		id="$6"
		DataFile="$2"
		flag4=true
	fi
	if [[ "$1" == "--edit" && "$5" == "-f" ]] # version: ./tool.sh --edit <id>  <column> <value> -f <file>
	then 
		col="$3"
		val="$4"
		id="$2"
		DataFile="$6"
		flag4=true
	fi
	if [[ "$3" == "-f" && "$5" == "--edit" ]] # version: ./tool.sh <column> <value> -f <file> --edit <id> 
	then 
		col="$1"
		val="$2"
		id="$6"
		DataFile="$4"
	fi
	if [[ "$3" == "--edit" && "$5" == "-f" ]] # version: ./tool.sh <column> <value> --edit <id> -f <file>  
	then 
		col="$1"
		val="$2"
		id="$4"
		DataFile="$6"
		flag4=true
	fi
	if [ "$flag4" == true ]
	then
		if [[ $col -ge 2 && $col -le 8 ]] # check if column are is an acceptable number 
		then
			grep -v "^#" $DataFile | cut -d'|' -f1  > allid.dat # create a file with socialmedia put alphabetically
			IFS=$'\n' read -d '' -r -a IDs < allid.dat #put allid.dat in an array
			rm allid.dat
			IDslength=$((${#IDs[@]}-1))
			for x in `seq 0 $IDslength` ;
			do 
				if [ "${IDs[$x]}" == "$id" ] # check if id exists in the file searching the IDs array
				then
					colval=$(grep "^$id" $DataFile | cut -d'|' -f"$col") #find line with wanted id then store wanted column 's value in colval
					grep "$id" $DataFile | replace "$colval" "$val" -- $DataFile #replace old value with new finding the wanted line using id as key
				fi
			done
		fi
	fi
fi
