# Use the official OpenJDK 17 image as the base image
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file to the working directory
COPY build/libs/*.jar ./
COPY config/application.properties ./

# Expose the default Spring Boot application port
EXPOSE 8080

# Set the entrypoint for the final image
ENTRYPOINT ["java", "-jar", "neirostorm-0.0.1-SNAPSHOT.jar", "--spring.config.location=application.properties"]