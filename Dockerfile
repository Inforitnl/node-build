FROM node:12.10.0-stretch

RUN mkdir /code
WORKDIR /code

COPY entrypoint.sh /entrypoint.sh
COPY node-build.sh /node-build.sh

# set execute and install browsers
RUN chmod +x /entrypoint.sh && \
    chmod +x /node-build.sh && \
    apt-get update && \
    apt-get install -y chromium firefox-esr

# install sonar-scanner 
RUN SONAR=4.5.0.2216-linux && \
    wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR.zip && \
    unzip ./sonar-scanner-cli-$SONAR.zip && \
    rm ./sonar-scanner-cli-$SONAR.zip && \
    mv ./sonar-scanner-$SONAR /var/opt && \
    PATH="$PATH:/var/opt/sonar-scanner-$SONAR/bin"

CMD [ "bash", "/entrypoint.sh" ] 
  