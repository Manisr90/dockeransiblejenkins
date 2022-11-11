FROM tomcat:latest
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/tomcat.war
RUN chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
