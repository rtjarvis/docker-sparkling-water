FROM frolvlad/alpine-oraclejdk8

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

