#!/bin/bash
#set -ex

#
# Install Salt
#

if [[ "$HOSTNAME" =~ ^master.* ]]; 
then
   /usr/bin/dnf install -y https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm
   /usr/bin/dnf install -y salt-master salt-minion salt-ssh salt-syndic salt-cloud salt-api
   /usr/bin/sed -i -e "s/#interface: 0.0.0.0/interface: 0.0.0.0/g" /etc/salt/master
   /usr/bin/sed -i -e "s/#publish_port: 4505/publish_port: 4505/g" /etc/salt/master
   /usr/bin/sed -i -e "s/#master: salt/master: $HOSTNAME/g" /etc/salt/minion
   /usr/bin/sed -i -e "s/#id:/id: $HOSTNAME/g" /etc/salt/minion
   /usr/bin/systemctl restart salt-master
   /usr/bin/systemctl restart salt-minion
   /usr/bin/sleep 30
   /usr/bin/salt-key -Dy
   /usr/bin/salt-key -Ay
   /usr/bin/mkdir -p /srv/salt
   echo OK-MASTER;
else
   /usr/bin/dnf install -y https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm
   /usr/bin/dnf install -y salt-minion
   /usr/bin/sed -i -e "s/#master: salt/master: master01.aws.karlesnine.com/g" /etc/salt/minion
   /usr/bin/sed -i -e "s/#id:/id: $HOSTNAME/g" /etc/salt/minion
   /usr/bin/systemctl restart salt-minion
   echo NOK-MINION
fi
