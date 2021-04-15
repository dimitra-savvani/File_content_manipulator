### Shell-Scripting ###
File content manipulation

## Download tool.sh script, dates.dat and event.dat example datafiles. Run the following commands to have the explained result. ##

* prints Welcome when programm is executed without any parameter
```
./tool.sh
```

* prints datafile 's content
```
./tool.sh -f <file>
```

* prints name, surname, birthdate using id
```
./tool.sh -f <file> -id <id>
```
* prints firstnames||lastnames alphabetically
```
./tool.sh --firstnames||lastnames -f <file> 
```

* prints lines for people born after or before a cetrain date
```  
./tool.sh --born-since <dateA>||--born-until <dateB> -f <file>
```

* prints lines for people born between two dates
```
./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
```

* prints social socialmedia and its users
```
./tool.sh --socialmedia -f <file> 
```

* replace <column> with <value>
```
./tool.sh -f <file> --edit <id> <column> <value> 
```
