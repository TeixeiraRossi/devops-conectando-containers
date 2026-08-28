const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
const PORT = 3000;

// Configuração da conexão usando o hostname 'mysql-db' (Nome do container)
const dbConfig = {
  host: process.env.DB_HOST || 'mysql-db',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || 'rootpassword',
  database: process.env.DB_NAME || 'devops_db'
};

async function getDBConnection() {
  return await mysql.createConnection(dbConfig);
}

app.get('/categorias', async (req, res) => {
  try {
    const connection = await getDBConnection();
    const [rows] = await connection.execute('SELECT * FROM categorias');
    await connection.end();
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar categorias', details: error.message });
  }
});

app.get('/produtos', async (req, res) => {
  try {
    const connection = await getDBConnection();
    const query = `
      SELECT 
        p.id, 
        p.nome, 
        p.preco, 
        p.quantidade_estoque, 
        c.nome AS categoria
      FROM produtos p
      INNER JOIN categorias c ON p.categoria_id = c.id
    `;
    const [rows] = await connection.execute(query);
    await connection.end();
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: 'Erro ao buscar produtos', details: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Aplicação rodando na porta ${PORT}`);
});