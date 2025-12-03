
INPUT="employees.csv"
NEW_USERS=0
NEW_GROUPS=0
while IFS=',' read -r FIRST LAST DEPT; do  #this line basicalaly splits with commas
    [[ "$FIRST" == "First" || -z "$FIRST" || -z "$LAST" || -z "$DEPT" ]] && continue
USERNAME=$(echo "${FIRST:0:1}${LAST:0:7}" | tr '[:upper:]' '[:lower:]') #creats usernames, also converts to lower cas
DEPT=$(echo "$DEPT" | tr -d '\r' | xargs)

if id "$USERNAME" &>/dev/null; then  #i used if statements  in this case checks if the user exists if not then contin
        echo "User $USERNAME already exists." #output  for terminal and for user to see same as below 
        continue
 fi
 if ! getent group "$DEPT" > /dev/null; then  #same as before but checks group and not user ;)
        groupadd "$DEPT"
        ((NEW_GROUPS++))   #any time i use ++ its an increment
    fi
 useradd -m -g "$DEPT" "$USERNAME"
    ((NEW_USERS++))
done < "$INPUT"
echo "Added $NEW_USERS users and $NEW_GROUPS groups." #output line for user to see

