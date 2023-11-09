# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:16 as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

RUN export NODE_OPTIONS=--openssl-legacy-provider
# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN node_modules/.bin/ng build --output-path=dist


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:latest
WORKDIR /usr/local/app

# Copy the build output to replace the default nginx contents
COPY --from=build  /usr/local/app /usr/local/app
COPY --from=build /usr/local/app/dist /usr/share/nginx/html

EXPOSE 80
