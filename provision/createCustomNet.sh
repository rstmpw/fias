#Define custom docker network
sudo docker network create \
        --driver=bridge \
        --subnet=192.168.191.0/24 \
        --gateway=192.168.191.1 \
        fias-network-bridge0