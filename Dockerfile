

#FROM scratch
#ADD ubuntu-trusty-core-cloudimg-amd64-root.tar.gz /
FROM ubuntu:14.04
 
 
###### add source list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty main restricted" > /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-updates main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-updates universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list
 


##### install repo
RUN apt-get install -y mysql-server
 
##### clean cache package
RUN apt-get autoclean
 
RUN sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN /usr/sbin/mysqld & \
    sleep 10s &&\
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
 
##### open port
EXPOSE 3306

##### run mongo
CMD ["/usr/bin/mysqld_safe"]
