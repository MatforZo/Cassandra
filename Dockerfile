# Use the official Cassandra image from the Docker Hub
FROM cassandra:3.11

# Copy the initialization script into the Docker container
COPY schema.cql /docker-entrypoint-initdb.d/

# Ensure the init script has the correct permissions
RUN chmod 777 /docker-entrypoint-initdb.d/schema.cql

# Start Cassandra, wait for it to be ready, and then run the CQL script
CMD ["sh", "-c", "cassandra -R && sleep 30 && cqlsh -f /docker-entrypoint-initdb.d/schema.cql && tail -f /dev/null"]

# Expose the default Cassandra port
EXPOSE 9042
