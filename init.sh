#!/bin/bash

git config --global --add http.https://devopstest.scb.intra/SCB/SCB/_git/.extraHeader "AUTHORIZATION: Basic $(printf ":$GIT_PERSONAL_ACCESS_TOKEN" | base64 -w0)"
git clone $GIT_REPOSITORY

sudo apt-get update
sudo apt-get install -y curl gnupg apt-transport-https

curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-prod.gpg > /dev/null
sudo curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list \
    -o /etc/apt/sources.list.d/mssql-release.list
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
sudo apt-get install -y unixodbc unixodbc-dev 

sudo debconf-set-selections <<< "krb5-config krb5-config/default_realm string SCB.INTRA"
sudo debconf-set-selections <<< "krb5-config krb5-config/kerberos_servers string SCB.INTRA"
sudo debconf-set-selections <<< "krb5-config krb5-config/admin_server string SCB.INTRA"

sudo apt-get install -y krb5-user

pip install pyodbc
