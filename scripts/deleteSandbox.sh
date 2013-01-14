#!/bin/bash

function deleteJiraSandboxes {

	KEY=JIRAHEAD-INSTALLCI
	for NUM in {54..63};
	do
		echo $NUM;
		mvn -s ~/.m2/settings.xml.noencrypt sandbox:delete -Dsandbox.key=${KEY}-${NUM}
	done

}

function deleteBambooSandboxes {

	#bamboo-3.0-i1-b221/
	KEY=bamboo-3.0-i1
	for NUM in {221..232};
	do
        	echo $NUM;
        	mvn -s ~/.m2/settings.xml.noencrypt sandbox:delete -Dsandbox.key=${KEY}-${NUM}
	done


}



deleteBambooSandboxes
