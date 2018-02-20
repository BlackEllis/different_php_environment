FROM centos:7

RUN yum -y update
RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum clean all && \
    yum -y install nginx logrotate

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./reverse_proxy.conf /etc/nginx/conf.d/reverse_proxy.conf
COPY ./logrotate.conf /etc/logrotate.conf

COPY ./ssl-keys /etc/nginx/certs
RUN cat /etc/nginx/certs/server_qed.crt /etc/nginx/certs/public_key.csr > /etc/nginx/certs/server_qed.pem
RUN chmod 400 /etc/nginx/certs/secret_key.key

# Define working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80 443

# Define default command.
ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
