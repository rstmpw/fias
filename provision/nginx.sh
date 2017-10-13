pushd `dirname $0`/../ > /dev/null
APPENV=`cat ./appdata/.env`

sudo docker run -d \
    --name nginx.fias.app \
    --net fias-network-bridge0 \
    -p 80:80 \
    -p 443:443 \
    -v $(pwd)/app/assets:/vagrant/app/assets:ro \
    -v $(pwd)/appdata:/vagrant/appdata \
    -v $(pwd)/envdata/nginx:/var/log/nginx \
    rstmpw/nginx

sudo docker stop nginx.fias.app
sudo docker cp ./env/nginx/vhost."$APPENV".conf nginx.fias.app:/etc/nginx/conf.d/vhost.conf
sudo docker start nginx.fias.app

popd > /dev/null