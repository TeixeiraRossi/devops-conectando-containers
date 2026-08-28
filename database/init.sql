CREATE DATABASE IF NOT EXISTS loja;
USE loja;

DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS categorias;

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    categoria_id INT NOT NULL,

    CONSTRAINT fk_produtos_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(id)
);

INSERT INTO categorias (nome, descricao, ativo) VALUES
('Eletrônicos', 'Dispositivos e gadgets tecnológicos', TRUE),
('Periféricos', 'Acessórios para computadores', TRUE),
('Redes', 'Equipamentos de infraestrutura e conectividade', TRUE);

INSERT INTO produtos (nome, preco, quantidade_estoque, categoria_id) VALUES
('Mouse Sem Fio', 89.90, 50, 2),
('Roteador Wi-Fi 6', 350.00, 20, 3),
('Monitor 24 Polegadas', 750.00, 15, 1);