pushd `dirname $0`/../ > /dev/null
APPENV=`cat ./appdata/.env`

sudo mkdir /opt/fias/pgdata

sudo docker run -d \
    --name pgsql96.fias.app \
    --net fias-network-bridge0 \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD="vagrant" \
    -e POSTGRES_INITDB_ARGS="--locale=ru_RU.UTF-8 --lc-collate=C --lc-ctype=ru_RU.UTF-8 --lc-messages=en_US.UTF-8 --encoding=UTF-8" \
    -v /opt/fias/pgdata:/var/lib/postgresql/data \
    -v $(pwd)/envdata/pgsql:/var/log/pgsql \
    -v $(pwd)/env/pgsql:/vagrant/env/pgsql:ro \
    rstmpw/pgsql96

sleep 10

sudo docker stop pgsql96.fias.app
sudo docker cp ./env/pgsql/pgsql-override."$APPENV".conf pgsql96.fias.app:/etc/pgsql/conf.d/90-app.conf
sudo docker start pgsql96.fias.app

sleep 10

sudo docker exec pgsql96.fias.app psql -a -U postgres -f /vagrant/env/pgsql/initdb.sql


popd > /dev/null