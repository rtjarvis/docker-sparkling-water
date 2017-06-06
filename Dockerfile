FROM ubuntu:15.10

# Repo
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# Java 8 installation from Oracle
RUN apt install  --no-install-recommends software-properties-common -y && apt-add-repository ppa:webupd8team/java

# Upgrade package index
RUN apt-get update
# RUN apt-get -y upgrade

# automatically accept oracle license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 8 oracle jdk
RUN apt-get -y install oracle-java8-installer --no-install-recommends && apt-get clean
RUN apt-get -y install oracle-java8-set-default --no-install-recommends

# Install additional tools
RUN apt-get -y install --no-install-recommends \
  less \
  curl \
  vim-tiny \
  sudo \
  openssh-server \
  unzip

# Install Spark 2.1.0
RUN curl -s https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz | tar -xz -C /opt && \
    ln -s /opt/spark* /opt/spark && \
    mkdir /opt/spark/work && \
    chmod 0777 /opt/spark/work

# Install Sparkling water latest version
RUN curl -s http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.1/8/sparkling-water-2.1.8.zip --output sw.zip && \
  unzip sw.zip -d /opt/ && \
  ln -s /opt/sparkling-water-* /opt/sparkling-water && \
  rm -f sw.zip

# Setup environment
ENV SPARK_HOME /opt/spark
ENV SPARKLING_WATER_HOME /opt/sparkling-water

WORKDIR ${SPARKLING_WATER_HOME}

