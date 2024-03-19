#Base image for flutter
FROM ubuntu:latest

#Update dependency 
RUN apt-get update && \
    apt-get install -y git curl unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget && \
    apt-get clean

# Télécharger et installer Flutter
# RUN git clone https://github.com/flutter/flutter.git -b stable /flutter

ENV PATH=$PATH:/flutter/bin

ENV PATH=$PATH:/flutter/bin/cache/dart-sdk/bin


RUN mkdir /app

COPY . /app

WORKDIR /app


RUN flutter clean
RUN flutter pub get
RUN flutter build web


#use nginx to deploy
FROM nginx:1.25.2-alpine


# copy the info of the builded web app to nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose and run nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

