#!/bin/bash

set -e

echo "Criando rede Docker"

docker network create rede-devops

echo "Criando container MySQL"

MSYS_NO_PATHCONV=1 docker run \
    --name mysql-db \
    --network rede-devops \
    --cpus="0.2" \
    --memory="128m" \
    --memory-swap="512m" \
    --storage-opt size=1G \
    -e MYSQL_ROOT_PASSWORD=fodase123 \
    -e MYSQL_DATABASE=loja \
    -v volume-mysql:/var/lib/mysql \
    -v "$(pwd)/database/init.sql:/docker-entrypoint-initdb.d/init.sql" \
    -d \
    mysql:latest

echo "Construindo imagem Node"

docker build -t node-app .

echo "Criando container Node"

docker run \
    --name node-app \
    --network rede-devops \
    --cpus="0.2" \
    --memory="128m" \
    --memory-swap="512m" \
    --storage-opt size=1G \
    -e DB_HOST=mysql-db \
    -e DB_PORT=3306 \
    -e DB_USER=root \
    -e DB_PASSWORD=fodase123 \
    -e DB_NAME=loja \
    -p 3000:3000 \
    -d \
    node-app

echo "Ambiente iniciado"
echo "Aplicação: http://localhost:3000"
echo "Categorias: http://localhost:3000/categorias"
echo "Produtos: http://localhost:3000/produtos"
