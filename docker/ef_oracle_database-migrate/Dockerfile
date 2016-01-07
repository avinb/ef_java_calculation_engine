FROM wnameless/oracle-xe-11g

ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV PATH $ORACLE_HOME/bin:$PATH
ENV ORACLE_SID XE

COPY execute_db_scripts.sh /
COPY db_scripts /db_scripts

CMD ["/execute_db_scripts.sh"]
