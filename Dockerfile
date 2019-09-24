FROM node:12.10.0-stretch

RUN mkdir /code
WORKDIR /code

COPY entrypoint.sh /entrypoint.sh
COPY node-build.sh /node-build.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /node-build.sh
CMD [ "bash", "/entrypoint.sh" ]
