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
username=`cat config/username.txt`

number=1
for node in `cat config/zookeeperNodeList.txt`; do
	echo Start Zookeeper via ssh on $node:
	ssh -i $keyfile $username@$node "rm -R /tmp/zookeeper; mkdir /tmp/zookeeper; touch /tmp/zookeeper/myid; echo $number >> /tmp/zookeeper/myid"
	ssh -i $keyfile $username@$node "~/kafka_2.11-2.0.1/bin/zookeeper-server-start.sh ~/kafka_2.11-2.0.1/config/zookeeper.properties &"&
	#http://stackoverflow.com/questions/13638670/adding-counter-in-shell-script
	number=$((number+1))
done

