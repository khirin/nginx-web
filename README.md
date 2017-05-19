## NGINX Web & php-fpm5 Image

[![](https://images.microbadger.com/badges/image/khirin/nginx_web.svg)](https://microbadger.com/images/khirin/nginx_web "Get your own image badge on microbadger.com")

### Description
This is my minimal customized nginx+php-fpm5 image on Alpine (with [my alpine image](https://hub.docker.com/r/khirin/alpine/)).
No root process.
The start.sh script will check the nginx configuration, start php-fpm5, follow to the stdout access / error logs and finally launch nginx.

### Packages
• Packages from [khirin/alpine](https://hub.docker.com/r/khirin/alpine/)
• nginx
• php5-fpm
• php5-pdo_odbc
• php5-pdo
• php5-mysql
• php5-pdo_mysql
• php5-pdo_dblib
• php5-curl

### Default Configuration
• Configuration from [khirin/alpine](https://hub.docker.com/r/khirin/alpine/)
• Default user (UID) : nginx (2000)
• Default group (GID) : nginx (2000)
• Default ports : 11080 11443

### Volumes
• /scripts (RO) : Start script. 
• /conf (RO) : Virtual hosts configuration files for nginx.
• /web (RW) : Where all web folders are stored.

### Usage
• Run : Will use the default configuration above.
• Build : Example of custom build. You can also directly modify the Dockerfile (I won't be mad, promis !)
• Create : Example of custom create.

##### • Run
```shell
docker run --detach \
			-v "/my_script_folder:/scripts:ro" \
			-v "/my_conf_folder:/conf:ro" \
			-v "/my_web_folder:/web:rw" \
			-p 80:11080 -p 443:11443 \
			khirin/nginx-web
```

##### • Build
```shell
docker build --no-cache=true \
			--force-rm \
			--build-arg UID="2000" \
			--build-arg GID="2000" \
			--build-arg PORT="11080 11443"
			-t repo/nginx-web .
```

##### • Create
```shell
docker create --hostname=nginx-web \
			-v "/my_script_folder:/scripts:ro" \
			-v "/my_conf_folder:/conf:ro" \
			-v "/my_web_folder:/web:rw" \
			-p 80:11080 -p 443:11443 \
			--name nginx-web \
			repo/nginx-web
```

### Author
khirin : [DockerHub](https://hub.docker.com/u/khirin/), [GitHub](https://github.com/khirin?tab=repositories)

### Thanks
All my images are based on my personal knowledge and inspired by many projects of the Docker community.
If you recognize yourself in some working approaches, you might be one of my inspirations (Thanks!).
