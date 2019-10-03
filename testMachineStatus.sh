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

#http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

keyfile=`cat config/keyFilePath.txt`

function testMachine () {
	if time=$(ssh -i $keyfile -o ConnectTimeout=2 ubuntu@$1 "uptime -s" 2>/dev/null); 
		then echo "\033[0;32mRunning since "$time"\033[0m";
		else echo "\033[0;31mNot running\033[0m";
	fi
	# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
}

for node in `cat config/allNodesList.txt`; do
	ip=$(echo $node | awk -F';' '{print $1}')
	name=$(echo $node | awk -F';' '{print $2}')
	runStatus=$(testMachine $ip)
	echo -e $name" ("$ip"): "$runStatus
done
