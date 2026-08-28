#!/bin/bash

#docker rm -f mysql-db node-app 2>/dev/null
#docker network rm devops-net 2>/dev/null
#docker volume rm mysql_data 2>/dev/null

echo "Criando rede personalizada..."
docker network create devops-net

echo "Criando volume de dados..."
docker volume create --driver local \
  --opt type=tmpfs \
  --opt device=tmpfs \
  --opt o=size=1g mysql_data


echo "Iniciando container MySQL..."
docker run -d \
  --name mysql-db \
  --network devops-net \
  --memory="128m" \
  --cpus="0.2" \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=devops_db \
  mysql:latest


echo "Aguardando o banco de dados inicializar..."
sleep 20


echo "Importando estrutura e registros do banco..."
docker exec -i mysql-db mysql -uroot -prootpassword devops_db < database/init.sql


echo "Construindo imagem da aplicação Node..."
docker build -t node-app .


echo "Iniciando container Node..."
docker run -d \
  --name node-app \
  --network devops-net \
  --memory="128m" \
  --cpus="0.2" \
  -p 3000:3000 \
  node-app

echo "Ambiente configurado e rodando"