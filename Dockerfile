FROM maven:3.6.3-jdk-11 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/my-app-jar-with-dependencies.jar /usr/local/lib/
EXPOSE 50051
ENTRYPOINT ["java", "-cp", "/usr/local/lib/my-app-jar-with-dependencies.jar", "com.mycompany.app.App"]
