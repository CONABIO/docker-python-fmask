# Ubuntu 14.04 Trusty Tahyr
FROM geodata/gdal:1.11.2

MAINTAINER Amaury Gutierrez <amaury.gtz@gmail.com>
# change user from none to root
USER root
# install python dependencies
RUN apt-get update -y && \
	apt-get install -y \
	curl \
	gcc \
	libffi-dev \
	mercurial \	
	python-dev \
	python-setuptools \
	python-scipy 

RUN cd /usr/local/src/ && curl https://storage.googleapis.com/pub/gsutil.tar.gz -O && tar xfz gsutil.tar.gz -C /usr/local/bin/
ENV PATH "$PATH:/usr/local/bin/gsutil"

# download and install rios
RUN cd /usr/local/src/ && hg clone https://bitbucket.org/chchrsc/rios
RUN cd /usr/local/src/rios/rios/ && python setup.py install
# download and install python fmask
RUN cd /usr/local/src/ && hg clone https://amaurs@bitbucket.org/amaurs/python-fmask
RUN cd /usr/local/src/python-fmask/ && python setup.py install