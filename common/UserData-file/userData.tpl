#cloud-config
runcmd:
- /usr/bin/dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
- /usr/bin/dnf update -y
- /usr/bin/dnf install -y vim-enhanced htop curl wget python3-pip tree nmap-ncat
- /usr/bin/echo "alias vi=vim" >> ~/.bashrc
- /usr/bin/chown -R centos.centos /root/
- /usr/bin/cat /home/centos/.ssh/authorized_keys > /root/.ssh/authorized_keys
- /usr/bin/chown -R root.root /root/
- /usr/bin/pip3 install boto boto3 "urllib3<1.24" awscli
- /usr/local/bin/aws --region eu-central-1 s3 cp s3://${s3_bucket_setting_name}/ /tmp/ --recursive --exclude "*" --include "*.service"
- for I in $(ls -1 /tmp/*.service | /bin/sed 's/\/tmp\///g' ); do /bin/mv /tmp/$I /lib/systemd/system/; /bin/systemctl enable /lib/systemd/system/$I;/bin/systemctl daemon-reload ; done
- /usr/local/bin/aws --region eu-west-1 s3 cp s3://${s3_bucket_setting_name}/ /tmp/ --recursive --exclude "*" --include "*.sh"
- for I in $(ls -1 /tmp/*.sh | /bin/sed 's/\/tmp\///g' ); do /bin/mv /tmp/$I /usr/local/bin/; /bin/chmod a+x /usr/local/bin/$I; done
- /usr/sbin/service SetHostName start
- /usr/sbin/service DnsInstanceRecord start
- /usr/sbin/service MountLocalStorage start
- /usr/local/bin/SetSalt.sh
- sudo touch /tmp/UserDataDone.txt