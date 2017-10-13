pushd `dirname $0` > /dev/null

./createCustomNet.sh
./pgsql.sh
./phpfpm.sh
./nginx.sh

popd > /dev/null