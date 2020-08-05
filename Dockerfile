FROM nginx

EXPOSE 443
EXPOSE 80

RUN apt-get update && apt-get install -y telnet net-tools iputils-ping 

COPY aux_files/default.conf /etc/nginx/conf.d/default.conf
COPY aux_files/localhost-portfolioonline-com-au.pem /etc/nginx/localhost-portfolioonline-com-au.pem
COPY aux_files/localhost-portfolioonline-com-au.key /etc/nginx/localhost-portfolioonline-com-au.key

COPY start-nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-nginx.sh

ENTRYPOINT ["start-nginx.sh"]
