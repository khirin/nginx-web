#!/bin/sh
        echo -e "\n\t\t[#] init.sh [#]"

if [ ! -f "/var/init_nginxweb_ok" ]; then

# Directories
        echo -e "\n\t[i] Create directories"
        mkdir -p mkdir -p /run/nginx /var/log/phpfpm /var/run/phpfpm

# Permissions
        echo -e "\t[i] Set permissions"
		chown -R nginx:nginx /run/nginx /var/log/nginx /etc/nginx /var/log/phpfpm /var/run/phpfpm
		chmod -R 750 /run/nginx /var/log/nginx /etc/nginx /var/log/phpfpm /var/run/phpfpm
		
# Customize nginx.conf
        echo -e "\t[i] Customize nginx.conf"
	sed -i "/.*Includes virtual hosts configs.*/a\\\tinclude \/conf\/\*\.conf;" /etc/nginx/nginx.conf
        sed -i "s/worker_processes auto;/worker_processes 4;/" /etc/nginx/nginx.conf
	sed -i "/worker_processes 4.*/a\daemon off;" /etc/nginx/nginx.conf
        sed -i "s/^user.*/\#&/" /etc/nginx/nginx.conf

# Customize php-fpm.conf
        echo -e "\t[i] Customize php-fpm.conf"
        sed -i "s/^include.*=.*\/etc\/php5\/fpm\.d\/\*\.conf/;&/" /etc/php5/php-fpm.conf
        sed -i "s/^;listen\.owner.*=.*nobody/listen\.owner = nginx/" /etc/php5/php-fpm.conf
        sed -i "s/^;listen\.group.*=.*nobody/listen\.group = nginx/" /etc/php5/php-fpm.conf
        sed -i "s/^;listen\.mode.*=.*0660/listen\.mode = 0660/" /etc/php5/php-fpm.conf
        sed -i "s/^user.*=.*nobody/;&/" /etc/php5/php-fpm.conf
        sed -i "s/^group.*=.*nobody/;&/" /etc/php5/php-fpm.conf
        sed -i "s/^;log_level.*=.*notice/log_level = notice/" /etc/php5/php-fpm.conf
        sed -i "s/^listen = 127.*/listen = \/var\/run\/phpfpm\/php5-fpm\.sock/" /etc/php5/php-fpm.conf
        sed -i "s/^error_log.*/error_log = \/var\/log\/phpfpm\/php-fpm\.log/" /etc/php5/php-fpm.conf

# Customize php.ini
        echo -e "\t[i] Customize php.ini"
        sed -i "s/display_errors.*=.*Off/display_errors = On/i" /etc/php5/php.ini
        sed -i "s/display_startup_errors.*=.*Off/display_startup_errors = On/i" /etc/php5/php.ini
        sed -i "s/error_reporting.*=.*E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR/i" /etc/php5/php.ini
        sed -i "s/;*memory_limit =.*/memory_limit = 256M/i" /etc/php5/php.ini
        sed -i "s/;*upload_max_filesize =.*/upload_max_filesize = 50M/i" /etc/php5/php.ini
        sed -i "s/;*max_file_uploads =.*/max_file_uploads = 200/i" /etc/php5/php.ini
        sed -i "s/;*post_max_size =.*/post_max_size = 100M/i" /etc/php5/php.ini
        sed -i "s/;*cgi\.fix_pathinfo=.*/cgi\.fix_pathinfo= 0/i" /etc/php5/php.ini

# Move default nginx configuration
        echo -e "\t[i] Move default nginx configuration"
        mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.backup
		
# Create init flag /var/init_nginxweb_ok
        echo -e "\t[i] Create init flag /var/init_nginxweb_ok\n"
        touch /var/init_nginxweb_ok
else
        echo -e "\n\t[i] Settings already done ...\n"
fi
