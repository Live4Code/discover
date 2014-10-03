#!/bin/bash
cd /home/project/discover

#!/bin/bash
ETCD_HOST=${ETCD_HOST:-"etcd.live4code.com"}
ETCD_PORT=${ETCD_PORT:-4001}
CELL_NAME=${CELL_NAME:-"zone1"}

HOST_IP=$(echo $HOST_IP | sed 's|\[||g')
HOST_IP=$(echo $HOST_IP | sed 's|\]||g')
HOST_IP=$(echo $HOST_IP | sed -r "s|(')||g")

export HOST_IP=$HOST_IP

cat << EOF > config.json
{
  "host": {
    "realm": "$CELL_NAME"
  },
  "discover": {
    "serviceVariable": "DISCOVER"
  },
  "docker": {
    "socketPath": "/tmp/docker.sock",
    "version": "v1.8"
  },
  "etcd": {
    "prefix": "discover/",
    "host": "$ETCD_HOST",
    "port": $ETCD_PORT
  },
  "debug": "/home/discover/discover.log"

}

EOF

/usr/local/bin/node index.js --config config.json
~   
