const express = require("express");
const mysql = require("mysql2/promise");

const app = express();

const PORT = process.env.PORT || 3000;

const dbConfig = {
    host: process.env.DB_HOST || "mysql-db",
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "fodase123",
    database: process.env.DB_NAME || "loja"
};

let connection;

async function conectarBanco() {
    try {
        connection = await mysql.createConnection(dbConfig);

        console.log("Conectado ao MySQL com sucesso!");
    } catch (error) {
        console.error("Erro ao conectar ao MySQL:", error.message);

        setTimeout(conectarBanco, 3000);
    }
}

app.get("/", (req, res) => {
    res.json({
        mensagem: "API Node + MySQL funcionando!"
    });
});

app.get("/categorias", async (req, res) => {
    try {
        const [categorias] = await connection.query(
            "SELECT * FROM categorias"
        );

        res.json(categorias);
    } catch (error) {
        console.error("Erro ao buscar categorias:", error.message);

        res.status(500).json({
            erro: "Erro ao buscar categorias"
        });
    }
});

app.get("/produtos", async (req, res) => {
    try {
        const [produtos] = await connection.query(`
            SELECT
                produtos.id,
                produtos.nome,
                produtos.preco,
                produtos.quantidade_estoque,
                categorias.nome AS categoria
            FROM produtos
            INNER JOIN categorias
                ON produtos.categoria_id = categorias.id
        `);

        res.json(produtos);
    } catch (error) {
        console.error("Erro ao buscar produtos:", error.message);

        res.status(500).json({
            erro: "Erro ao buscar produtos"
        });
    }
});

app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});

conectarBanco();