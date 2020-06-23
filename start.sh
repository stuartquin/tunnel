#!/bin/bash
[ $# -lt 2 ] && { echo "Usage: $0 <Local Port> <Remote Host>" ; exit 1; }

ssh -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=300 -o ConnectTimeout=5 -g -R 8080:localhost:$1 -p 2222 tunnel@$2
