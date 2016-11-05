#!/usr/bin/env bash
# Inspired from https://github.com/jboss-dockerfiles/drools/blob/master/kie-server/showcase/etc/start_kie-server.sh

# If empty create KIE server id / template name
if [ ! -n "$KIE_SERVER_ID" ]; then
    export KIE_SERVER_ID=kie-server-$HOSTNAME
fi
echo "Using '$KIE_SERVER_ID' as KIE server identifier"

# If empty set callback server location url via pod ip
if [ ! -n "$KIE_SERVER_LOCATION" ]; then
    export KIE_SERVER_LOCATION=http://$MY_POD_IP:$KIE_SERVER_PORT/kie-server/services/rest/server
fi
echo "Using '$KIE_SERVER_LOCATION' as KIE server location"

# Default arguments and KIE server arguments by env entries
JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -b 0.0.0.0 -Dorg.kie.server.id='$KIE_SERVER_ID' -Dorg.kie.server.user='$KIE_SERVER_USER' -Dorg.kie.server.pwd='$KIE_SERVER_PWD' -Dorg.kie.server.location='$KIE_SERVER_LOCATION' "

# Set KIE controller arguments by kie env entries
if [ -n "$KIE_SERVER_CONTROLLER" ]; then
    echo "Using '$KIE_SERVER_CONTROLLER' as KIE server controller"
    echo "Using '$KIE_MAVEN_REPO' for the kie-workbench Maven repository URL"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.kie.server.controller='$KIE_SERVER_CONTROLLER' -Dorg.kie.server.controller.user='$KIE_SERVER_CONTROLLER_USER' -Dorg.kie.server.controller.pwd='$KIE_SERVER_CONTROLLER_PWD' "
fi


# Set KIE maven repo path if present
if [ "$KIE_SERVER_REPO" ]; then
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.kie.server.repo='$KIE_SERVER_REPO'"
    echo "Using '$KIE_SERVER_REPO' as KIE server maven repo location"
fi


# Start Wildfly with the given arguments.
echo "Using jboss arguments: '$JBOSS_ARGUMENTS'"
echo "Running JBoss Wildfly..."
exec ./standalone.sh $JBOSS_ARGUMENTS
exit $?