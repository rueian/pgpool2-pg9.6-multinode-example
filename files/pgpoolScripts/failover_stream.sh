#! /bin/bash -e
failed_node_id=$1
old_master_id=$2
new_master_host=$3
trigger_file=$4

echo "$(date) [INFO] failed_node_id=$1"
echo "$(date) [INFO] old_master_id=$2"
echo "$(date) [INFO] new_master_host=$3"
echo "$(date) [INFO] trigger_file=$4"

if [ "$failed_node_id" != "$old_master_id" ]; then
  echo "$(date) [INFO] Slave node is down. Failover not triggred !"; exit 0;
fi

echo "$(date) [INFO] Master node is down. Performing failover..."

ssh -o StrictHostKeyChecking=no -T postgres@$new_master_host "touch $trigger_file"

exit 0;
