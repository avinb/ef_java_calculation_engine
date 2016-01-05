FROM tomcat

COPY context.xml ${CATALINA_HOME}/conf/
COPY tomcat-users.xml ${CATALINA_HOME}/conf/
COPY ojdbc6.jar ${CATALINA_HOME}/lib/

COPY to_be_deployed ${CATALINA_HOME}/webapps/ef_java_calculation_engine/

COPY start.sh /

CMD ["/start.sh"]
