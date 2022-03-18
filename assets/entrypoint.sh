#!/bin/sh
#

. /python-venv/bin/activate

nginx
if [ $? -ne 0 ]; then
    echo "nginx failed to start"
    exit 1
fi

uwsgi --emperor /config/vassals --uid www-data --gid www-data
