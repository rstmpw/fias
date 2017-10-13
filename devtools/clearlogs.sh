pushd `dirname $0`/../ > /dev/null

sudo find ./envdata/ -type f -name '*.log' -delete
./devtools/pgsqlreload.sh
./devtools/phpfpmreload.sh
./devtools/nginxreload.sh

popd > /dev/null