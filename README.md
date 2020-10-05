# Connect-AWS-Azure-from-Mac
Shell script to connect to AWS &amp; Azure hosts from Mac

PreRequisites before executing the script
=================================
1. Copy both the connectcloud.sh & sample-hosts.file to a location in your mac
2. Rename the "sample-hosts.file" as "hosts.file" (Recommended - copy it in the same location where you have the "connectcloud.sh" script)
3. Enter the IP details with other recommended details used for connecting to your cloud stack as per the recommended format prescribed in the hosts.file 
   - [this  script supports AWS & Azure only]
4. Make the necessary changes to the variable definitions part in the connectcloud.sh
5. Make sure connectcloud.sh has executable permission and hosts.file has "read & write" permission
6. Run this script as "$. connectcloud.sh", from where the connectcloud.sh script is located.


