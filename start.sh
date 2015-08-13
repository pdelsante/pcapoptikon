#!/bin/bash
service mysql start
cd /opt/pcapoptikon
git pull origin master
python manage.py migrate
/usr/bin/suricata -c /etc/suricata/suricata.yaml --unix-socket >/dev/null 2>&1 &
/usr/bin/python /opt/pcapoptikon/manage.py runserver 0.0.0.0:8000 >/var/log/pcapoptikon_web.log 2>&1 &
/usr/bin/python /opt/pcapoptikon/manage.py run_daemon >/var/log/pcapoptikon_daemon.log 2>&1 &
echo "Running on: http://"$(hostname -i)":8000"
while true; do sleep 1; done