# Ubuntu 14.04 Trusty Tahyr
FROM geodata/gdal:1.11.2

MAINTAINER Amaury Gutierrez <amaury.gtz@gmail.com>
# change user from none to root
USER root
# install python dependencies
RUN apt-get update -y && \
	apt-get install -y \
	mercurial \
	python-scipy 
# download and install rios
RUN cd /usr/local/src/ && hg clone https://bitbucket.org/chchrsc/rios
RUN cd /usr/local/src/rios/rios/ && python setup.py install
# download and install python fmask
RUN cd /usr/local/src/ && hg clone https://amaurs@bitbucket.org/amaurs/python-fmask
RUN cd /usr/local/src/python-fmask/ && python setup.py install