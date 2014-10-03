
FROM dockerfile/nodejs
MAINTAINER Yue Chen <dspfac@gmail.com>

RUN apt-get update && apt-get install -y supervisor
CMD mkdir /var/log/supervisor
ADD supervisord.conf /etc/supervisor/supervisord.conf

CMD mkdir /home/project/discover
WORKDIR /home/project

RUN git clone https://github.com/Live4Code/discover.git
WORKDIR /home/project/discover
RUN npm install
#ADD ./config.json /home/project/discover/config.json
ADD ./run.sh /home/project/discover/run.sh


#ENTRYPOINT ["/home/project/discover/run.sh"]
CMD ["/usr/bin/supervisord"]

