# Atividade Avaliativa DevOps: Conectando Containers (Node + MySQL)

Este projeto demonstra a infraestrutura e comunicação manual entre containers Docker distintos em uma rede privada isolada, sem o uso de Docker Compose ou a flag legacy '--link'.


# Especificações Técnicas do Ambiente:
    Rede Docker Privada | "devops-net" (Driver Bridge)
    Container Banco de Dados | "mysql-db" (Imagem: "mysql:latest")
    Container Aplicação | "node-app" (Imagem customizada via Dockerfile)
    Porta Exposta da Aplicação | `3000` ("http://localhost:3000")
    Limite de Memória RAM | "128MB" por container ("--memory="128m")
    Limite de CPU | "0.2" CPU por container ("--cpus="0.2"")
    Volume de Dados | "mysql_data" (Armazenamento limitado a 1GB)
    Comunicação entre Containers| Resolução DNS interna via Hostname ("mysql-db")

---

# Estrutura do Repositório

├── database/
│   └── init.sql         # Script com DDL (tabelas, FK) e DML (inserts)
├── scripts/
│   └── setup.sh         # Script para criação e subida do ambiente
├── Dockerfile           # Instruções de build da imagem da aplicação Node
├── package.json         # Dependências (Express, MySQL2)
├── index.js             # Código da aplicação Express e queries SQL (com JOIN)
└── README.md            # Documentação completa de execução

---

# Como Rodar
    ./scripts/setup.sh
    apagar a rede, containers e volume apos execução para executar novamente
    docker rm -f node-app mysql-db
    docker volume rm volume-mysql
    docker network rm rede-devops