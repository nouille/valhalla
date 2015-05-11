!/bin/bash
#INSTALLATION NAGIOS/CENTREON
apt-get install sudo tofrodos bsd-mailx lsb-release mysql-server libmysqlclient15-dev \
    apache2 apache2-mpm-prefork php5 php5-mysql php-pear php5-ldap php5-snmp php5-gd \
    rrdtool librrds-perl libconfig-inifiles-perl libcrypt-des-perl libdigest-hmac-perl \
    libdigest-sha1-perl libgd-gd2-perl snmp snmpd libnet-snmp-perl libsnmp-perl
apt-get install snmp-mibs-downloader unzip
#INSTALLATION NAGIOS
cd /tmp/
wget http://downloads.sourceforge.net/project/nagios/nagios-4.x/nagios-4.1.0/nagios-4.1.0rc1.tar.gz /tmp/
sudo /usr/sbin/useradd nagios
sudo passwd nagios
sudo /usr/sbin/groupadd nagios
sudo /usr/sbin/usermod -G nagios nagios
sudo /usr/sbin/usermod -G nagios www-data
tar xzf nagios-4*
cd nagios-4.1.0rc1
./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-command-user=nagios --with-command-group
=nagios --enable-event-broker --enable-nanosleep --enable-embedded-perl --with-perlcache
make
make all
make fullinstall
ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
#NAGIOS UTILS
cd /tmp/
wget http://nagios-plugins.org/download/nagios-plugins-2.0.tar.gz
tar xzf nagios-plugins-2.0.tar.gz
cd nagios-plugins-2.0
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make
make install
#Check Nagios Install
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
sudo service nagios start
