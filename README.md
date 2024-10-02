# Shell-Scripting: File Content Manipulation
This project contains a Bash script, `tool.sh`, that provides multiple functionalities for interacting with `.dat` files. These files (`dates.dat` and `events.dat`) contain structured data with various fields such as ID, name, birthday, location, and more. This script allows you to view, sort, and manipulate the data in various ways.

## Getting Started
Download the `tool.sh` script, along with the example data files `dates.dat` and `events.dat`. Both data files contain records in the following format:

```shell
#id|lastName|firstName|gender|birthday|creationDate|locationIP|browserUsed|socialmedia
```
To run the script, use a terminal, navigate to the folder where `tool.sh` is located, and make sure it has execute permissions:

```bash
chmod +x tool.sh
```
You can now execute the script with the various options described below.

## Available Commands
### No Parameters: Print Welcome Message
If you run the script without any parameters, it will print a welcome message:

```bash
./tool.sh
```
Output:

```
1047332-1057603
```

### 2. Print Datafile Contents
To display the contents of a specific data file (e.g., `dates.dat` or `events.dat`), use the `-f` option:

```bash
./tool.sh -f <file>
```
- `<file>`: The name of the file you want to print (e.g., `dates.dat` or `events.dat`).

Example:

```bash
./tool.sh -f dates.dat
```
This command will print all lines from the file, excluding any lines that are comments (starting with `#`).

### 3. Print Name, Surname, and Birthdate by ID
To retrieve specific user information based on their ID, use the `-id` flag along with the `-f` option:

```bash
./tool.sh -f <file> -id <id>
```
- `<file>`: The file to search in (e.g., `dates.dat` or `events.dat`).
- `<id>`: The ID of the user you want to find.
This will return the user's first name, last name, and birthdate.

Example:

```bash
./tool.sh -f dates.dat -id 1099511627782
```

### 4. Print First Names or Last Names Alphabetically
To list all unique first names or last names in alphabetical order, use either `--firstnames` or `--lastnames` followed by the `-f` option:

```bash
./tool.sh --firstnames -f <file>
```
or

```bash
./tool.sh --lastnames -f <file>
```
- `<file>`: The file to retrieve names from.

Example:

```bash
./tool.sh --firstnames -f events.dat
```
This command will sort and print all first names or last names (depending on the flag you use) alphabetically from the specified file.

### 5. Print Lines for People Born After or Before a Certain Date
To retrieve users based on their birthdates, use the following commands:

#### Born Since a Specific Date:
```bash
./tool.sh --born-since <dateA> -f <file>
```
- `<dateA>`: A date in the format `YYYY-MM-DD`. The script will print records of people born on or after this date.
- `<file>`: The file to search in.
  
#### Born Until a Specific Date:
```bash
./tool.sh --born-until <dateB> -f <file>
```
- `<dateB>~: A date in the format `YYYY-MM-DD`. The script will print records of people born on or before this date.
  
Example:

```bash
./tool.sh --born-since 1980-01-01 -f dates.dat
```

### 6. Print Lines for People Born Between Two Dates
To print the records of people born between two dates (inclusive), use the following command:

```bash
./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
```
- `<dateA>`: Start date (inclusive).
- `<dateB>`: End date (inclusive).
- `<file>`: The file to search in.
- 
Example:

```bash
./tool.sh --born-since 1980-01-01 --born-until 1990-12-31 -f events.dat
```

### 7. Print Social Media and its Users
To print a list of social media platforms along with the number of users for each platform, use the following command:

```bash
./tool.sh --socialmedia -f <file>
```
- `<file>`: The file to analyze.
This command will display the count of users per social media platform in the file.

Example:

```bash
./tool.sh --socialmedia -f dates.dat
```

### 8. Edit a Record: Replace Column Value by ID
You can modify specific fields in a record by providing the user ID, the column number, and the new value:

```bash
./tool.sh -f <file> --edit <id> <column> <value>
```
- `<file>`: The file to update.
- `<id>`: The ID of the user to modify.
- `<column>`: The column number to edit (e.g., 2 for `lastName`, 3 for `firstName`, etc.).
- `<value>`: The new value to set in the specified column.
  
Example:

```bash
./tool.sh -f events.dat --edit 1099511631844 4 female
```
This will update the `gender` (4th column) for the user with ID `1099511631844` to `female`.

## Data File Format
Both `dates.dat` and `events.dat` share the same format:

```shell
#id|lastName|firstName|gender|birthday|creationDate|locationIP|browserUsed|socialmedia
```
- **id**: Unique identifier for each record.
- **lastName**: Last name of the user.
- **firstName**: First name of the user.
- **gender**: Gender of the user.
- **birthday**: Birthdate of the user in `YYYY-MM-DD` format.
- **creationDate**: The date when the record was created, in `YYYY-MM-DDTHH:mm:ss.SSS+0000 `format.
- **locationIP**: The IP address associated with the record.
- **browserUsed**: The web browser used by the user.
-**socialmedia**: The social media platform the user is associated with.

## Conclusion
This script provides a flexible way to explore and manipulate `.dat` files with user information. You can retrieve, sort, and edit data using various parameters, making it a versatile tool for file content manipulation.

Feel free to modify the script to fit your needs or extend its functionalities!
