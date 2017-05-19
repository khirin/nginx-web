#!/bin/sh

	clear
	echo -e "\n\t\t[#] start.sh [#]"

# Test of the nginx configuration
        echo -e "\n\t[i] Configuration check ..."
	/usr/sbin/nginx -t &> /dev/null || exit 1

# Launch php-fpm5
        echo -e "\t[i] Launch php-fpm5"
        /usr/bin/php-fpm5 || exit 1

# Follow access.log & error.log
        echo -e "\t[i] Follow access.log & error.log ..."
        tail -F /var/log/nginx/access.log -F /var/log/nginx/error.log 2>/dev/null &

# Launch nginx
        echo -e "\t[i] Starting nginx ...\n"
	exec /usr/sbin/nginx

