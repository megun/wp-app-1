#!/bin/bash

isExistApp=pgrep nginx
if [[ -n $isExistApp ]]; then
    systemctl stop nginx.service
fi

isExistApp=pgrep php-fpm
if [[ -n $isExistApp ]]; then
    systemctl stop php-fpm.service
fi
