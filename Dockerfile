FROM node:8.11.3

LABEL maintainer="Oleksandr Pikovets <ospikovets@gmail.com>"

# Install Karma
RUN npm install -g karma \
                   karma-cli \
                   karma-firefox-launcher \
                   karma-chrome-launcher

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && apt-get install -y google-chrome-stable

# Install Firefox
RUN cd /etc && \
    wget -O firefox.tar.bz2 'https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US' && \
    tar jxf firefox.tar.bz2 && rm firefox.tar.bz2 && \
    apt-get update && apt-get install libdbus-glib-1-2 && \
    ln -s /etc/firefox/firefox /usr/bin

VOLUME ["/opt/app"]
WORKDIR /opt/app

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT [ "" ]
CMD [ "/entrypoint.sh" ]
