FROM openjdk:latest
WORKDIR /opt/iaasimov
#COPY ../target/iaasimov-0.5.1-SNAPSHOT.jar /opt/iaasimov
COPY /iaasimov/GROK/target/iaasimov-0.5.1-SNAPSHOT.jar /opt/iaasimov

EXPOSE "8080:7070"

CMD java -Xms4G -Xmx4G -jar /opt/iaasimov/iaasimov-0.5.1-SNAPSHOT.jar

EXPOSE "8080:7070"

CMD java -Xms4G -Xmx4G -jar /opt/iaasimov/iaasimov-0.5.1-SNAPSHOT.jar
