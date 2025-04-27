#!/bin/bash


# --------------------------------------- using PACU for AWS


echo "aws configure --profile cybr" | lolcat

read -p "AWS Access Key ID: " access_key
read -p "AWS Secret Access Key: " secret_key 
read -p "Default region name: " region
read -p "Default output format: " format

# whoami
echo "aws sts get-caller-identity --profile cybr" | lolcat


#----------------------- pacu
# option: 2
# import keys 

read -p "Pacu (cybr: No Keys Set) > " import_keys
echo "Imported keys as \"imported-cybr\" ";

read -p "Pacu (cybr:imported-cybr) > " cmd

if [ "$cmd" == "whoami" ]; then 
    cat ./cybr/pacu-cyber.txt
else
    echo ""
fi;
echo ""
echo ""



#> search iam
#   iam__enum_permissions
#   iam__enum_users_roles_policies_groups
#   iam__privesc_scan

echo "run iam__enum_users_roles_policies_groups" | lolcat
sleep 4
cat ./cybr/pacu-enum-users.txt
echo ""
echo ""


echo "data iam" | lolcat
sleep 2
cat ./cybr/pacu-data-iam.txt
echo ""
echo ""


echo "run iam__enum_permissions" | lolcat
sleep 2
cat ./cybr/pacu-enum-permissions.txt
echo ""
echo ""

# whoami
