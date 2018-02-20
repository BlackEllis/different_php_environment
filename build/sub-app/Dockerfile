FROM centos:7

RUN yum -y update
RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN yum clean all && \
    yum -y install  httpd httpd-devel \
        mod_ssl php php-cli php-common php-devel php-fpm \
        php-gd php-mbstring php-mysqlnd php-pdo php-xml \
        php-xml php-xmlrpc php-pecl-zip pdo pdo_mysql gcc git \
        which logrotate


# mod_rpafインストール
WORKDIR /tmp
RUN git clone https://github.com/gnif/mod_rpaf && \
        cd mod_rpaf && \
        make && \
        make install

# APACHE関係
COPY ./httpd/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./httpd/mod_rpaf.conf /etc/httpd/conf.d/mod_rpaf.conf

# PHP関係
COPY ./php/php.ini /etc/php.ini
COPY ./php/browscap.ini /etc/php.d/browscap.ini

# logrotate
COPY ./logrotate/logrotate.conf /etc/logrotate.conf
COPY ./logrotate/httpd /etc/logrotate.d/httpd

WORKDIR /var/www/html

# enable service.
RUN systemctl enable httpd.service

EXPOSE 25 80
# exec.
CMD ["/sbin/init"]
