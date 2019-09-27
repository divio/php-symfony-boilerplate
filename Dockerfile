FROM divio/base:0.1-php7.3-stretch
EXPOSE 80

COPY migrate.sh Procfile /app/
COPY divio/*.php divio/*.sh /app/divio/
COPY start.sh /usr/local/bin/start

RUN echo '[www]\nclear_env = no\ncatch_workers_output = yes' > /usr/local/etc/php-fpm.d/zz-divio.conf
RUN echo 'auto_prepend_file="/app/divio/rewrite-env.php"' > /usr/local/etc/php/conf.d/divio-conf.ini
RUN chmod a+x /usr/local/bin/start /app/*.sh

ENV NODE_VERSION=12.9.1 \
    NPM_VERSION=6.10.2
RUN bash -c "source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default && \
    npm install -g npm@$NPM_VERSION && \
    npm cache clear --force"
ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules \
    PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

COPY divio/nginx/vhost.conf /etc/nginx/sites-available/default
COPY divio/php/php-fpm.conf /usr/local/etc/php-fpm.conf

COPY composer.* /app/
RUN cd /app && composer install --no-scripts

WORKDIR /app
COPY . /app

RUN cd /app && composer run-script post-install-cmd && composer auto-scripts

ENTRYPOINT [ "" ]
CMD ["start", "web"]
