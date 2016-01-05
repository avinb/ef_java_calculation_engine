FROM tomcat

COPY context.xml /usr/local/tomcat/conf
COPY tomcat_users.xml /usr/local/tomcat/conf

COPY ef_java_calculation_engine /usr/local/tomcat//webapps
COPY ojdbc6.jar /usr/local/tomcat/lib

COPY start.sh /

CMD ["/start.sh"]
