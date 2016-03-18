# Docker container for Drupal 8

Docker container with Nginx and PHP5-FPM configured to run [Drupal 8](https://www.drupal.org/8)

## Versions

Uses [Supervisor](http://supervisord.org/) to run all the processes

* PHP: 5.6.4
* Nginx: 1.9.12

## Use the image

To run the container with your Drupal8 code just run the next command replacing the path with your Drupal8 folder:

```bash
docker run -d --name=drupal8 -v /path/to/drupal8:/opt/code -p 0.0.0.0:80:80 urodoz/drupal8-php5fpm-nginx
```

## Using docker-compose

The next docker-compose sample can be used to run a Drupal8 application linked to a mysql server and smtp server using
the [namshi/smtp](https://github.com/namshi/docker-smtp) docker image.

```yaml
smtp:
  image: namshi/smtp

mariadb:
  image: mariadb:5.5.48
  mem_limit: 512m
  environment:
    - MYSQL_DATABASE=drupal
    - MYSQL_USER=drupal
    - MYSQL_ROOT_PASSWORD=secretpassword

php:
  image: urodoz/drupal8-php5fpm-nginx
  ports:
    - "0.0.0.0:80:80"
  links:
    - mariadb:mariadb.server
    - smtp:smtp.server
  volumes:
    - "./drupal8/folder:/opt/code:rw"
```

## Build the image

Use the next command to build the image:

```bash
git clone git@github.com:urodoz/docker-drupal8-nginx-php5fpm.git
cd docker-drupal8-nginx-php5fpm
sh build.sh
```

## Sources

* [Github](https://github.com/urodoz/docker-drupal8-nginx-php5fpm)
* [Docker Hub Repository](https://hub.docker.com/r/urodoz/drupal8-php5fpm-nginx/)

