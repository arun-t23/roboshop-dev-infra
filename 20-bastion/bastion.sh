#!/bin/bash

growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

### in case want to reduce the volume
# sudo lvreduce -r -L 6G /dev/mapper/RootVG-rootVol


sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

sudo yum -y install terraform