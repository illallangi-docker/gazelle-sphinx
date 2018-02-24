#!/bin/sh

set -e

echo Waiting 60 seconds for ${MYSQL_HOST}:${MYSQL_PORT} to become available

wait-for ${MYSQL_HOST}:${MYSQL_PORT} -t 60

if [ "$(ls -A ${SPHINX_LIB})" ]; then
     echo "${SPHINX_LIB} contains files, not creating indexes"
else
    echo "${SPHINX_LIB} is empty, creating indexes"
    indexer -c /usr/local/etc/sphinx.conf --all
fi

exec "$@"