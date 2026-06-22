FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/my-app-*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
