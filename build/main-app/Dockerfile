# imageの元ファイル
FROM centos:7

RUN yum -y update
RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN yum -y install epel-release && \
    yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum clean all

RUN yum --enablerepo=remi,remi-php71 -y install \
    httpd httpd-devel mod_ssl php php-cli php-common php-devel \
    php-fpm php-gd php-mbstring php-mysqlnd php-pdo \
    php-xml php-xml php-xmlrpc php-pecl-zip pdo pdo_mysql \
    fftw3 libXt libtool-ltdl libmpc-devel mpfr-devel gmp-devel \
    gcc gcc-c++ git which wget logrotate poppler poppler-utils \
    perl-Digest-MD5

# tmpフォルダーに移動
WORKDIR /tmp

# mod_rpafインストール
RUN git clone https://github.com/gnif/mod_rpaf && \
        cd mod_rpaf && \
        make && \
        make install

# apache関係
COPY ./httpd/httpd.conf /etc/httpd/conf/httpd.conf
COPY ./httpd/add_handler.conf /etc/httpd/conf.d/add_handler.conf
COPY ./httpd/ssl.conf /etc/httpd/conf.d/ssl.conf
COPY ./httpd/mod_rpaf.conf /etc/httpd/conf.d/mod_rpaf.conf

COPY ./ssl-keys /etc/pki/tls/certs

# php関係
COPY ./php/php.ini /etc/php.ini
COPY ./php/browscap.ini /etc/php.d/browscap.ini

# logrotate
COPY ./logrotate/logrotate.conf /etc/logrotate.conf
COPY ./logrotate/httpd /etc/logrotate.d/httpd

WORKDIR /var/www/html

# enable service.
RUN systemctl enable httpd.service

EXPOSE 80 443

# exec.
CMD ["/sbin/init"]
