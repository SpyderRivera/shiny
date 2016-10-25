FROM r-base:3.2.5

MAINTAINER Nick Nieslanik "nnieslanik@mystrength.com"


ENV JAVA_VERSION 8u66
ENV JAVA_DEBIAN_VERSION 8u66-b17-1~bpo8+1
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    curl \
    openssl \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev \
    openjdk-8-jdk

# see https://bugs.debian.org/793210
# and https://github.com/docker-library/java/issues/46#issuecomment-119026586
RUN apt-get update && apt-get install -y --no-install-recommends libfontconfig1 && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/


COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY install-packages.R /usr/bin/install-packages.R
# Download and install shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    echo $VERSION && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb;

RUN apt-get update && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb;

RUN R -f /usr/bin/install-packages.R
RUN apt-get install -y r-cran-rjava

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
