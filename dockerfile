# Use the official Tomcat base image with OpenJDK 8
FROM tomcat:jdk8-openjdk

# Remove the default webapps that come with Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your application contents to the Tomcat webapps directory
COPY ./ /usr/local/tomcat/webapps/ROOT

# Expose the default Tomcat port
EXPOSE 8181

# Start Tomcat
CMD ["catalina.sh", "run"]
