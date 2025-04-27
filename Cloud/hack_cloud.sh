#!/bin/bash

###################################  Intro to AWS Pentesting 
## Hack Smarter - Tyler Ramsbey
##

figlet CloudHack | lolcat

# Reqs:  Kali VM, basic AWS knowledge



# step 1: 
# ----------------------------------------------------------------------------------
# setup free account https://aws.amazon.com/free/  
# > personal account > phone number > address > billing credit > verify account
# > basic support (free) > go to AWS Management Console

# Console Home:   <region>.console.aws.amazon.com/console/home?region=<region>
# search: budget > AWS Budgets > create a budget > Zero Spend budget > provide email > create budget (budget $1) 
# ----------------------------------------------------------------------------------


# step 2: 
# ----------------------------------------------------------------------------------
# AWS Command Line  https://aws.amazon.com/cli/ > https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

#--- install
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install
# aws --version
# ----------------------------------------------------------------------------------


# step 3:           install Cloud Goat:  https://github.com/RhinoSecurityLabs/cloudgoat
# ----------------------------------------------------------------------------------

# step 3.1 :        install terraform binary for Linux AMD64   https://developer.hashicorp.com/terraform/install
# cd ~/Downloads; ls;
# unzip terraform_1.11.4_linux_amd64.zip
# ./terraform -h
# sudo cp terraform /usr/local/bin/


# step 3.2 :
# sudo apt install jq


# step 3.3:         installing cloud goat
# pipx install git+https://github.com/RhinoSecurityLabs/cloudgoat.git


# step 3.4:         configure AWS access key 

# go to AWS Console > search: IAM > users > 
# create user > cloudgoat > attach policies directly > select AdministratorAccess > create user
# IAM Users (1): cloudgoat > click on cloudgoat > security credentials > 
#   create access key > Command Line Interface > cloudgoat > Access key: JKSUHSYSGASGSGS | Secret access key: *********


# step 3.5:         AWS CLI setup    kali terminal: 

# aws configure --profile cloudgoat

# AWS Access Key ID [None]:     <paste access key>
# AWS Secret Access Key [None]: <paste key>
# default region:               us-east-1
# default data output:          json

#-- AWS whoami --
# aws sts get-caller-identity --profile cloudgoat

# - - - - - - - - - - - - - - - -  -  -
# {
#     "UserId": "HDS8S83H3S7SGS77SYQ21",                    # 21 characters
#     "Account": "273682782772",                            # 12 numbers
#     "Arn": "arn:aws:iam::273682782772:user/cloudgoat"
# }
# - - - - - - - - - - - - - - - - - - -


# step 3.6:     configure AWS with cloudgoat

# cloudgoat config aws -y     # AWS profile: cloudgoat


# step 3.7:     whitelist your IP address
# cloudgoat config whitelist --auto
# ----------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------
# step 4:       installing pacu     https://github.com/RhinoSecurityLabs/pacu
# pipx install git+https://github.com/RhinoSecurityLabs/pacu.git
# pacu 

# what would you like to name this new session? cloudgoat
# Pacu (cloudgoat: no keys set)> search iam
# ----------------------------------------------------------------------------------


#========================[ setup complete ]






# ------------------------------------------------------------------
# IAM           = identity and access management   --- WHO (identity) can do WHAT (actions) to which RESOURCES (targets)
# users         = humans or apps (long term creds)
# groups        = grouping of users, permissions attached to the group
# policies      = JSON document that defines permissions: users/ groups/ roles , managed (reuseable) vs. inline
# roles         = similar to user but no long term creds

# misconfigurations
# - privilege escalation
# - lateral movement
# - exfiltrate data
# - establish persistence

# -- look for 
# users with excessive permissions
# roles that can be assumed
# policies with wildcards (*)
# services | Lambda functions   with elevated IAM permissions

# {
#     "Effect":"Allow",
#     "Action": "iam*",
#     "Resource": "*"
# } 
# ------------------------------------------------------------------


# ------------------------------------------------------- S3 Buckets

# S3        = simple storage service    'FTP in the cloud'

# uses      = static websites, backups, logs, etc
# buckets   = top level container, globally unique names
# objects   = actual data/ files

# access control 
#   bucket policies         (resource based)
#   IAM policies            (id based)
#   access control lists    (legacy)

# public access (list/Get)
#  misconfigured permissions
#  public write access
#  data exposure

# -------------------------------------------------


# ---------------------------------------------- AWS lambda functions
#  'serverless' compute
#  upload code -> AWS runs it
#  event driven
#  ec2 == virtual machines

# function, execution role, 
# triggers (event driven), 
# environment variables (access keys & secret keys)

# look for overly privileged execution roles
#   iam:PassRole
#   ec2:*
#   s3:*
#   secretsmanager:GetSecretValue

# Exposed Secrets:  env. variables, source code, writable functions

# ----------------------------------------------



# ---------------------------------------------- attacking EC2 instances

# EC2 = elastic compute cloud   'virtual machine'
#       OS, instance type, network config, IAM role

#  used for:    apps, development environments, web servers

# instances = EC2 machines
# security groups = 'firewalls'
# key pairs     public SSH
# elastic IPs
# instance metadata service   (startup scripts, credentials)
# IAM instance profile

# access to an EC2 === GOLD !
#   metadata, IAM permissions, exposed secrets

# look for:    
#   SSH ports,  {private IP} metadata endpoint ( http://x.x.x.x ) , user data {credentials}

# -- vuln policy
# 'Action': ["iam:PassRole", "lambda:CreateFunction"], "Resource": "*"

# ---------------------------------------------- 



# ------------------------------------------------------------------




# --- AWS cloud security training: https://cybr.com/

# --- Cloud hacking: https://pwnedlabs.io/  free content with walkthroughs 

# ===== [ REFERENCE ]   https://hackingthe.cloud/




echo "----------------------------"
echo "Access Key ID:" | lolcat
echo "07f6874135fec1d78fc4d5892c92595d" 
echo "Secret Access Key (password):" | lolcat
echo "df8b5319f57c0a7bd72cf72c4d8edea:3c35b8d1ccbe21" 
echo "Username:" |lolcat
echo "667f4e0a337b5f240-hack3r"
echo "----------------------------"
echo ""






# ----------------------------------------------- attacking EC2 instances
# ec2 enumeration lab

echo "--------------------------------- attack EC2"

echo "cloudgoat create ec2_ssrf"
sleep 5

echo "cloudgoat_output_solus_access_key_id = AKIAHATT28BBSHJVP"
echo "cloudgoat_output_solus_secret_key = e24sE8mqnCayJJz01ADkf6l6vueyYh9e"
echo ""

read -p "Enter profile name: " profile_name
echo ""
echo "aws configure --profile $profile_name"
read -p "AWS Access Key ID: " access_key
read -p "AWS Secret Access Key: " secret_key
read -p "Default region name: " region
echo "Default output format: json" 
echo ""
echo ""


# whoami
echo "aws sts get-caller-identity --profile $profile_name" | lolcat
cat ./files/ec2-solus.txt
echo ""
echo ""


# ---- method 1
# find any IPs then do a nmap scan in AWS web Console
# ec2 > actions > instance settings > edit user data > copy data 
# cat ./files/ec2-user-data.sh 

# AWS Console > IAM Roles > permissions > policy details
# "action": ["s3:*", "cloudwatch:*" ], "Effect": "Allow", "Resource": "*"

# ---- method 2
# enumeration
echo "aws ec2 decribe-instances --region $region --profile $profile_name" | lolcat
echo ""

cat ./files/describe-instance.json | grep -i "instanceid"
echo ""
echo ""

read -p "Enter AWS instance id: " instance
echo "aws ec2 describe-instances --instance-ids $instance --profile $profile_name" | lolcat
echo ""
echo ""
# can provide more information

# faster search for the instance IDs
echo "aws ec2 describe-instances --query \"Reservations[*].Instances[*].IamInstanceProfile.Arn\"  --profile $profile_name" | lolcat
echo "["
echo "   'arn:aws:iam::2872827787ww209:instance-profile/cg-ec2-instance-profile-cge1817111'"
echo "]"
echo ""
echo ""


echo "aws ec2 describe-security-groups --profile $profile_name" | lolcat
cat ./files/ec2-security-groups.json | grep -i "groupname"
cat ./files/ec2-security-groups.json | grep -i "CidrIp"
cat ./files/ec2-security-groups.json | grep -i "toport"



# ---------- pacu
echo "------------------------[ pacu ]"
echo "pacu"
echo "import_keys ec2"
echo "search ec2"
echo ""
echo "ec2__startup_shell_script"
echo "ec2__check_termination_protection"
echo "ec2__download_userdata"
echo "ec2__enum"
echo ""
echo ""


echo "run ec2__enum --region $region" | lolcat
sleep 3
echo "1 total instance found"
echo "3 total security groups found"
echo "..."
echo "data"
echo ""
echo ""
# prints out all of the data JSON



# echo "aws iam get-instance-profile --instance-profile-name  $instance_name  --profile $profile_name"

# echo ""














echo ""









