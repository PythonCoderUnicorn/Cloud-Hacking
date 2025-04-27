#!/bin/bash

# ------------------------------------------[ cybr labs ]
# aws configure --profile cybr

echo ""
echo "aws configure --profile cybr" | lolcat 
read -p "AWS Access Key ID: " access_key
read -p "AWS Secret Access Key: " secret_key
read -p "Default region name: " region
read -p "Default output format: " format

echo "[ AWS whoami ]" | lolcat
echo "aws sts get-caller-identity --profile cybr" | lolcat

sleep 4
cat ./cybr/cybr-profile.txt
echo ""
echo ""

sleep 4
echo "aws iam get-user --profile cybr" | lolcat
cat ./cybr/cybr-user.txt
echo ""
echo ""

sleep 4
echo "aws iam list-users --profile" | lolcat
cat ./cybr/cybr-users.txt
echo ""
echo ""


echo "aws iam list-access-keys --profile cybr" | lolcat
sleep 4
cat ./cybr/cybr-access-key.txt
echo ""
echo ""

sleep 4
echo "aws iam list-user-policies --user-name intro-to-aws-17452877775-Joel --profile cybr" | lolcat
cat ./cybr/user-policies.txt
echo ""
echo ""


sleep 4
echo "aws iam list-user-policies --user-name intro-to-aws-17452877775-Joel --policy-name AllowEnumerateRoles --profile cybr" | lolcat
cat ./cybr/policy-name.txt
echo ""
echo ""


sleep 4
echo "aws iam list-groups --profile cybr" | lolcat
cat ./cybr/cybr-groups.txt
echo ""
echo ""


sleep 4 
echo "aws iam list-groups-for-user --user-name intro-to-aws-17452877775-Joel --profile cybr" | lolcat
cat ./cybr/list-groups.txt
echo ""
echo ""

sleep 4
echo "aws iam get-group --group-name FAKEIAMGROUP001 --profile cybr" | lolcat
cat ./cybr/get-group.txt
echo ""
echo ""

sleep 4
echo "aws iam list-group-policies --group-name FAKEIAMGROUP001 --profile cybr" | lolcat
cat ./cybr/group-policies.txt
echo ""
echo ""

echo "aws iam get-group-policy --group-name FAKEIAMGROUP001 --policy-name WriteToLogs --profile cybr" | lolcat
cat ./cybr/group-policy-name.txt
echo ""
echo ""


# -- role enumeration
sleep 4
echo "aws iam list-roles --profile cybr" | lolcat 
cat ./cybr/list-roles.txt
echo ""
echo ""

sleep 4
echo "aws iam list-roles --query \"Roles[?RoleName=='SupportRole']\" --profile cybr" | lolcat
cat ./cybr/list-roles.txt | grep -i supportRole
echo ""
echo ""


sleep 4
echo "aws iam list-role-policies --role-rame SupportRole --profile cybr" | lolcat
cat ./cybr/list-role-policies.txt
echo ""
echo ""

sleep 4
echo "aws iam get-role-policy --role-name SupportRole --policy-name AllowS3FullAccessForRole --profile cyber" | lolcat
cat ./cybr/get-role-policy.txt
echo ""
echo ""




