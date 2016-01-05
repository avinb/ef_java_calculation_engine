FROM sath89/oracle-xe-11g

COPY create_database.sh /
COPY db_scripts /db_scripts

RUN /create_database.sh

VOLUME /db_data_files_destination

ENTRYPOINT ["/export_db_data_files.sh"]
CMD [""]