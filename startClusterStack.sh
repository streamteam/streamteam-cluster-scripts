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

./cleanAllHadoopLogs.sh

./startZookeeper.sh &
echo Sleep 20s
sleep 20

./startYarn.sh
echo Sleep 10s
sleep 10

./startHDFS.sh
echo Sleep 10s
sleep 10

./startKafka.sh &
echo Sleep 20s
sleep 20

./startKafkaRestProxy.sh &
echo Sleep 10s
sleep 10

./startPrometheus.sh &
echo Sleep 3s
sleep 3

./startSamzaPrometheusExporter.sh &
echo Sleep 3s
sleep 3

./startGrafana.sh &
echo Sleep 3s
sleep 3

./startMongoDB.sh
echo Sleep 10s
sleep 10

./clearDatabase.sh &
echo Sleep 10s
sleep 10

./startStreamImporter.sh &
echo Sleep 10s
sleep 10

./startMongoDBRESTProxy.sh &
echo Sleep 10s
sleep 10

echo Finished
