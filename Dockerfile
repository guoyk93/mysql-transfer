FROM acicn/mysql:5.7

ADD mysql-transfer.sh /mysql-transfer.sh

ENV MYSQL_DUMP_OPTS "-R -E"

CMD ["/mysql-transfer.sh"]
