#! /bin/bash -e
detached_node_id=$1
detached_node_host=$2
detached_node_data_dir=$3
new_master_id=$4
new_master_host=$5

echo "$(date) detached_node_id=$1"

echo "$(date) [INFO] Recoverying slave to follow new master ..."

pcp_recovery_node -w -h localhost -U postgres -v $detached_node_id

exit 0;
