FROM bahmni/bahmni_centos67
RUN yum install -y wget openssh-server openssh-clients python-setuptools
RUN yum install -y http://repo.mybahmni.org.s3.amazonaws.com/rpm/bahmni/bahmni-installer-0.91-50.noarch.rpm
ADD setup.yml /etc/bahmni-installer/setup.yml
ADD local /etc/bahmni-installer/local
RUN wget https://dl.bintray.com/bahmni/rpm/ansible-2.2.0.0-3.el6.noarch.rpm && yum install -y ansible-2.2.0.0-3.el6.noarch.rpm
RUN bahmni -i local install
ENTRYPOINT find /var/lib/mysql -type f -exec touch {} \; ; service mysqld restart ; bahmni -i local start ; /bin/bash
