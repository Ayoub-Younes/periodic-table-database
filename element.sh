PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"
#!/bin/bash
ARG=$1
INFO(){
  if [[ $ARG =~ ^[0-9]+$ ]]
  then
   INFO=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $ARG")
  elif [[ $ARG =~ ^[A-Za-z]+$ ]]
   then
   INFO=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$ARG' OR name = '$ARG'")
  fi
  if [[ $INFO ]]
  then
   echo "$INFO" | while read TYPE_ID BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR SYMBOL BAR NAME BAR TYPE
  do
   echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  else
   echo "I could not find that element in the database."
  fi
}
if [[ -z $ARG ]]
  then
   echo "Please provide an element as an argument."
  else
   INFO
  fi
