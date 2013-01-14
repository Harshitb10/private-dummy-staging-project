#!/bin/bash

#-----------------------------------------------------------------------------------
#
# Purpose: creates an entry into the WAC admintool for a JIRA download version
#
# This script checks out the JIRA release tag's pom to read in the build number.
#
# Call this only by bamboo to run on an agent because the user to access WAC
# is only found there.
#
# Bamboo job must pass both the VERSION, e.g. 5.0.1,  and the TAG of the release,
# e.g. tags/atlassian_jira_5_0_1
#
# The tag information will be used both to checkout JIRA source and to put the
# "CVS tag" in the WAC entry via the maven-product-deployment-plugin
#
# The plugin then uses GOAL which signifies eap versus binary which sets the type
# of file for the release.  This is important because eap when made "current" or
# live on WAC will not be the default downloadable JIRA where wac-release will
# make it the default downloadable.
#
# Also, set the M2_HOME and JAVA_HOME variables in the job's environment variables.
#
# Example usage from the bamboo job:
#
# Plan level variables:
#	goal = wac-eap
#	AUTHFILE = /opt/bamboo-agent/jira-release-svn.xml
#	branch.url = tags/atlassian_jira_5_0_alpha5
#	jira.version = 5.0-alpha5
# Job level arguments:
#	${bamboo.jira.version} ${bamboo.branch.url} ${bamboo.goal} ${bamboo.AUTHFILE}
# Job level environment variables:
#	HOME="${system.bamboo.agent.home}" MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=128m -Xms256m" M2_HOME="${bamboo.capability.system.builder.mvn2.Maven 2}" JAVA_HOME="${bamboo.capability.system.jdk.JDK 1.6.0_27}"
#-----------------------------------------------------------------------------------

PATH=$PATH:${M2_HOME}/bin:${JAVA_HOME}/bin
VERSION=$1
PRODUCTTAG=$2
# Goal determines which kind of release, wac-release, wac-eap, or pac
GOAL=$3
AUTHFILE=$4

USER=`cat ${AUTHFILE} |sed -n -e 's/.*<wacadminusername>\(.*\)<\/wacadminusername>.*/\1/p'`
PASSWORD=`cat ${AUTHFILE} |sed -n -e 's/.*<wacadminpassword>\(.*\)<\/wacadminpassword>.*/\1/p'`
#BUILDNUMBER=`cat pom.xml |sed -n -e 's/.*<jira.build.number>\(.*\)<\/jira.build.number>.*/\1/p'`
# Override buildnumber for testing
BUILDNUMBER=9991

echo "===================================="
echo " Prebuild debugging "
echo "===================================="
echo "PWD is $PWD"
echo "Product tag is ${PRODUCTTAG}"
ls -ltr
mvn --version
echo "===================================="
echo "Starting the WAC entry process"
echo "===================================="
mvn clean --non-recursive com.atlassian.maven.plugins:maven-product-deployment-plugin:1.12-jira44-1:${GOAL} \
 -Dproduct.name=JIRA -Dcredentials.aac.username=${USER} \
 -Dcredentials.aac.password=${PASSWORD} \
 -Dproduct.version=${VERSION} \
 -Dproduct.buildNumber=${BUILDNUMBER} \
 -Dproduct.tag=${PRODUCTTAG}
