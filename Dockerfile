FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/dockeransible.war /app
EXPOSE 9090
CMD ["Java","-jar","dockeransible.war"]





#FROM tomcat:8.5.35-jre10
# Take the war and copy to webapps of tomcat
# COPY target/*.war /usr/local/tomcat/webapps/dockeransible.war
# RUN chmod +x /usr/local/tomcat/bin/catalina.sh
# CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
