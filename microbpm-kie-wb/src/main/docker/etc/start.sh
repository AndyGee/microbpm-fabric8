#!/usr/bin/env bash

# Default arguments
JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -b 0.0.0.0 "

# Expose git with hostname use full qualified dns name www.example.com (default: localhost), git protocol is only readonly
# GIT client required legacy support fort HostKeyAlgorithms +ssh-dss http://www.openssh.com/legacy.html
JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.uberfire.nio.git.daemon.host=$HOSTNAME -Dorg.uberfire.nio.git.ssh.host=$HOSTNAME"


# Set kie workbench niogit / repository path
if [ -n "$KIE_WB_DATA" ]; then
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.uberfire.nio.git.dir='$KIE_WB_DATA'"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.uberfire.metadata.index.dir='$KIE_WB_DATA'"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.guvnor.m2repo.dir='$KIE_WB_DATA/repositories/kie'"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.kie.server.repo='$KIE_WB_DATA'"

    echo "Using '$KIE_WB_DATA' as kie workbench niogit / lucene index and m2 repository path"
fi



# Start Wildfly with the given arguments.
echo "Using jboss arguments: '$JBOSS_ARGUMENTS'"
echo "Running JBoss Wildfly..."
exec ./standalone.sh $JBOSS_ARGUMENTS
exit $?
