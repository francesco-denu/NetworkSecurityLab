# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Install networking tools
RUN apt-get update && apt-get install -y iproute2 net-tools iputils-ping tcpdump && rm -rf /var/lib/apt/lists/*

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=polls

COPY setup.sh /root/
RUN chmod +x /root/setup.sh

# Expose the default PostgreSQL port
EXPOSE 5432
