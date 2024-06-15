# Use the official Tomcat base image with OpenJDK 8
FROM tomcat:jdk8-openjdk

# Remove the default webapps that come with Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your application contents to the Tomcat webapps directory
COPY ./myApp /usr/local/tomcat/webapps/ROOT

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
