#!/bin/bash
echo "------------------"
echo "Inside QEMU image , Test for Image integrity"
echo "------------------"
echo "Following checks will be done"
echo """
        1. Login name verificaton with boot success
        2. Hostname check
        3. OpenSSH availability check
        4. SSH keygeneration check """
mkdir Integration_Test
cd Integration_Test
echo -e " \n Check for Login success with root"
whoami | tee -a Integrity_report.file > /dev/null
echo "Check for Hostname"
hostname | tee -a Integrity_report.file > /dev/null
echo "Checking for OpenSSH availability"
which ssh | tee -a Integrity_report.file > /dev/null
echo "Generating SSH keys"
ssh-keygen -b 2048 -t rsa -f sshtest -q -N ""
echo "SSH key generation and availability"
test -f sshtest.pub && echo  "exists"| tee -a Integrity_report.file > /dev/null  || echo "does not exist" | tee -a Integrity_report.file > /dev/null
echo "Integration Report generated...and available for viewing"

