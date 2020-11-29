#Welcome to Address Book Problem 

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
