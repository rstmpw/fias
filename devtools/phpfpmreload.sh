pushd `dirname $0`/../ > /dev/null
APPENV=`cat ./appdata/.env`

sudo docker stop php71fpm.fias.app
sudo docker cp ./env/php/pool."$APPENV".conf php71fpm.fias.app:/usr/local/etc/php-fpm.d/pool.conf
sudo docker start php71fpm.fias.app

popd > /dev/null