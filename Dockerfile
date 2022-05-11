FROM ubuntu:18.04
MAINTAINER hmorzaria@hotmail.com

# Install minimum requirements
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  autoconf \
  automake \
  curl \
  flip \
  build-essential \
  subversion \
  libnetcdf-dev \
  proj-bin \
  proj-data \
  libxml2-dev \
  libproj-dev \
  valgrind \
  dos2unix \
  gawk
   
#copy data from host
COPY /atlantis /app/atlantis

RUN gcc -v
RUN cd /app/atlantis/trunk/atlantis aclocal && autoheader && autoconf && automake -a && ./configure && make && make install


#set date and timezone
ENV TZ America/Los_Angeles
RUN ln -snf /usr/share/timezone/$TZ /etc/localtime && echo $TZ > /etc/timezone

