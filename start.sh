#!/bin/bash
[ $# -lt 2 ] && { echo "Usage: $0 <Local Port> <Remote Host>" ; exit 1; }

trap '{ ssh $2 "docker stop tunnel" ; exit 1; }' INT

ssh $2 'docker start tunnel'

ssh -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=300 -o ConnectTimeout=5 -g -R 8080:localhost:$1 -p 22 $2
