pushd `dirname $0`/../ > /dev/null
APPENV=`cat ./appdata/.env`

sudo docker stop pgsql96.fias.app
sudo docker cp ./env/pgsql/pgsql-override."$APPENV".conf pgsql96.fias.app:/etc/pgsql/conf.d/90-app.conf
sudo docker start pgsql96.fias.app

popd > /dev/null