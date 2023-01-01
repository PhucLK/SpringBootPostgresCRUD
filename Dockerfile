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
FROM maven:3.8.4-jdk-11-slim
WORKDIR /opt/app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ src/
RUN mvn clean install -Dmaven.test.skip=true
ENTRYPOINT ["java", "-jar", "/opt/app/target/spring-boot-jpa-postgresql-0.0.1-SNAPSHOT.jar"]
