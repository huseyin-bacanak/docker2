FROM rave/developer:2.1

EXPOSE 8080:8080
EXPOSE 5005:5005

ENV CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=n"
ENV WORKSPACE=/development/workspace/

ADD . $WORKSPACE/app
#ADD build/libs/hello-world.war /development/workspace/app

WORKDIR /development/workspace/app

RUN gradle build
#RUN cp hello-world.war $CATALINA_HOME/webapps
RUN cp build/libs/hello-world.war $CATALINA_HOME/webapps
RUN sh $CATALINA_HOME/bin/startup.sh

WORKDIR /development/workspace/app
CMD ["/development/tool/tomcat/bin/catalina.sh", "run"]