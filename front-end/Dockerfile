FROM mhart/alpine-node:6.3

ENV NODE_ENV "production"
ENV PORT 8079
EXPOSE 8079
RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app

RUN apk update && apk upgrade && \
    apk --virtual build-deps add go git gcc musl-dev make binutils patch && \
    apk -v add curl && \
    export GOPATH=/go && \
    go get -v github.com/influxdata/telegraf && \
    cd $GOPATH/src/github.com/influxdata/telegraf && \
    if [ $TELEGRAF_VERSION != "master" ]; then git checkout -q --detach "${TELEGRAF_VERSION}" ; fi && \
    make && \
    chmod +x $GOPATH/bin/* && \
    mv $GOPATH/bin/* /bin/ && \
    cd / && rm -rf  $GOPATH

# Prepare app directory
WORKDIR /usr/src/app
COPY . /usr/src/app

# Install telegraf
# The build phase will substitute the env variables INFLUX_HOSTS and INFLUX_DB in telegraf.conf for the Influx database URL(s) and database,
# respectively. In order to allow cluster URLs, you MUST include the quotes in your hosts, like
# ENV INFLUX_HOSTS \"http://influxdb:8086\"
# ENV INFLUX_HOSTS \"http://influxdb1:8086\",\"http://influxdb2:8086\"

ENV INFLUX_HOSTS \"http://52.53.205.1:8086\"
ENV INFLUX_DB telegraf
ENV TELEGRAF_VERSION 1.1.0

ADD https://gist.githubusercontent.com/Wen777/52b99f7e19cd40907c1113dcc56f110d/raw/6d6b2dcc84fb2837f81d81a42ed50892b183c8fb/telegraf.conf telegraf.conf

ADD run.sh /usr/src/app/run.sh

RUN chmod 755 telegraf.conf  && chmod 755 /usr/src/app/run.sh && sed -i -e "s|{{INFLUX_HOSTS}}|$INFLUX_HOSTS|g" -e "s|{{INFLUX_DB}}|$INFLUX_DB|g" telegraf.conf

EXPOSE 8125/udp 8092/udp 8094

RUN npm install

# Start the app
CMD ["/usr/src/app/run.sh"]
