FROM node:14   ## base image-version
WORKDIR /usr/src/app   ## create work directory
COPY package*.json ./  ## copy all the json and drop it on the work-directory
RUN npm install
RUN npm install express
COPY . .
EXPOSE 3000
CMD [ "node", "index.js" ]