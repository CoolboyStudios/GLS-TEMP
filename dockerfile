# Use the official Tomcat base image with OpenJDK 8
FROM tomcat:jdk8-openjdk

# Remove the default webapps that come with Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy application contents to the Tomcat webapps directory
COPY ./glscan /usr/local/tomcat/webapps/glscan
COPY ./glscandb /usr/local/tomcat/webapps/glscandb

# Copy the context XML files to the Tomcat conf directory
COPY ./conf/Catalina/localhost/glscan.xml /usr/local/tomcat/conf/Catalina/localhost/glscan.xml
COPY ./conf/Catalina/localhost/glscandb.xml /usr/local/tomcat/conf/Catalina/localhost/glscandb.xml

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
