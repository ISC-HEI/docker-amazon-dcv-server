#!/bin/bash
sudo -i

export DEBIAN_FRONTEND=noninteractive

apt-get update
cd /tmp

wget -q https://d1uj6qtbmh3dt5.cloudfront.net/NICE-GPG-KEY
gpg --import NICE-GPG-KEY
rm NICE-GPG-KEY

wget -q https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-ubuntu2404-x86_64.tgz
DIR=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | head -1`
tar xzf nice-dcv-ubuntu2404-x86_64.tgz

apt install -y $PWD/$DIR/nice-dcv-server*
apt install -y $PWD/$DIR/nice-dcv-web-*
apt install -y $PWD/$DIR/nice-xdcv*
apt install -y $PWD/$DIR/nice-dcv-gl_*
apt install -y $PWD/$DIR/nice-dcv-gltest*
apt install -y $PWD/$DIR/nice-xdcv*
rm -rf $DIR nice-dcv-ubuntu2404-x86_64.tgz

systemctl enable dcvserver
systemctl start dcvserver

cat <<EOF > init.sh
#!/bin/sh
/usr/bin/metacity &
/usr/bin/xterm
EOF

dcv create-session test --owner=ubuntu --user=ubuntu --storage-root=/home/ubuntu --gl on --init init.sh
