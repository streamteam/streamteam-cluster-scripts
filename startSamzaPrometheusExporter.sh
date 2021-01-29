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

master=`cat config/masterNode.txt`
keyfile=`cat config/keyFilePath.txt`
username=`cat config/username.txt`

#https://unix.stackexchange.com/questions/550986/search-and-replace-newline-comma-with-comma-newline/550997#550997
brokerListWithKommaAtTheEnd=`cat config/masterNode.txt config/slaveNodeList.txt | sed -z 's/\n/:9092,/g'`
#https://unix.stackexchange.com/questions/144298/delete-the-last-character-of-a-string-using-string-manipulation-in-shell-script/144330#144330
brokerList=`echo "${brokerListWithKommaAtTheEnd: : -1}"`

echo "=== Start SamzaPrometheusExporter with ssh on $master ==="
ssh -i $keyfile $username@$master samza-prometheus-exporter --port 8080 --topic metrics --brokers $brokerList
