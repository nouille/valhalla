!/bin/bash
#SCRIP INSTALL CENTREON
#Telechargement
cd /tmp/
wget http://www.nicolargo.com/blogdata/ndo2db
wget http://downloads.sourceforge.net/project/nagios/ndoutils-1.x/ndoutils-1.5.2/ndoutils-1.5.2.tar.gz
#Script Init
mv ndo2db /etc/init.d/
#Base MySQL
mysqladmin -u root -p'1Passw0rd' create ndo
echo  << EOF > mysqladmin -u root -p create ndo
GRANT ALL ON ndo.* TO "ndouser"@"localhost" IDENTIFIED BY "ndopassword"; 
EOF
#InstallNDOutils
tar zxvf ndoutils-1.5.2.tar.gz
cd ndoutils-1.5*
./configure --disable-pgsql --with-mysql-lib=/usr/lib/mysql --with-ndo2db-user=nagios --with-ndo2db-group=nagios
make
cp src/ndomod-3x.o /usr/local/nagios/bin/ndomod.o
cp src/ndo2db-3x /usr/local/nagios/bin/ndo2db
