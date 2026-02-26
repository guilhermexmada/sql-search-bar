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

-- =====================================================
-- POPULANDO TABELAS
-- =====================================================

INSERT INTO usuarios (nome, email, username, bio, status) VALUES
('João Silva', 'joao.silva@email.com', 'joaosilva', 'Desenvolvedor backend apaixonado por bancos de dados e otimização de consultas SQL.', 'ativo'),
('Maria Oliveira', 'maria.oliveira@email.com', 'mariaoliveira', 'Analista de sistemas focada em arquitetura de software e microsserviços.', 'ativo'),
('Carlos Souza', 'carlos.souza@email.com', 'carlossouza', 'Estudante de ciência da computação interessado em inteligência artificial.', 'ativo'),
('Ana Pereira', 'ana.pereira@email.com', 'anapereira', 'Especialista em UX/UI e design de interfaces acessíveis.', 'ativo'),
('Lucas Fernandes', 'lucas.fernandes@email.com', 'lucasfernandes', 'Engenheiro de software com foco em aplicações web escaláveis.', 'ativo'),
('Juliana Costa', 'juliana.costa@email.com', 'julianacosta', 'Pesquisadora na área de aprendizado de máquina e visão computacional.', 'ativo'),
('Rafael Almeida', 'rafael.almeida@email.com', 'rafaelalmeida', 'Administrador de banco de dados com experiência em MySQL e PostgreSQL.', 'ativo'),
('Patrícia Gomes', 'patricia.gomes@email.com', 'patriciagomes', 'Desenvolvedora full stack apaixonada por JavaScript e Node.js.', 'ativo'),
('Fernando Lima', 'fernando.lima@email.com', 'fernandolima', 'Arquiteto de soluções em cloud computing e infraestrutura.', 'ativo'),
('Camila Rocha', 'camila.rocha@email.com', 'camilarocha', 'Entusiasta de segurança da informação e criptografia.', 'ativo'),
('Bruno Martins', 'bruno.martins@email.com', 'brunomartins', 'Programador focado em performance e algoritmos eficientes.', 'ativo'),
('Larissa Nunes', 'larissa.nunes@email.com', 'larissanunes', 'Especialista em banco de dados relacionais e modelagem de dados.', 'ativo'),
('Gustavo Ribeiro', 'gustavo.ribeiro@email.com', 'gustavoribeiro', 'Desenvolvedor mobile com experiência em aplicações híbridas.', 'ativo'),
('Beatriz Carvalho', 'beatriz.carvalho@email.com', 'beatrizcarvalho', 'Profissional de DevOps com foco em CI/CD e automação.', 'ativo'),
('Ricardo Mendes', 'ricardo.mendes@email.com', 'ricardomendes', 'Estudioso de inteligência artificial aplicada à indústria.', 'ativo'),
('Aline Barbosa', 'aline.barbosa@email.com', 'alinebarbosa', 'Engenheira de computação com interesse em sistemas distribuídos.', 'ativo'),
('Eduardo Santana', 'eduardo.santana@email.com', 'eduardosantana', 'Desenvolvedor frontend especialista em React e acessibilidade web.', 'ativo'),
('Vanessa Duarte', 'vanessa.duarte@email.com', 'vanessaduarte', 'Consultora de tecnologia focada em transformação digital.', 'ativo'),
('Thiago Moreira', 'thiago.moreira@email.com', 'thiagomoreira', 'Pesquisador em processamento de linguagem natural.', 'ativo'),
('Renata Azevedo', 'renata.azevedo@email.com', 'renataazevedo', 'Engenheira de software com foco em arquitetura limpa e boas práticas.', 'ativo');

INSERT INTO postagens (usuario_id, titulo, conteudo, tags, visualizacoes, status) VALUES

(1, 'Otimização de consultas no MySQL com FULLTEXT',
'Neste artigo exploro como utilizar índices FULLTEXT para melhorar a performance de buscas textuais em grandes volumes de dados. Demonstro diferenças entre LIKE e MATCH AGAINST, explico o uso do BOOLEAN MODE e apresento exemplos práticos com tabelas contendo milhares de registros.',
'mysql,fulltext,sql,performance,banco de dados', 120, 'ativo'),

(2, 'Arquitetura de microsserviços na prática',
'Abordo conceitos fundamentais de microsserviços, comunicação via APIs REST, mensageria assíncrona e boas práticas de escalabilidade. Também discuto desafios comuns como consistência eventual e monitoramento distribuído.',
'arquitetura,microsservicos,api,cloud', 98, 'ativo'),

(3, 'Introdução à Inteligência Artificial aplicada',
'Uma visão geral sobre aprendizado de máquina, redes neurais artificiais e aplicações práticas em visão computacional e processamento de linguagem natural.',
'ia,aprendizado de maquina,redes neurais,python', 150, 'ativo'),

(4, 'Design centrado no usuário',
'Exploro princípios de usabilidade, acessibilidade digital e testes de experiência do usuário. O foco está em criar interfaces intuitivas e inclusivas.',
'ux,ui,design,acessibilidade', 87, 'ativo'),

(5, 'Escalabilidade em aplicações web modernas',
'Discorro sobre balanceamento de carga, cache distribuído e uso de containers para suportar alto volume de acessos simultâneos.',
'web,escalabilidade,docker,kubernetes', 134, 'ativo'),

(6, 'Visão computacional e reconhecimento de padrões',
'Analiso técnicas de detecção de objetos, classificação de imagens e uso de redes convolucionais para resolver problemas do mundo real.',
'visao computacional,ia,deep learning,opencv', 143, 'ativo'),

(7, 'Modelagem relacional eficiente',
'Mostro como aplicar normalização, integridade referencial e constraints adequadas para manter consistência e segurança dos dados.',
'modelagem,banco de dados,sql,integridade', 76, 'ativo'),

(8, 'Node.js e APIs REST performáticas',
'Apresento estratégias para construção de APIs com Node e Express, incluindo autenticação JWT, middlewares e tratamento de erros.',
'nodejs,express,api,backend', 165, 'ativo'),

(9, 'Infraestrutura em nuvem e alta disponibilidade',
'Comparo provedores cloud, estratégias de redundância e monitoramento contínuo para sistemas críticos.',
'cloud,aws,infraestrutura,alta disponibilidade', 101, 'ativo'),

(10, 'Criptografia aplicada à segurança da informação',
'Exploro algoritmos de hash, criptografia simétrica e assimétrica, além de boas práticas para proteção de dados sensíveis.',
'seguranca,criptografia,hash,proteção de dados', 112, 'ativo'),

(11, 'Algoritmos eficientes e análise de complexidade',
'Explico notação Big O, otimização de algoritmos e comparação entre estruturas de dados como listas, árvores e grafos.',
'algoritmos,complexidade,estrutura de dados', 92, 'ativo'),

(12, 'Normalização e performance em bancos relacionais',
'Discuto quando aplicar normalização ou desnormalização e como índices impactam diretamente na performance das consultas.',
'sql,normalizacao,performance,banco relacional', 83, 'ativo'),

(13, 'Desenvolvimento mobile híbrido',
'Abordo frameworks híbridos, desempenho em dispositivos móveis e desafios de compatibilidade multiplataforma.',
'mobile,flutter,react native,aplicativos', 71, 'ativo'),

(14, 'Integração contínua e automação',
'Mostro como pipelines de CI/CD ajudam a manter qualidade, testes automatizados e entregas contínuas.',
'devops,ci cd,automacao,git', 140, 'ativo'),

(15, 'Processamento de linguagem natural',
'Analiso técnicas de tokenização, stemming e análise semântica para construção de mecanismos de busca inteligentes.',
'nlp,linguagem natural,ia,fulltext', 155, 'ativo'),

(16, 'Sistemas distribuídos e consistência',
'Exploro conceitos como teorema CAP, replicação de dados e estratégias para tolerância a falhas.',
'sistemas distribuidos,replicacao,cap theorem', 110, 'ativo'),

(17, 'Frontend moderno com React',
'Discorro sobre componentes reutilizáveis, hooks e otimização de renderização em aplicações SPA.',
'react,frontend,spa,javascript', 99, 'ativo'),

(18, 'Transformação digital nas empresas',
'Analiso impactos da tecnologia na gestão corporativa e na modernização de processos internos.',
'transformacao digital,tecnologia,gestao', 65, 'ativo'),

(19, 'Indexação textual e mecanismos de busca',
'Detalho como funciona um índice invertido, cálculo de relevância e aplicação prática em bancos de dados relacionais.',
'fulltext,indice invertido,busca,relevancia', 180, 'ativo'),

(20, 'Boas práticas de arquitetura limpa',
'Apresento princípios de separação de responsabilidades, injeção de dependência e organização modular de código.',
'arquitetura limpa,boas praticas,software', 125, 'ativo'),

-- Repetindo autores com novos temas

(1, 'Comparando LIKE e FULLTEXT no MySQL',
'Comparação prática entre consultas utilizando operador LIKE e busca FULLTEXT, analisando tempo de execução e consumo de recursos.',
'mysql,like,fulltext,benchmark', 210, 'ativo'),

(2, 'Desafios em sistemas orientados a eventos',
'Discuto filas de mensagens, eventos assíncronos e problemas comuns como duplicidade e idempotência.',
'eventos,arquitetura,backend', 88, 'ativo'),

(3, 'Redes neurais profundas e aplicações industriais',
'Estudo de casos envolvendo deep learning aplicado a automação e análise preditiva.',
'deep learning,industria,ia', 170, 'ativo'),

(4, 'Acessibilidade e inclusão digital',
'Importância de padrões WCAG e desenvolvimento de interfaces acessíveis a pessoas com deficiência.',
'acessibilidade,design,inclusao', 77, 'ativo'),

(5, 'Monitoramento e observabilidade',
'Ferramentas e métricas para acompanhar saúde de aplicações em produção.',
'monitoramento,logs,observabilidade', 94, 'ativo'),

(6, 'Treinamento de modelos com grandes volumes de dados',
'Exploro desafios computacionais e técnicas de otimização para treinamento eficiente.',
'big data,ia,treinamento', 136, 'ativo'),

(7, 'Transações e controle de concorrência',
'Explicação sobre ACID, isolamento de transações e MVCC no InnoDB.',
'transacoes,acid,innodb,sql', 119, 'ativo'),

(8, 'Segurança em APIs REST',
'Implementação de autenticação segura, controle de acesso e proteção contra ataques comuns.',
'seguranca,api,autenticacao', 101, 'ativo'),

(9, 'Escalando aplicações com containers',
'Uso de Docker e orquestração com Kubernetes para ambientes de produção.',
'docker,kubernetes,cloud', 130, 'ativo'),

(10, 'Proteção contra ataques cibernéticos',
'Análise de ataques como SQL Injection e XSS e como preveni-los adequadamente.',
'seguranca,sql injection,xss', 200, 'ativo'),

(11, 'Estruturas de dados aplicadas a grafos',
'Aplicações práticas de grafos em redes sociais e mecanismos de recomendação.',
'grafos,algoritmos,estrutura de dados', 73, 'ativo'),

(12, 'O impacto dos índices na performance',
'Estudo comparativo sobre diferentes tipos de índices em bancos relacionais.',
'indices,sql,performance', 158, 'ativo'),

(13, 'Desenvolvimento mobile e performance',
'Otimizações para reduzir consumo de bateria e melhorar experiência do usuário.',
'mobile,performance,aplicativos', 90, 'ativo'),

(14, 'Automação de testes em larga escala',
'Como estruturar suítes de testes automatizados para sistemas complexos.',
'testes,automacao,qualidade', 145, 'ativo'),

(15, 'Buscas semânticas em bancos relacionais',
'Exploro estratégias para melhorar relevância em FULLTEXT utilizando BOOLEAN MODE.',
'fulltext,boolean mode,sql', 178, 'ativo'),

(16, 'Tolerância a falhas em sistemas críticos',
'Implementação de redundância e recuperação automática após falhas.',
'sistemas criticos,backup,replicacao', 111, 'ativo'),

(17, 'Performance em aplicações React',
'Técnicas como memoização e lazy loading para melhorar tempo de carregamento.',
'react,performance,frontend', 84, 'ativo'),

(18, 'Gestão de projetos de tecnologia',
'Boas práticas de planejamento, metodologias ágeis e métricas de produtividade.',
'gestao,agil,scrum', 69, 'ativo'),

(19, 'Relevância e ranking em mecanismos de busca',
'Estudo sobre cálculo de score e ordenação por relevância em consultas FULLTEXT.',
'relevancia,ranking,fulltext', 190, 'ativo'),

(20, 'Refatoração e melhoria contínua de código',
'Importância da manutenção evolutiva e padrões de código limpo.',
'refatoracao,clean code,software', 133, 'ativo'),

(3, 'Aplicações práticas de NLP em chatbots',
'Discussão sobre uso de processamento de linguagem natural para criar assistentes virtuais inteligentes.',
'nlp,chatbot,inteligencia artificial', 160, 'ativo'),

(7, 'Boas práticas em modelagem de dados',
'Erros comuns na modelagem relacional e como evitá-los em projetos reais.',
'modelagem,sql,banco de dados', 97, 'inativo'),

(12, 'Desnormalização estratégica',
'Quando vale a pena sacrificar normalização em prol de performance.',
'desnormalizacao,performance,banco de dados', 88, 'ativo'),

(1, 'Indexação e análise de texto em larga escala',
'Estudo aprofundado sobre indexação textual, stemming e impacto no desempenho de buscas complexas.',
'indexacao,texto,fulltext,escala', 220, 'ativo');

INSERT INTO comentarios (postagem_id, usuario_id, conteudo, status) VALUES

-- Postagens 1–10
(1,1,'Excelente análise sobre arquitetura e organização de código. Muito relevante para projetos reais.','ativo'),
(1,2,'Gostei bastante da explicação sobre separação de responsabilidades.','ativo'),
(1,3,'A parte sobre performance foi essencial para entender o contexto.','ativo'),

(2,4,'Muito interessante a abordagem sobre busca textual e indexação.','ativo'),
(2,5,'Esse conteúdo ajuda bastante quem está estudando banco de dados.','ativo'),
(2,6,'Talvez pudesse aprofundar na comparação entre os mecanismos de busca.','inativo'),

(3,7,'Ótimo exemplo aplicado à prática de desenvolvimento web.','ativo'),
(3,8,'Gostei do detalhamento técnico apresentado.','ativo'),
(3,9,'Muito útil para quem trabalha com grandes volumes de dados.','ativo'),

(4,10,'A discussão sobre otimização foi muito bem estruturada.','ativo'),
(4,11,'Já enfrentei problema semelhante em produção.','ativo'),
(4,12,'Excelente conteúdo para estudo acadêmico.','ativo'),

(5,13,'Gostei do equilíbrio entre teoria e prática.','ativo'),
(5,14,'Muito pertinente para sistemas escaláveis.','ativo'),
(5,15,'A parte sobre modelagem de dados foi esclarecedora.','ativo'),

(6,16,'Ótima contextualização técnica.','ativo'),
(6,17,'Gostei bastante da clareza do texto.','ativo'),
(6,18,'Muito interessante para quem trabalha com APIs.','ativo'),

(7,19,'A abordagem prática foi o ponto mais forte.','ativo'),
(7,20,'Conteúdo muito bem organizado.','ativo'),
(7,1,'Excelente explicação sobre indexação invertida.','ativo'),

(8,2,'A comparação entre soluções foi muito útil.','ativo'),
(8,3,'Gostei do aprofundamento na parte de performance.','ativo'),
(8,4,'Ótimo conteúdo para referência futura.','ativo'),

(9,5,'A explicação foi bastante didática.','ativo'),
(9,6,'Muito relevante para sistemas corporativos.','ativo'),
(9,7,'Gostei da clareza dos exemplos apresentados.','inativo'),

(10,8,'Excelente abordagem sobre escalabilidade.','ativo'),
(10,9,'Muito interessante a análise técnica.','ativo'),
(10,10,'Conteúdo bastante consistente.','ativo'),

-- Postagens 11–20
(11,11,'A parte sobre cloud computing foi bem explicada.','ativo'),
(11,12,'Gostei do enfoque em microsserviços.','ativo'),
(11,13,'Ótima discussão técnica.','ativo'),

(12,14,'Muito bom para quem quer entender fulltext search.','ativo'),
(12,15,'Excelente detalhamento sobre relevância de termos.','ativo'),
(12,16,'Gostei da organização das ideias.','ativo'),

(13,17,'A parte prática facilitou bastante o entendimento.','ativo'),
(13,18,'Muito bem estruturado.','ativo'),
(13,19,'Gostei da análise comparativa.','ativo'),

(14,20,'Ótimo ponto sobre normalização.','ativo'),
(14,1,'Conteúdo bastante técnico e preciso.','ativo'),
(14,2,'Muito interessante para estudo avançado.','ativo'),

(15,3,'Excelente explicação sobre consultas complexas.','ativo'),
(15,4,'Gostei do detalhamento apresentado.','ativo'),
(15,5,'Muito útil para desenvolvedores backend.','ativo'),

(16,6,'A discussão sobre performance foi relevante.','ativo'),
(16,7,'Gostei da clareza na explicação.','ativo'),
(16,8,'Ótimo conteúdo para aplicar em projetos reais.','ativo'),

(17,9,'Excelente contextualização do tema.','ativo'),
(17,10,'Muito interessante a parte de otimização.','ativo'),
(17,11,'Gostei da abordagem prática.','ativo'),

(18,12,'Ótima contribuição técnica.','ativo'),
(18,13,'Conteúdo muito esclarecedor.','ativo'),
(18,14,'A explicação foi bem didática.','ativo'),

(19,15,'Excelente organização textual.','ativo'),
(19,16,'Muito relevante para bancos relacionais.','ativo'),
(19,17,'Gostei bastante do aprofundamento.','ativo'),

(20,18,'Ótima análise crítica.','ativo'),
(20,19,'Muito bom para quem estuda arquitetura.','ativo'),
(20,20,'Excelente detalhamento técnico.','ativo'),

-- Postagens 21–50 (distribuição variada)
(21,1,'Muito interessante esse ponto levantado.','ativo'),
(22,2,'Gostei bastante da clareza do texto.','ativo'),
(23,3,'Excelente abordagem técnica.','ativo'),
(24,4,'Muito útil para estudo de caso.','ativo'),
(25,5,'Gostei da comparação entre tecnologias.','ativo'),
(26,6,'Ótimo aprofundamento no tema.','ativo'),
(27,7,'Conteúdo muito relevante.','ativo'),
(28,8,'Excelente explicação prática.','ativo'),
(29,9,'Muito interessante a análise.','ativo'),
(30,10,'Gostei bastante do exemplo apresentado.','ativo'),

(31,11,'Ótima contribuição para desenvolvedores.','ativo'),
(32,12,'Conteúdo bastante didático.','ativo'),
(33,13,'Excelente contextualização.','ativo'),
(34,14,'Muito pertinente para projetos web.','ativo'),
(35,15,'Gostei do foco em performance.','ativo'),
(36,16,'Ótima discussão técnica.','ativo'),
(37,17,'Conteúdo bastante claro.','ativo'),
(38,18,'Excelente abordagem comparativa.','ativo'),
(39,19,'Muito bom para aprendizado contínuo.','ativo'),
(40,20,'Gostei bastante do equilíbrio teórico.','ativo'),

(41,1,'Ótima análise de arquitetura.','ativo'),
(42,2,'Muito interessante a explicação sobre busca textual.','ativo'),
(43,3,'Excelente detalhamento sobre indexação.','ativo'),
(44,4,'Gostei do exemplo aplicado.','ativo');

-- =====================================================
-- CONSULTA FULLTEXT em BOOLEAN MODE
-- =====================================================

DELIMITER //
CREATE PROCEDURE buscar(IN termo TEXT)
BEGIN
	SELECT
	post.id,
    post.titulo,
    post.conteudo,
    post.tags,
    MATCH(post.titulo, post.conteudo, post.tags)
    AGAINST(termo IN BOOLEAN MODE) AS score
FROM postagens post WHERE post.status = 'ativo'
AND MATCH(post.titulo, post.conteudo, post.tags)
AGAINST(termo IN BOOLEAN MODE)
ORDER BY score DESC;
END //
DELIMITER ;

-- =====================================================
-- CONSULTA FULLTEXT em NATURAL LANGUAGE MODE
-- =====================================================

DELIMITER //
CREATE PROCEDURE buscarAvancado(IN termo TEXT)
BEGIN
	SELECT
	post.id,
    post.titulo,
    post.conteudo,
    post.tags,
    MATCH(post.titulo, post.conteudo, post.tags)
    AGAINST(termo IN NATURAL LANGUAGE MODE) AS score
FROM postagens post WHERE post.status = 'ativo'
AND MATCH(post.titulo, post.conteudo, post.tags)
AGAINST(termo IN BOOLEAN MODE)
ORDER BY score DESC;
END //
DELIMITER ;

# CALL buscar('sql'); 
# CALL buscarAvancado('sql');