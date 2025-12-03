#/bin/bash
# INternetBlocker.sh
#block http/https traffic for everyone other than it users
IT_USERS=$(awk -F, '{print $3}' EmployeeNames.csv | sort | uniq)

 #tgis will extract IT users
#now i need to make a loop or something similar to loop through it users and add rules
for user in $IT_USERS; do
sudo iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner $user -j ACCEPT
done #will allow https traffic for IT
#now i will add server exception
sudo iptables -A OUTPUT -p tcp --dport 443 -d 192.168.2.3 -j ACCEPT
#drop all special access
sudo iptables -t filter -A OUTPUT -p tcp --dport 8003 -j DROP
sudo iptables -t filter -A OUTPUT -p tcp --dport 1979 -j DROP
#message
USER_COUNT=$(echo "$IT_USERS" | wc -w)
echo "acces granted to $USER_COUNT users int he it department"
#note i can't figure out how to get rid of error messages but it does show users from it granted access, thiss class is starting to hurt my brain

