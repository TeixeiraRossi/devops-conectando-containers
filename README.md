# Atividade Avaliativa DevOps: Conectando Containers (Node + MySQL)

Este projeto demonstra a infraestrutura e comunicação entre containers Docker distintos em uma rede privada (Docker Compose custom network), gerenciados de forma fácil utilizando **Docker Compose**.

# Especificações Técnicas do Ambiente:
    Orquestração | Docker Compose
    Container Banco de Dados | "mysql-db" (Imagem: "mysql:latest")
    Container Aplicação | "node-app" (Imagem customizada via Dockerfile)
    Porta Exposta da Aplicação | `3000` (http://localhost:3000)
    Limite de Memória RAM | "128MB" por container ("mem_limit: 128m")
    Limite de CPU | "0.2" CPU por container ("cpus: 0.2")
    Volume de Dados | "volume-mysql"
    Comunicação entre Containers | Resolução DNS interna fornecida pelo Docker Compose.

---

# Estrutura do Repositório

├── database/
│   └── init.sql         # Script com DDL (tabelas, FK) e DML (inserts)
├── Dockerfile           # Instruções de build da imagem da aplicação Node
├── docker-compose.yml   # Manifesto para subir banco de dados e aplicação integrados
├── package.json         # Dependências (Express, MySQL2)
├── index.js             # Código da aplicação Express e queries SQL (com JOIN)
└── README.md            # Documentação completa de execução

---

# Como Rodar

Para construir as imagens e iniciar os containers em segundo plano, execute:

```bash
docker-compose up -d --build
# ou
docker compose up -d --build
```

O ambiente será iniciado:
- **Aplicação:** http://localhost:3000
- **Categorias:** http://localhost:3000/categorias
- **Produtos:** http://localhost:3000/produtos

Para parar a execução e remover os containers e a rede (sem perder os dados do volume):
```bash
docker-compose down
```

Para remover os containers, rede e também destruir o volume do banco de dados:
```bash
docker-compose down -v
```