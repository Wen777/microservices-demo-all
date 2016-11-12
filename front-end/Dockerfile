FROM mhart/alpine-node:6.3

# Install telegraf
# The build phase will substitute the env variables INFLUX_HOSTS and INFLUX_DB in telegraf.conf for the Influx database URL(s) and database,
# respectively. In order to allow cluster URLs, you MUST include the quotes in your hosts, like
# ENV INFLUX_HOSTS \"http://influxdb:8086\"
# ENV INFLUX_HOSTS \"http://influxdb1:8086\",\"http://influxdb2:8086\"

ENV INFLUX_HOSTS \"http://52.53.205.1:8086\"
ENV INFLUX_DB telegraf
ENV TELEGRAF_VERSION 1.1.0

ADD https://gist.githubusercontent.com/Wen777/52b99f7e19cd40907c1113dcc56f110d/raw/4d326b7fc80b0e4b4c358b9b0fe6413accfc5401/telegraf.conf  telegraf.conf

ADD https://s3-us-west-1.amazonaws.com/microservices-resources/telegraf  telegraf

RUN chmod +x telegraf && sed -i -e "s|{{INFLUX_HOSTS}}|$INFLUX_HOSTS|g" -e "s|{{INFLUX_DB}}|$INFLUX_DB|g" ./telegraf.conf

EXPOSE 8125/udp 8092/udp 8094

# COPY run.sh run.sh

ENV NODE_ENV "production"
ENV PORT 8079
EXPOSE 8079
RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app
USER myuser

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app



# Start the app
CMD ./telegraf --config ./telegraf.conf > telegraf.log && wget https://hchk.io/073d8f40-640d-463c-a23c-547a5088ef3a -O /dev/null  && npm start
