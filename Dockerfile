FROM python:2.7

RUN apt-get update
RUN apt-get install -y python2.7-dev
RUN pip install cython ipy requests

RUN mkdir /opt/swiper
WORKDIR /opt/swiper

ADD . /opt/swiper

RUN cd /opt/swiper/include/streamhtmlparser &&\
	./configure --prefix=/usr &&\
	make &&\
	make install

RUN cd /opt/swiper/include/streamhtmlparser/src/py-streamhtmlparser &&\
	make install

CMD ["/opt/swiper/Proxy.py", "-c", "/opt/swiper/proxy.conf"]
