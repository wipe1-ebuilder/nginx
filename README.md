# Useful Commands

docker ps -a

docker stop nginx-ioof

docker rm nginx-ioof

docker build -t nginx-wimal:1.0 .  

docker run --name nginx-ioof -d -v /Volumes/Ubuntu/web_arts:/Volumes/Ubuntu/web_arts/ -p 443:443 -p 80:80  nginx-wimal:1.0 /bin/bash 

docker exec -it nginx-ioof /bin/bash
