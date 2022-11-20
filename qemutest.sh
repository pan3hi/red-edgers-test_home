#!/bin/bash
source build/honister/oe-init-build-env full-qemux86-64 
cd tmp/deploy/images/qemux86-64 
echo -e "..... Runing QEMU image....\n\n\n. "
nohup runqemu qemux86-64 nographic slirp &
sleep 120s 
echo -e "\n Booting image with SUCCESS , Next Performing SCP and SSH and testing steps"
echo "Deleting previous folders"
ssh -o "StrictHostKeyChecking no" root@localhost -p 2222 "cd /home/root ; ls ;  rm -rf Integration_Test  "
ssh -o "StrictHostKeyChecking no" root@localhost -p 2222 "cd /home/root ; rm -rf commands.sh ; ls "
echo "Copying"
cd /workdir
scp -P 2222 -o StrictHostKeyChecking=no commands.sh root@localhost:/home/root/ 
echo "Copying done"
echo "iisuing Testing commands"
ssh -o "StrictHostKeyChecking no" root@localhost -p 2222 "cd /home/root ;ls ;./commands.sh "
echo "downlaoding report"
scp -P 2222 -o StrictHostKeyChecking=no root@localhost:/home/root/Integration_Test/Integrity_report.file .
echo "Exiting"

