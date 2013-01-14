#!/bin/bash

SVNUSER=`cat /opt/bamboo-agent/credentials.xml |sed -n -e 's/.*<username>\(.*\)<\/username>.*/\1/p'`
SVNPASS=`cat /opt/bamboo-agent/credentials.xml |sed -n -e 's/.*<password>\(.*\)<\/password>.*/\1/p'`
DATE=`date +%d-%b-%Y`
#BUILDNUMBER=`cat pom.xml |sed -n -e 's/.*<jira.build.number>\(.*\)<\/jira.build.number>.*/\1/p'`
TAG=$1
VERSION=$2
export ATLASSIAN_SCRIPTS=atlassian-scripts


function updateJiraVersions () {

echo "------------ Updating jiraversions.txt: svn checkout atlassian-scripts"
svn co --force https://svn.atlassian.com/svn/private/atlassian/atlassian-scripts/trunk atlassian-scripts --username=${SVNUSER} --password=${SVNPASS} << EOF
no
EOF

}

updateJiraVersions
