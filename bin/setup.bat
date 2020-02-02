docker-compose stop

rmdir /s /q _build
rmdir /s /q deps

docker-compose pull
docker-compose build --build-arg UID=1000 --build-arg GID=1000 web
