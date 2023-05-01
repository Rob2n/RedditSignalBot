FROM openjdk:21-jdk-slim-buster

WORKDIR /app/

## PART 1: ACTUAL SERVICE

# Copy files into container
COPY ./docker/crontab /etc/cron/crontab
COPY ./docker/entrypoint.sh /app/
COPY ./docker/send_message.sh /app/
COPY ./docker/signal_config /app/signal_config

RUN apt-get install tzdata -y
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN echo "Europe/Berlin" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
# Configure timezone, cronjob and signal
RUN apt-get -qq update\
    && apt-get install -qq wget curl jq cron rsyslog python3 python3-pip \
    && wget -nv https://github.com/AsamK/signal-cli/releases/download/v0.11.9.1/signal-cli-0.11.9.1-Linux.tar.gz \
    && tar -xzvf signal-cli-0.11.9.1-Linux.tar.gz \
    && rm signal-cli-0.11.9.1-Linux.tar.gz \
    && crontab /etc/cron/crontab \
    && chmod +x /app/*.sh

## PART 2: FLASK APP TO KEEP PORT USED AND VALIDATE HEALTHCHECK
# copy the requirements file into the image
COPY ./flask_files/requirements.txt /app/requirements.txt

# install the dependencies and packages in the requirements file
RUN pip3 install -r requirements.txt

# copy every content from the local file to the image
COPY ./flask_files /app

# configure the container to run in an executed manner
ENTRYPOINT [ "/app/entrypoint.sh" ]