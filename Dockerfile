
FROM jenkins/jenkins:2.73.2

# install docker, docker-compose, docker-machine
# see: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
# see: https://docs.docker.com/engine/installation/linux/linux-postinstall/
# see: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

USER root

# prerequisites for docker
RUN apt-get update \
    && apt-get -y install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

# docker repos
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" >> /etc/apt/sources.list.d/additional-repositories.list \
    && echo "deb http://ftp-stud.hs-esslingen.de/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 437D05B5 \
    && apt-get update

# docker
RUN apt-get -y install docker-ce

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# give jenkins docker rights
RUN usermod -aG docker jenkins

USER jenkins


#
#
# # FROM adoptopenjdk:11-jre-hotspot
# # ARG JAR_FILE=*.jar
# # COPY ${JAR_FILE} application.jar
# # ENTRYPOINT ["java", "-jar", "application.jar"]
#
#
#
# # # Install maven and copy project for compilation
# FROM maven:latest as builder


# FROM jenkins:1.596
#
# USER root
# RUN apt-get update \
#       && apt-get install -y sudo \
#       && rm -rf /var/lib/apt/lists/*
# RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
#
# USER jenkins
# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

FROM maven:3.8.4-jdk-11-slim
WORKDIR /opt/app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ src/
RUN mvn clean install -Dmaven.test.skip=true
ENTRYPOINT ["java", "-jar", "/opt/app/target/spring-boot-jpa-postgresql-0.0.1-SNAPSHOT.jar"]
