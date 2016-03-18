FROM ubuntu:15.04
MAINTAINER Albert Lacarta <urodoz@gmail.com>

RUN apt-get update

# Install Nginx from sources
RUN apt-get install -y wget && \
    cd /opt && wget http://nginx.org/download/nginx-1.9.12.tar.gz && \
    cd /opt && tar xvzf nginx-1.9.12.tar.gz && \
    cd /opt && mv nginx-1.9.12 nginx && \
    apt-get install -y python-dev python python-pip build-essential \
        libssl-dev libpcre3 libpcre3-dev && \
    cd /opt/nginx && ./configure \
        --sbin-path=/usr/local/nginx/nginx \
        --conf-path=/usr/local/nginx/nginx.conf \
        --pid-path=/usr/local/nginx/nginx.pid \
        --with-http_ssl_module && \
    cd /opt/nginx && make && make install && \
    rm -rf /opt/nginx

# Supervisor
RUN pip install supervisor --pre
ADD conf/supervisord.conf /etc/supervisord.conf
CMD supervisord -c /etc/supervisord.conf

# Install PHP 5.5-FPM
RUN apt-get install -y php5 php5-mysql php5-mcrypt php5-gd php5-fpm php5-pgsql php5-sqlite

# Configuration
ADD conf/nginx.conf /usr/local/nginx/nginx.conf
ADD conf/www.conf /etc/php5/fpm/pool.d/www.conf
ADD conf/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD conf/php.ini /etc/php5/fpm/php.ini

RUN mkdir -p /opt/code
WORKDIR /opt/code