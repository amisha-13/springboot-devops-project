#--------Build Stage -------
FROM maven:3.9.6-eclipse-temurin-17 AS build

#Set working directory inside the container
WORKDIR /app

#Copy only the pom.xml file first to cache dependencies
COPY pom.xml .

#Download the dependencies (This layer is cached until pom.cml changes)
RUN mvn dependency:go-offline

#Copy the rest of the code
COPY src ./src

#Build the application and skip tests for speed
RUN mvn clean package -DskipTests


#--------Stage 2: Run the application------------
FROM eclipse-temurin:17-jre

#Set the working directory
WORKDIR /app

#Copy only the complied jar file from the build stage - maven always puts artifact(jar) in target folder
#app.jar is the destination. we are renaming the complex app to app.jar
COPY --from=build /app/target/*.jar app.jar

#Expose the port your app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","app.jar"]