#
# # FROM adoptopenjdk:11-jre-hotspot
# # ARG JAR_FILE=*.jar
# # COPY ${JAR_FILE} application.jar
# # ENTRYPOINT ["java", "-jar", "application.jar"]


FROM maven:3.8.4-jdk-11-slim
WORKDIR /opt/app
# Add a temporary volume
VOLUME /tmp

COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ src/
EXPOSE 5000
RUN mvn clean install -Dmaven.test.skip=true
ENTRYPOINT ["java", "-jar", "/opt/app/target/spring-boot-jpa-postgresql.jar"]
