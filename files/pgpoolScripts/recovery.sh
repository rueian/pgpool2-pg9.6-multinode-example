#!/bin/bash -ev

PGDATA=$1
SLAVE_HOST=$2
MASTER_HOST=$3

PORT=5432
ARCH=/mnt/server/archivedir

ssh -o StrictHostKeyChecking=no -T postgres@$SLAVE_HOST "
sudo service postgresql stop
cp $PGDATA/pgpool_remote_start /tmp
cp $PGDATA/recovery_1st_stage.sh /tmp

rm -rf $PGDATA
/usr/bin/pg_basebackup -h $MASTER_HOST -U postgres -D $PGDATA -v -P --xlog-method=stream -c fast
rm -f /tmp/postgresql.trigger.5432
rm -rf $ARCH/*
cd $PGDATA
cat > recovery.conf << EOT
standby_mode = 'on'
primary_conninfo = 'host="$MASTER_HOST" port=$PORT user=postgres'
trigger_file = '/tmp/postgresql.trigger.5432'
EOT

mv /tmp/pgpool_remote_start $PGDATA
mv /tmp/recovery_1st_stage.sh $PGDATA

sudo service postgresql start
"
