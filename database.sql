create database sqlsearch;
use sqlsearch;

-- =====================================================
-- TABELA: usuarios
-- =====================================================
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    nome VARCHAR(150) NOT NULL,
    
    email VARCHAR(150) NOT NULL UNIQUE,
    
    username VARCHAR(100) NOT NULL UNIQUE,
    
    bio TEXT NULL,
    
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP

);

-- =====================================================
-- TABELA: postagens
-- =====================================================
CREATE TABLE postagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    usuario_id INT NOT NULL,
    
    titulo VARCHAR(255) NOT NULL,
    
    conteudo TEXT NOT NULL,
    
    tags TEXT NULL,
    
    visualizacoes INT NOT NULL DEFAULT 0,
    
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_postagem_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =====================================================
-- TABELA: comentarios
-- =====================================================
CREATE TABLE comentarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    postagem_id INT NOT NULL,
    
    usuario_id INT NOT NULL,
    
    conteudo TEXT NOT NULL,
    
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_comentario_postagem
        FOREIGN KEY (postagem_id)
        REFERENCES postagens(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_comentario_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

);

-- =====================================================
-- ÍNDICES FULLTEXT PARA TESTES DE BUSCA
-- =====================================================

-- Busca em postagens
ALTER TABLE postagens
ADD FULLTEXT idx_postagens_busca (titulo, conteudo, tags);

-- Busca em comentários
ALTER TABLE comentarios
ADD FULLTEXT idx_comentarios_busca (conteudo);