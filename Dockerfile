FROM tomcat:8.5.35-jre10
COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war
EXPOSE 8080
RUN chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

