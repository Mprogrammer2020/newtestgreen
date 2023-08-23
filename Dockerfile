# Use a Maven image as the build environment
FROM openjdk:8-jre-slim

LABEL maintainer="muk214782@gmail.com"

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install -DskipTests

# Create a smaller runtime image
FROM adoptopenjdk/openjdk8:jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the build image
COPY --from=build /app/target/greenelegentfarmer-0.0.1-SNAPSHOT.jar .

ENTRYPOINT ["java", "-jar", "greenelegentfarmer-0.0.1-SNAPSHOT.jar"]
