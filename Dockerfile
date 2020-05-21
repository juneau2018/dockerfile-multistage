FROM maven:3.5-jdk-8-alpine AS builder
ADD settings.xml /etc/
ADD pom.xml /tmp/build/
WORKDIR /tmp/build
ADD src /tmp/build/src
RUN mvn -gs /etc/settings.xml -q -DskipTests=true package

FROM tomcat:8.5-jdk8
RUN rm -rf $CATALINA_HOME/webapps/* 
COPY --from=builder /tmp/build/target/*.war $CATALINA_HOME/webapps/ROOT.war
