#!/usr/bin/env bash

# Default arguments
JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -b 0.0.0.0 "

# Start Wildfly with the given arguments.
echo "Using jboss arguments: '$JBOSS_ARGUMENTS'"
echo "Running JBoss Wildfly..."
exec ./standalone.sh $JBOSS_ARGUMENTS
exit $?
