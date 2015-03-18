#! /bin/bash

if [ $# -ne 1 ]
then
    echo "Arguments missing!"
    echo "Usage: initialize-docker.sh MYSQL_ROOT_PASSWORD"
    exit 1
fi

docker create --name gistlabs-wp-data wordpress
docker create --name gistlabs-mysql-data mysql

docker run --name gistlabs-mysql --volumes-from gistlabs-mysql-data -e MYSQL_ROOT_PASSWORD=$1 -d mysql
docker run --name gistlabs-wp -P --link gistlabs-mysql:mysql --volumes-from gistlabs-wp-data -d migratable-wordpress
