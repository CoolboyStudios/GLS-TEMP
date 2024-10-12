# Use the official MSSQL 2019 image as the base
FROM mcr.microsoft.com/mssql/server:2019-CU27-ubuntu-20.04

# Set environment variables
ENV ACCEPT_EULA=Y \
    SA_PASSWORD=TEST_GLC123@## \
    DEBIAN_FRONTEND=noninteractive

# Install necessary tools and MSSQL full-text search
RUN apt-get update && \
    apt-get install -y curl apt-transport-https gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server-2019.list && \
    apt-get update && \
    apt-get install -y mssql-server-fts && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /*.deb

# Expose SQL Server port
EXPOSE 1433

# Run SQL Server process
CMD ["/opt/mssql/bin/sqlservr"]
