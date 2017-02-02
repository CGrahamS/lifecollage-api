FROM node

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app



# copy the app to the container
COPY src /usr/src/app/src
COPY server.js /usr/src/app/server.js

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

EXPOSE 5000
CMD [ "npm", "run", "deploy" ]


# docker build --no-cache=true -t lifecollage-api .
# docker run -it --rm --name lifecollage-api -P lifecollage-api
