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

command="rm -R ~/hadoop-2.7.7/logs/"

master=`cat config/masterNode.txt`
keyfile=`cat config/keyFilePath.txt`
username=`cat config/username.txt`
echo Execute command via ssh on $master:
ssh -i $keyfile $username@$master $command

for slaveNode in `cat config/slaveNodeList.txt`; do
	echo Execute command via ssh on $slaveNode:
	ssh -i $keyfile $username@$slaveNode $command
done
