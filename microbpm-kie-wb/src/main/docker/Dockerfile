#Dockerfile for jBPM Workbench / KIE Workbench
FROM jboss/wildfly:10.1.0.Final

# Web context / relates to login module and kie execution server configurations
ENV JBPM_CONTEXT jbpm-console
#ENV KIE_WB_VERSION 7.0.0-SNAPSHOT
#ENV KIE_WB_VERSION 7.0.0-20161029.043911-709
ENV KIE_WB_VERSION 7.0.0-20161105.002749-731


# Deployment
COPY install/kie-wb-distribution-wars-$KIE_WB_VERSION-wildfly10.war $JBPM_CONTEXT.war
#RUN curl -o $JBPM_CONTEXT.war https://repository.jboss.org/nexus/service/local/repositories/releases/content/org/kie/kie-wb-distribution-wars/$KIE_VERSION/kie-wb-distribution-wars-$KIE_WB_VERSION-wildfly10.war
#RUN curl -o $JBPM_CONTEXT.war https://repository.jboss.org/nexus/service/local/repositories/snapshots/content/org/kie/kie-wb-distribution-wars/7.0.0-SNAPSHOT/kie-wb-distribution-wars-7.0.0-20161029.043911-709-wildfly10.war
#RUN curl -o $JBPM_CONTEXT.war https://repository.jboss.org/nexus/service/local/repositories/snapshots/content/org/kie/kie-wb-distribution-wars/7.0.0-SNAPSHOT/kie-wb-distribution-wars-7.0.0-20161105.002749-731-wildfly10.war

RUN mv $JBPM_CONTEXT.war $JBOSS_HOME/standalone/deployments && \
touch $JBOSS_HOME/standalone/deployments/$JBPM_CONTEXT.war.dodeploy


# Users and Roles
COPY etc/application-users.properties $JBOSS_HOME/standalone/configuration/application-users.properties
COPY etc/application-roles.properties $JBOSS_HOME/standalone/configuration/application-roles.properties


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
#ENV JBOSS_ARGUMENTS $JBOSS_ARGUMENTS --debug 8787
#ENV JAVA_OPTS "-Xms256m -Xmx1024m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=$JBOSS_MODULES_SYSTEM_PKGS -Djava.awt.headless=true"
CMD ["./start.sh"]