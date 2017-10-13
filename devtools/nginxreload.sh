pushd `dirname $0`/../ > /dev/null
APPENV=`cat ./appdata/.env`

sudo docker stop nginx.fias.app
sudo docker cp ./env/nginx/vhost."$APPENV".conf nginx.fias.app:/etc/nginx/conf.d/vhost.conf
sudo docker start nginx.fias.app

popd > /dev/null