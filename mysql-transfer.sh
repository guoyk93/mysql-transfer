#!/bin/bash

MYSQL_DUMP_OPTS="${MYSQL_DUMP_OPTS}"
MYSQL_LOAD_OPTS="${MYSQL_LOAD_OPTS}"

set -eu

MYSQL_SRC_HOST="${MYSQL_SRC_HOST}"
MYSQL_SRC_PORT="${MYSQL_SRC_PORT}"
MYSQL_SRC_USER="${MYSQL_SRC_USER}"
MYSQL_SRC_PASS="${MYSQL_SRC_PASS}"
MYSQL_SRC_NAME="${MYSQL_SRC_NAME}"

MYSQL_DST_HOST="${MYSQL_DST_HOST}"
MYSQL_DST_PORT="${MYSQL_DST_PORT}"
MYSQL_DST_USER="${MYSQL_DST_USER}"
MYSQL_DST_PASS="${MYSQL_DST_PASS}"
MYSQL_DST_NAME="${MYSQL_DST_NAME}"

cat <<-EOF | mysql -h "${MYSQL_DST_HOST}" "-u${MYSQL_DST_USER}" "-p${MYSQL_DST_PASS}" -P "${MYSQL_DST_PORT}"
create database if not exists ${MYSQL_DST_NAME} default character set utf8mb4 collate utf8mb4_general_ci;
EOF

mysqldump -h "${MYSQL_SRC_HOST}" "-u${MYSQL_SRC_USER}" "-p${MYSQL_SRC_PASS}" -P "${MYSQL_SRC_PORT}" ${MYSQL_DUMP_OPTS} "${MYSQL_SRC_NAME}" | mysql -h "${MYSQL_DST_HOST}" "-u${MYSQL_DST_USER}" "-p${MYSQL_DST_PASS}" -P "${MYSQL_DST_PORT}" ${MYSQL_LOAD_OPTS} "${MYSQL_DST_NAME}"
