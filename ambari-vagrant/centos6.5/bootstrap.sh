#!/usr/bin/env bash

cp /vagrant/hosts /etc/hosts
cp /vagrant/resolv.conf /etc/resolv.conf
yum -y install wget
yum -y install mysql-server
yum install ntp -y
service ntpd start
chkconfig ntpd on
service iptables stop
service ip6tables stop
chkconfig iptables off
chkconfig ip6tables off
service mysqld start
chkconfig mysqld on
mkdir -p /root/.ssh; chmod 600 /root/.ssh; cp /home/vagrant/.ssh/authorized_keys /root/.ssh/
wget -q http://public-repo-1.hortonworks.com/ambari/centos6/1.x/updates/1.6.1/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum -q clean all
yum -q repolist
yum -q -y install ambari-server ambari-agent
/etc/init.d/ambari-server setup -s
wget --no-check-certificate https://raw.githubusercontent.com/saurabhmishra/Ambari/master/Ambari/ambari.properties  -O /etc/ambari-server/conf/ambari.properties
/etc/init.d/ambari-server start
chkconfig ambari-server on
/etc/init.d/ambari-agent start
chkconfig ambari-agent on
sleep 20
wget --no-check-certificate https://raw.githubusercontent.com/saurabhmishra/Ambari/master/Ambari/ambari_auto.sh -O /tmp/ambari_auto.sh
sh /tmp/ambari_auto.sh
