FROM jboss/wildfly:10.1.0.Final

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