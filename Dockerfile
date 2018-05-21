FROM ubuntu:rolling

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/ConsenSys/mythril/

WORKDIR /mythril

RUN apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:ethereum/ethereum \
  && apt-get update \
  && apt-get install -y solc \
  && apt-get install -y libssl-dev \
  && apt-get install -y python3-pip=9.0.1-2 python3-dev \
  && ln -s /usr/bin/python3 /usr/local/bin/python \
  # && pip3 install --upgrade pip \
  && apt-get install -y pandoc \
  && apt-get install -y git \
  && pip3 install -r requirements.txt \
  && python setup.py install

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs

COPY markdown-fix.js /app/markdown-fix.js

# copy start script
COPY run.sh /app/run.sh

# execute start script
CMD ["sh", "/app/run.sh"]
