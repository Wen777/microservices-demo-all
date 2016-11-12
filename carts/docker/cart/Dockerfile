FROM java:openjdk-8-alpine 

# Install telegraf
# The build phase will substitute the env variables INFLUX_HOSTS and INFLUX_DB in telegraf.conf for the Influx database URL(s) and database, 
# respectively. In order to allow cluster URLs, you MUST include the quotes in your hosts, like
# ENV INFLUX_HOSTS \"http://influxdb:8086\"
# ENV INFLUX_HOSTS \"http://influxdb1:8086\",\"http://influxdb2:8086\"

ENV INFLUX_HOSTS \"http://influxdb:8086\"
ENV INFLUX_DB telegraf
ENV TELEGRAF_VERSION 1.1.0
RUN mkdir -p /etc/telegraf
    

ADD https://gist.githubusercontent.com/Wen777/52b99f7e19cd40907c1113dcc56f110d/raw/4d326b7fc80b0e4b4c358b9b0fe6413accfc5401/telegraf.conf  /etc/telegraf.conf

ADD https://s3-us-west-1.amazonaws.com/microservices-resources/telegraf  /usr/bin/telegraf

RUN chmod +x /usr/bin/telegraf* && sed -i -e "s|{{INFLUX_HOSTS}}|$INFLUX_HOSTS|g" -e "s|{{INFLUX_DB}}|$INFLUX_DB|g" /etc/telegraf.conf 

EXPOSE 8125/udp 8092/udp 8094


ENV	SERVICE_USER=myuser \
	SERVICE_UID=10001 \
	SERVICE_GROUP=mygroup \
	SERVICE_GID=10001

RUN	addgroup -S -g ${SERVICE_GID} ${SERVICE_GROUP} && \
	adduser -g "${SERVICE_NAME} user" -D -H -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} && \
	mkdir /lib64 && \
	ln -s /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/server/libjvm.so /lib/libjvm.so && \
	ln -s /usr/lib/jvm/java-1.8-openjdk/lib/amd64/jli/libjli.so /lib/libjli.so 

WORKDIR /usr/src/app
COPY *.jar ./app.jar

RUN	chown -R ${SERVICE_USER}:${SERVICE_GROUP} ./app.jar

USER ${SERVICE_USER}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG COMMIT

LABEL org.label-schema.vendor="Weaveworks" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.version="${BUILD_VERSION}" \
  org.label-schema.name="Socks Shop: Cart" \
  org.label-schema.description="REST API for Cart service" \
  org.label-schema.url="https://github.com/microservices-demo/carts" \
  org.label-schema.vcs-url="github.com:microservices-demo/carts.git" \
  org.label-schema.vcs-ref="${COMMIT}" \
  org.label-schema.schema-version="1.0"


COPY run.sh run.sh


ENTRYPOINT ["./run.sh"]
