#Welcome to Address Book Problem 

#add.sh

#!/bin/bash

BOOK="address-book2.txt"

# Ask the user for a name and assign to a variable
echo -n "Enter FirstName of person: "
read FirstName
echo -n "Enter LastName of person: "
read LastName
echo -n "Enter the address of person: "
read Address
echo -n "Enter the city of person: "
read City
echo -n "Enter the state of person: "
read State
echo -n "Enter the ZipCode of person: "
read Zipcode
echo -n "Enter the Phone number of person: "
read phone

echo -n "y/n: "
read answer

if [ "$answer" == "y" ]
then
      # Write the values to the address book
      echo "$FirstName ; $LastName ; $Address ; $City ; $State ; $Zipcode ; $phone ; " >>$BOOK
      echo "Written to $BOOK"
else
      # Give the user a message
      echo "NOT written to $BOOK"
fi

exit 0


#display.sh

#!/bin/bash

# Read each line in the book and display
(awk -F ";" '{printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK ;
 echo "Press Q to Quit and return to main menu." ) | less

#find.sh

#!/bin/bash

# Ask the user what to search.
echo -n -e "Enter the option to search from: \nfirstname, lastname, address, city, state, zipcode, or phone: "
read field

echo -n "In the $field, Enter what to search ? "
read string

# Find the string in the selected field
case $field in

      "firstname" ) # Search for a specific name
                     awk -v var=$string -F ";" '$1 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                     ;;
       "lastname" ) # Search for a specific name
                     awk -v var=$string -F ";" '$2 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                     ;;

        "address" ) # Search for a specific address
                      awk -v var=$string -F ";" '$3 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                      ;;

           "city" ) # Search for a specific city
                     awk -v var=$string -F ";" '$4 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                     ;;

          "state" ) # Search for a specific  state
                      awk -v var=$string -F ";" '$5 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                     ;;

        "zipcode" ) # Search for a specific zipcode
                     awk -v var=$string -F ";" '$6 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                     ;;

          "phone" ) # Search for a specific phone number
                      awk -v var=$string -F ";" '$7 ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK | less
                     ;;

              "*" ) # Search pattern not recognized
                     echo "Invalid Option";
                     ;;
esac

        echo "Result = $result";

if [ "$result" != "" ]
then
      for number in $result
      do
             awk -v val=$number  -F ";" 'NR == val {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6,$7}' $BOOK
      done
else
      echo "Did not find $string in $field"
fi

exit 0

#delete.sh
#!/bin/bash

# Ask the user which line to delete
echo -n "Enter the line number to delete: "
read number

# Display the record selected
awk -v var=$number -F ";" 'NR ~ var {printf " %d,%s,%s,%s,%s,%s,%s,%s\n", NR, $1, $2, $3, $4, $5, $6, $7}' $BOOK

# Ask the user if this is correct before deleting.
echo -n "Can i delete the above entry? (y/n): "
read answer

# Lower case the answer and check
newanswer=`echo $answer | tr "A-Z" "a-z"`;

if [ "$newanswer" = "y" ]
then

      # Rename the file before deleting
      mv $BOOK boo.txt

      # Add line numbers and delete against that number
      nl --number-format=rz --number-separator=":" boo.txt | grep -v 0$number: | awk -F: '{print $2}' |  tee $BOOK

else
      echo "Did not delete the entry"
fi


#Addressbook
#!/bin/bash
# Name of address book
BOOK="address-book2.txt"

export BOOK
exit=0

while [ $exit -ne 1 ]
do
      clear
      echo "Enter the operation to perform?"
      echo -e "add, display, find, delete, exit: "
      read answer

      if [ "$answer" = "add" ]
      then
                ./add.sh
      elif [ "$answer" = "display" ]
      then
                ./display.sh
      elif [ "$answer" = "find" ]
      then
                ./find.sh
      elif [ "$answer" = "delete" ]
      then
                ./delete.sh
      elif [ "$answer" = "exit" ]
      then
                exit=1
      else
              echo " Command is Invalid."
      fi
done

exit 0

