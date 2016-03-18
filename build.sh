#!/bin/bash

docker build -t urodoz/drupal8-php5fpm-nginx .
docker tag urodoz/drupal8-php5fpm-nginx urodoz/drupal8-php5fpm-nginx:php5.6.4-nginx1.9.12