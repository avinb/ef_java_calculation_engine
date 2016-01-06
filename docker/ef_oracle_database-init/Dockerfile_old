FROM sath89/oracle-xe-11g

COPY initialize_database.sh /
RUN /initialize_database.sh

COPY execute_db_scripts.sh /
COPY db_scripts /db_scripts
RUN /execute_db_scripts.sh

COPY copy_db_files_into_image.sh /
RUN /copy_db_files_into_image.sh

VOLUME /db_data_files_destination

COPY export_db_files.sh /
ENTRYPOINT ["/export_db_files.sh"]
CMD [""]