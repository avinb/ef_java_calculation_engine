FROM tomcat

COPY context.xml ${CATALINA_HOME}/conf/
COPY tomcat-users.xml ${CATALINA_HOME}/conf/

COPY ef_java_calculation_engine ${CATALINA_HOME}/webapps/
COPY ojdbc6.jar ${CATALINA_HOME}/lib/

COPY start.sh /

CMD ["/start.sh"]
