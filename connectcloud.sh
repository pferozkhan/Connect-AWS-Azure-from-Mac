#!/bin/bash

#===========================================================================================================================================
# save and run this script as "$. connectcloud.sh", from where this script is located.
# rename the "sample-hosts.file" as "hosts.file" and copy it in the same location where you have the "connectcloud.sh" shell script.
# this script "connectcloud.sh", will not work without the "hosts.file" and the needed hosts parameters included in the "hosts.file".
# make the needed changes in the "hosts.file", as discribed within the "hosts.file".
# after that make the below variable changes.
# changes to the below variables must be based on your environment settings.
#
# AWS_Key_Path - the path where your .pem file is located, which is used to connect your AWS EC2 instance.
# home_path - the path where you will copy this script & the hosts.file.
# hostfile - the path where the hosts file is located.
# pemFile - name of the .pem file, used for AWS EC2 instance connections.
#============================================================================================================================================

#variable definition
#===================
#alias AWS_Key_Path='cd /Users/1888/Documents/Work-Technical/AWS_KeyPairs/HWF/SplunkProd/'
alias AWS_Key_Path='cd /path/to/the/.PEM/file/'

#alias home_path='cd /Users/1888/'
alias home_path='cd /path/to/where/the/host & script/file/is/located/'

#hostfile=/Users/s1888/hosts.file
hostfile=/path/to/where/hosts.file is located

#pemFile=SplunkProd.pem - Only for AWS
pemFile=Name-of-the-PEM-File

Azuretmphostfile=/tmp/Azuretmphostfile
AWStmphostfile=/tmp/AWStmphostfile

#remove all tmp files
#====================
rm -f $Azuretmphostfile
rm -f $AWStmphostfile

#Azure cloud options & connection function
#=========================================
Azure() {
  cnt=1	
  echo " "
  echo "Azure Instances"
  echo "==============="

  stack=`cat $hostfile | awk '$0 == "--- hosts" {i=1;next};i && i++' | awk '$0 == "[Azure]"' | sed 's,.\(.*\).$,\1,g'`

  for i in `cat $hostfile | awk '$0 == "--- hosts" {i=1;next};i && i++' | awk '$0 == "[Azure]" {i=1;next};i && i++' | awk '/^$/{exit} 1'`; do
      tool=`echo $i | cut -d ',' -f1`
      server=`echo $i | cut -d ',' -f2`
      ip=`echo $i | cut -d ',' -f3`

      if [[ $stack == "Azure" ]]; then
	    echo "  $cnt) $stack - $tool - $server - $ip : enter $cnt"
            printf "$ip\\n" >> "$Azuretmphostfile"
            cnt=$((cnt+1))
      else
	    :
      fi
  done

  echo " "
  read -p "Enter choice : " choice
  connectiondetails=`sed -n $choice\p $Azuretmphostfile`
  c_ip=`echo $connectiondetails | head -$choice`
 
  echo " "
  read -p "Enter User Name : " userName
  echo "connecting $userName@$c_ip - mode[ssh]"
  ssh $userName@$c_ip
 
  home_path
  break
}

#AWS cloud options & connection function
#=======================================
AWS() {
  cnt=1	
  echo " "
  echo "AWS Instances"
  echo "============="

  stack=`cat $hostfile | awk '$0 == "--- hosts" {i=1;next};i && i++' | awk '$0 == "[AWS]"' | sed 's,.\(.*\).$,\1,g'`

  for i in `cat $hostfile  | awk '$0 == "--- hosts" {i=1;next};i && i++' | awk '$0 == "[AWS]" {i=1;next};i && i++' | awk '/^$/{exit} 1'`; do
      tool=`echo $i | cut -d ',' -f1`
      server=`echo $i | cut -d ',' -f2`
      ip=`echo $i | cut -d ',' -f3`

      if [[ $stack == "AWS" ]] || [[ $stack == "Ubuntu" ]] ; then
	    echo "  $cnt) $stack - $tool - $server - $ip : enter $cnt"
            printf "$ip\\n" >> "$AWStmphostfile"
            cnt=$((cnt+1))
      else
	    :
      fi
  done

  echo " "
  read -p "Enter choice : " choice
  connectiondetails=`sed -n $choice\p $AWStmphostfile`
  c_ip=`echo $connectiondetails | head -$choice`

  echo " "
  read -p "Enter User Name : " userName
  echo "connecting $userName@$c_ip using $pemFile - mode[ssh]"
  ssh -i $pemFile $userName@$c_ip
  home_path
  break
}

#exit function
#=============
fn_exit() {
  home_path
  break
}

#Menu display
#============
showMenu() {
  echo " "
  echo "Choose Cloud Stack"
  echo "=================="
  echo "  1) Azure : enter 1"
  echo "  2) AWS   : enter 2"
  echo " "
  echo "To Exit - enter 0"
  echo " "
}

#Option Reading
#==============
readOptions() {
  local choice
  read -p "Enter choice [1-2] : " choice
  case $choice in
     1) Azure ;;
     2) AWS ;;
     0) fn_exit ;;
  esac
}

#Main Program
#============
AWS_Key_Path

while true
 do
   showMenu
   readOptions
 done
