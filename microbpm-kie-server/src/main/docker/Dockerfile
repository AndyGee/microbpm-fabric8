#Dockerfile for KIE Execution Server to execute Rules, Processes, Adaptive Case Management and Planning

FROM jboss/wildfly:10.1.0.Final

#ENV KIE_VERSION 7.0.0.Beta2
#ENV KIE_VERSION 7.0.0-SNAPSHOT
#ENV KIE_VERSION 7.0.0-20161028.165139-833
ENV KIE_VERSION 7.0.0-20161104.214356-849
ENV KIE_SERVER_CONTEXT kie-server

# Security between jbpm-console and kie server
ENV KIE_SERVER_CONTROLLER_USER kieserver
ENV KIE_SERVER_CONTROLLER_PWD kieserver1!
# local kie server security (callback security)
ENV KIE_SERVER_USER kieserver
ENV KIE_SERVER_PWD kieserver1!


# Deployment
COPY install/kie-server-$KIE_VERSION-ee7.war $KIE_SERVER_CONTEXT.war
# 7.0.0 Beta2 curl -o $JBPM_CONTEXT.war https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/kie/server/kie-server/7.0.0
# SNAPSHOT curl -o $JBPM_CONTEXT.war https://repository.jboss.org/nexus/service/local/repositories/snapshots/content/org/kie/server/kie-server/7.0.0-SNAPSHOT/kie-server-7.0.0-20161028.165139-833-ee7.war
# SNAPSHOT curl -o $JBPM_CONTEXT.war https://repository.jboss.org/nexus/service/local/repositories/snapshots/content/org/kie/server/kie-server/7.0.0-SNAPSHOT/kie-server-7.0.0-20161104.214356-849-ee7.war


RUN mv $KIE_SERVER_CONTEXT.war $JBOSS_HOME/standalone/deployments && \
touch $JBOSS_HOME/standalone/deployments/$KIE_SERVER_CONTEXT.war.dodeploy


# Users and Roles
COPY etc/application-users.properties $JBOSS_HOME/standalone/configuration/application-users.properties
COPY etc/application-roles.properties $JBOSS_HOME/standalone/configuration/application-roles.properties


# Persistence
ENV DB_MYSQL_DRIVER_VERSION 5.1.40
# mysql driver to add it as jboss module via cli
COPY install/mysql-connector-java-$DB_MYSQL_DRIVER_VERSION.jar $JBOSS_HOME/mysql-connector-java.jar
#RUN curl -o $JBOSS_HOME/standalone/deployments/mysql-connector-java-$DB_MYSQL_DRIVER_VERSION.jar http://central.maven.org/maven2/mysql/mysql-connector-java/$MYSQL_DRIVER_VERSION/mysql-connector-java-$MYSQL_DRIVER_VERSION.jar


# Use full profile and configure server via command line interface
RUN mv $JBOSS_HOME/standalone/configuration/standalone.xml $JBOSS_HOME/standalone/configuration/standalone.xml.orig
RUN cp $JBOSS_HOME/standalone/configuration/standalone-full.xml $JBOSS_HOME/standalone/configuration/standalone.xml
COPY etc/commands.cli $JBOSS_HOME/commands.cli
RUN $JBOSS_HOME/bin/jboss-cli.sh --commands=embed-server,run-batch\ --file=$JBOSS_HOME/commands.cli,stop-embedded-server


# Maven settings to retrieve KIE modules from jbpm-console repository
ADD etc/settings.xml $JBOSS_HOME/../.m2/settings.xml


# Change jboss directory owner to jboss
USER root
RUN chown jboss:jboss -R /opt/jboss

# Start server
ADD etc/start.sh $JBOSS_HOME/bin/start.sh
USER jboss
WORKDIR $JBOSS_HOME/bin/
ENV JBOSS_ARGUMENTS $JBOSS_ARGUMENTS --debug 8787
#ENV JAVA_OPTS "-Xms256m -Xmx1024m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS -Djava.awt.headless=true"
CMD ["./start.sh"]
