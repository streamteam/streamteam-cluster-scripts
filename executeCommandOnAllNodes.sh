#!/bin/bash

#
# StreamTeam
# Copyright (C) 2019  University of Basel
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

#http://stackoverflow.com/questions/18568706/check-number-of-arguments-passed-to-a-bash-script
if [ "$#" -lt 1 ]; then
	echo Wrong parameters. Expects: command [timeout]
	exit 1
fi
command=$1

echo Command: $command

if [ "$#" -eq 2 ]; then
	timeout=$2
	echo Timeout: $2;
else
	echo Timeout: Default;
fi


#http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

keyfile=`cat config/keyFilePath.txt`

for node in `cat config/allNodesList.txt`; do
	ip=$(echo $node | awk -F';' '{print $1}')
	name=$(echo $node | awk -F';' '{print $2}')
	echo "Execute command via ssh on "$name" ("$ip"):"
	if [ "$#" -eq 2 ]; then
		ssh -i $keyfile -o ConnectTimeout=$timeout ubuntu@$ip $command;
	else
		ssh -i $keyfile ubuntu@$ip $command;
	fi
	
done
