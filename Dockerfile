FROM node:12.20.1-stretch

# install browsers for (unit)-testing during build-phase
RUN apt-get update && \
    apt-get install -y --no-install-recommends 'chromium=73.0.3683.75-1~deb9u1' 'firefox-esr=78.6.1esr-1~deb9u1' && \
    rm -rf /var/lib/apt/lists/*

# install sonar-scanner 
ENV SONAR_VERSION="4.5.0.2216-linux"
COPY sonar-scanner-cli-$SONAR_VERSION.zip /var/opt/
RUN unzip /var/opt/sonar-scanner-cli-$SONAR_VERSION.zip -d /var/opt && \
    rm /var/opt/sonar-scanner-cli-$SONAR_VERSION.zip
ENV PATH="$PATH:/var/opt/sonar-scanner-$SONAR_VERSION/bin"

# copy build scripts into container
RUN mkdir /code
WORKDIR /code
COPY entrypoint.sh /entrypoint.sh
COPY node-build.sh /node-build.sh

# set execute on the scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /node-build.sh 

# start the build
CMD [ "bash", "/entrypoint.sh" ] 
