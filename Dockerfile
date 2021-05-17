FROM debian
RUN export node_version="0.10" \
&& apt-get update && apt-get -y install nodejs="$node_version"
COPY package.json usr/src/app
RUN cd /usr/src/app \
&& npm install node-static

EXPOSE 80000
CMD npm start


FROM debian:9
RUN export node_version="0.10" \
&& apt-get update && apt-get -y --no-install-recommends install nodejs="$node_version" \
&& rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY package.json .
RUN npm install node-static@0.7.11

EXPOSE 60000
CMD ["npm", "start"]


