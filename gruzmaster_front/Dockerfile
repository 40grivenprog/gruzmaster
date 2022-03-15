# base image
FROM node:12.2.0-alpine

# set working directory
WORKDIR /gruzmaster_front

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /gruzmaster_front/
RUN npm install
RUN npm install --save vuex@next
RUN npm install vue-router@next --save
EXPOSE 8080
# start app
CMD ["npm", "run", "serve"]
