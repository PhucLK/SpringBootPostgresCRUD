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
