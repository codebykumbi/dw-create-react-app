FROM node:9.3.0

# Create app directory in tmp folder (for reuse)
RUN mkdir -p /tmp/src

# Install create-react-app
RUN npm install -g create-react-app

# Create myapp and install app dependencies
RUN create-react-app /tmp/src/myapp
RUN cd /tmp/src/myapp; tar -cvf node_modules.tar node_modules; rm -rf node_modules;

COPY entrypoint.sh /tmp/src/entrypoint.sh
RUN chmod 755 /tmp/src/entrypoint.sh

WORKDIR  /usr/src/myapp
ENTRYPOINT ["/tmp/src/entrypoint.sh"]

EXPOSE 3000
