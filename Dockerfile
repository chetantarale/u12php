FROM drydock/u12:prod

ADD . /u12php

RUN /u12php/install.sh
