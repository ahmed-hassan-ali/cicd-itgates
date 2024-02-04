FROM node

# Declaring env
ENV NODE_ENV development

# Setting up the work directory
WORKDIR /react-app

#RUN npm install -g npm@9.5.0
# Installing dependencies
COPY ./package.json /react-app
RUN npm install

# Copying all the files in our project
COPY . .

# Starting our application
CMD ["npm" ,"start"]

#c9b53201def6