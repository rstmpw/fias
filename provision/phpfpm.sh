pushd `dirname $0`/../ > /dev/null
APPENV=`cat ./appdata/.env`

sudo docker run -d \
    --name php71fpm.fias.app \
    --net fias-network-bridge0 \
    -p 9101:9101 \
    -v $(pwd)/app:/vagrant/app:ro \
    -v $(pwd)/appdata:/vagrant/appdata \
    -v $(pwd)/envdata/php:/var/log/php-fpm \
    rstmpw/php71

sudo docker stop php71fpm.fias.app
sudo docker cp ./env/php/pool."$APPENV".conf php71fpm.fias.app:/usr/local/etc/php-fpm.d/pool.conf
sudo docker start php71fpm.fias.app

popd > /dev/null