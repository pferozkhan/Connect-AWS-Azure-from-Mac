# Connect-AWS-Azure-from-Mac
Shell script to connect to AWS &amp; Azure hosts from Mac


#=========================================================================================================
# Run this script as "$. connectcloud.sh", from where this script is located.
# change the below variables based on your environment.
#
# AWS_Key_Path - the path where your .pem file is located, which is used to connect your AWS EC2 instance.
# home_path - the path where you will copy this script & the hosts.file.
# hostfile - the path where the hosts file is located.
# pemFile - name of the .pem file, used for AWS EC2 instance connections.
#=========================================================================================================

#===================================================================================================================
# rename the "sample-hosts.file" as "hosts.file" and copy it in the same location where you have the "connectcloud.sh" shell script
# enter below your hosts details for connecting to your cloud stack [AWS & Azure] only.
# use the below comma seperated format for your hosts definition, after the [hosts] stanza line  
# NOTE: make sure you do not have any spaces or gaps in any of the lines
#
# CloudStack naming convention
#=============================
# Azure - must be entered as Azure
# AWS - must be entered as AWS
# Ubuntu - must be entered as Ubuntu
#
# FORMAT TO BE FOLLOWED: 
#=====================================
#CloudStack,Tool,ServerDescription,IP
#=====================================
# 
#===================================================================================================================
