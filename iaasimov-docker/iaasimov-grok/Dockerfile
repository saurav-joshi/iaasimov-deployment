FROM openjdk:latest
WORKDIR /opt/iaasimov
WORKDIR ../target
COPY target/iaasimov-0.5.1-SNAPSHOT.jar /opt/iaasimov

EXPOSE "8081:7070"

CMD java -Xms4G -Xmx4G -jar /opt/iaasimov/iaasimov-0.5.1-SNAPSHOT.jar

