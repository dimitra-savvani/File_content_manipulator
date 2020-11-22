### Shell-Scripting ###
File content manipulation

Download tool.sh script and dates.dat and event.dat example datafiles. Run the following commands to have the explained result.

./tool.sh
-> print Welcome when programm is executed without any parameter

./tool.sh -f <file>
-> print datafile 's content
  
./tool.sh -f <file> -id <id>
-> print name, surname, birthdate using id
  
./tool.sh --firstnames||lastnames -f <file> 
-> print firstnames||lastnames alphabetically
  
./tool.sh --born-since <dateA>||--born-until <dateB> -f <file>
-> print lines for people born after or before a cetrain date
  
./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
-> print lines for people born between two dates
  
./tool.sh --socialmedia -f <file> 
-> print social socialmedia and its users
  
./tool.sh -f <file> --edit <id> <column> <value> 
->replace <column> with <value>
