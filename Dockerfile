FROM openliberty/open-liberty:latest

# Config
COPY --chown=1001:0 src/main/liberty/config/server.xml /config/server.xml
COPY --chown=1001:0 src/main/liberty/config/server.env /config/server.env
COPY --chown=1001:0 src/main/liberty/config/jvm.options /config/jvm.options
COPY --chown=1001:0 src/main/liberty/config/bootstrap.properties /config/bootstrap.properties

# key.p12 - all auth services need the same key.
COPY --chown=1001:0 src/main/liberty/config/resources/security/key.p12 /output/resources/security/key.p12

# App
COPY --chown=1001:0 src/main/liberty/config /config/
COPY --chown=1001:0 target/acmeair-authservice-java-4.0.war /config/apps/

# Logging vars
ENV LOGGING_FORMAT=json
ENV ACCESS_LOGGING_ENABLED=false
ENV TRACE_SPEC=*=info

RUN configure.sh

