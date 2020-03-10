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

simulationNode=`cat config/simulationNode.txt`
keyfile=`cat config/keyFilePath.txt`

echo "=== Stop EvaluationConsumer with ssh via $simulationNode ==="
ssh -i $keyfile ubuntu@$simulationNode "rm ~/streamteam-evaluation/log/*"
ssh -i $keyfile ubuntu@$simulationNode "rm ~/streamteam-evaluation/latencies/*"
ssh -i $keyfile ubuntu@$simulationNode "rm ~/streamteam-sensor-simulator/log/*"
