#!/bin/bash

project=project01
env=${DEPLOYMENT_GROUP_NAME}
region=ap-northeast-1

DB_NAME=wordpress
DB_USER=root
DB_PASSWORD=$(aws ssm get-parameter --name "/${project}/${env}/aurora-mysql/master_password" --with-decryption --query 'Parameter.Value' --region ${region})
AUTH_KEY=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/auth_key" --with-decryption --query 'Parameter.Value' --region ${region})
SECURE_AUTH_KEY=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/secure_auth_key" --with-decryption --query 'Parameter.Value' --region ${region})
LOGGED_IN_KEY=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/logged_in_key" --with-decryption --query 'Parameter.Value' --region ${region})
NONCE_KEY=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/nonce_key" --with-decryption --query 'Parameter.Value' --region ${region})
AUTH_SALT=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/auth_salt" --with-decryption --query 'Parameter.Value' --region ${region})
SECURE_AUTH_SALT=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/secure_auth_salt" --with-decryption --query 'Parameter.Value' --region ${region})
LOGGED_IN_SALT=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/logged_in_salt" --with-decryption --query 'Parameter.Value' --region ${region})
NONCE_SALT=$(aws ssm get-parameter --name "/${project}/${env}/wordpress/nonce_salt" --with-decryption --query 'Parameter.Value' --region ${region})

cat <<EOF > /root/.env
DB_NAME=${DB_NAME}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_HOST=aurora-mysql.${env}-${project}.local
AUTH_KEY=${AUTH_KEY}
SECURE_AUTH_KEY=${SECURE_AUTH_KEY}
LOGGED_IN_KEY=${LOGGED_IN_KEY}
NONCE_KEY=${NONCE_KEY}H
AUTH_SALT=${AUTH_SALT}
SECURE_AUTH_SALT=${SECURE_AUTH_SALT}
LOGGED_IN_SALT=${LOGGED_IN_SALT}
NONCE_SALT=${NONCE_SALT}
EOF
