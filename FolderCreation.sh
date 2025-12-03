#!/bin/bash
# FolderCreation

#departments
DEPARTMENTS=("HR" "IT" "Finance" "Executive" "Admin" "CallCentre")
#create directory
sudo mkdir -p /EmployeeData
#exists
for dept in "${DEPARTMENTS[@]}"; do
if ! getent group "$dept" >/dev/null; then
sudo groupadd "$dept"
echo "group has been created: $dept"
fi
done
#folder creation with permissions
for dept in "${DEPARTMENTS[@]}"; do
sudo mkdir -p "/EmployeeData/$dept"
echo "folder: /EmployeeData/$dept"
sudo chown -R root:"$dept" "/EmployeeData/$dept"
if [[ "$dept" == "HR" || "$dept" == "Executive" ]]; then
sudo chmod -R 770 "/EmployeeData/$dept"
echo "770 sensitive on /EmployeeData/$dept"
else
sudo chmod -R 764 "/EmployeeData/$dept"
echo "764 non sensitive on /EmployeeData/$dept"
fi
done

FOLDER_COUNT=${#DEPARTMENTS[@]}
echo "$FOLDER_COUNT folders ?EmployeeData"

