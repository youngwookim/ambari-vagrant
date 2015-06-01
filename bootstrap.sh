#!/usr/bin/env bash

cp /vagrant/hosts /etc/hosts
cp /vagrant/resolv.conf /etc/resolv.conf
yum install ntp -y
service ntpd start
service iptables stop

[ -f /etc/yum.repos.d/ambari.repo ] || curl -Lso /etc/yum.repos.d/ambari.repo http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.0.1/ambari.repo
yum install ambari-agent -y
sed -i.bak "/^hostname/ s/.*/hostname=c6401.ambari.apache.org/" /etc/ambari-agent/conf/ambari-agent.ini
ambari-agent start
