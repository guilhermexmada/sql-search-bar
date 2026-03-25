# 🔎 SQL Search Bar

Projeto desenvolvido com foco em **aprendizado prático de arquitetura backend**, explorando a separação de responsabilidades em aplicações Node.js e o uso de **Stored Procedures no MySQL como camada principal de acesso a dados**.

---

## 📌 Objetivo do projeto

O principal objetivo deste projeto é investigar uma abordagem menos comum em aplicações web:

> **Remover a lógica SQL do código da aplicação e delegá-la totalmente ao banco de dados**

Para isso, o projeto utiliza:

* Stored Procedures como interface de acesso aos dados
* Full-Text Search nativo do MySQL
* Paginação implementada diretamente nas consultas SQL

Além disso, o projeto também busca comparar, na prática:

* `BOOLEAN MODE`
* `NATURAL LANGUAGE MODE`

---

## 🏗️ Arquitetura real do projeto

A aplicação segue uma estrutura simples inspirada em MVC, mas com uma característica importante:

> ⚠️ O “Model” não contém lógica de negócio — ele atua apenas como ponte para o banco

### 🔹 Fluxo completo

```
Requisição HTTP
   ↓
Route (Express)
   ↓
Controller
   ↓
Model (chamada de procedure)
   ↓
Stored Procedure (MySQL)
   ↓
Banco de dados
```

---

### 🔹 Controller (`PostsController`)

Responsável por:

* Ler parâmetros da query (`termo`, `pagina`, `limite`, `tipo`)
* Definir qual tipo de busca será usada
* Calcular paginação
* Renderizar a view

Trecho relevante:

```js
const tipo = req.query.tipo || "booleana"

if (tipo == "booleana") {
    busca = await PostModel.buscar(...)
} else if (tipo == "natural"){
    busca = await PostModel.buscarAvancado(...)
}
```

📌 Observação importante:

* A lógica de escolha do tipo de busca está no controller
* Não existe uma camada de service (decisão intencional ou simplificação)

---

### 🔹 Model (`PostModel`)

Aqui está um dos pontos mais importantes do projeto.

O model **não contém SQL direto**, apenas chama stored procedures:

```js
await connection.query("CALL buscar(?,?,?)", {
    replacements: [termo, limite, offset]
})
```

Isso significa que:

* A aplicação **não conhece a query real**
* Toda a lógica de busca está no banco
* O Node.js atua apenas como orquestrador

---

### 🔹 Banco de dados (MySQL)

O banco concentra a maior parte da lógica:

#### ✔️ Índices FULLTEXT

```sql
ALTER TABLE postagens
ADD FULLTEXT idx_postagens_busca (titulo, conteudo, tags);
```

#### ✔️ Procedure (BOOLEAN MODE)

```sql
CREATE PROCEDURE buscar(IN termo TEXT, IN limite INT, IN intervalo INT)
```

* Usa `MATCH ... AGAINST` em **BOOLEAN MODE**
* Permite operadores como `+`, `-`, `*`

#### ✔️ Procedure (NATURAL LANGUAGE MODE)

```sql
CREATE PROCEDURE buscarAvancado(IN termo TEXT, IN limite INT, IN intervalo INT)
```

* Busca baseada em relevância
* Sem operadores explícitos

---

### 🔹 Paginação no banco

Um detalhe muito interessante da implementação:

```sql
COUNT(*) OVER() AS totalRegistros
```

Isso permite:

* Retornar o total de resultados **na mesma query**
* Evitar uma segunda consulta para contagem

E junto com:

```sql
LIMIT limite OFFSET intervalo
```

Toda a paginação é resolvida no banco.

---

## 🧠 Decisões arquiteturais (análise)

Este projeto demonstra algumas escolhas importantes:

### ✅ Pontos fortes

* Forte desacoplamento entre aplicação e SQL
* Uso avançado de recursos do MySQL
* Paginação eficiente (com window function)
* Comparação prática entre modos de busca

### ⚠️ Trade-offs

* A lógica fica concentrada no banco (menos portável)
* Dificulta versionamento e testes automatizados
* Pode aumentar acoplamento com MySQL específico
* Ausência de camada service reduz flexibilidade

---

## 🔍 Funcionalidades implementadas

* Busca textual com FULLTEXT
* Dois modos de busca:

  * Boolean Mode
  * Natural Language Mode
* Paginação
* Interface simples com EJS
* Dataset robusto para testes (posts + comentários)

---

## 🧪 Geração de dados com Faker.js

O projeto utiliza a biblioteca **Faker.js** para popular o banco de dados com dados fictícios (posts e conteúdos textuais), permitindo:

* Criar volume suficiente para testes de busca
* Simular cenários mais próximos do mundo real
* Evidenciar, na prática, as diferenças entre **BOOLEAN MODE** e **NATURAL LANGUAGE MODE**

Essa etapa é essencial para que o comportamento do FULLTEXT SEARCH seja perceptível durante o uso da aplicação.

---

## Tecnologias utilizadas

 ![My Skills](https://go-skill-icons.vercel.app/api/icons?i=nodejs,express,mysql,ejs,sequelize,&theme=dark)

---

## ▶️ Como executar

### 1. Clone o repositório

```bash
git clone https://github.com/guilhermexmada/sql-search-bar.git
cd sql-search-bar
```

### 2. Instale as dependências

```bash
npm install
```

### 3. Configure o banco

* Crie um banco chamado `sqlsearch`
* Execute o arquivo:

```bash
database.sql
```

### 4. Ajuste conexão

Arquivo:

```
config/connection/sequelize-config.js
```

### 5. Execute

```bash
node index.js
```

Acesse:

```
http://localhost:8080
```

---

## 📚 Principais aprendizados

* Como usar stored procedures como camada de acesso
* Diferenças práticas entre modos de busca FULLTEXT
* Paginação eficiente no MySQL
* Organização de uma aplicação Express simples

---

## 🚧 Possíveis melhorias

* Adicionar camada de service
* Melhor tratamento de erros
* Separação de configs por ambiente
* Testes automatizados
* Uso de DTOs/validação
* Logging estruturado

---

## 📌 Conclusão

Este projeto é um ótimo experimento para entender:

> Até que ponto faz sentido deslocar a lógica da aplicação para o banco de dados

Ele mostra, na prática, como o MySQL pode assumir um papel mais ativo na arquitetura — indo além de simples persistência — e levanta discussões importantes sobre **acoplamento, performance e organização de código**.

🚀 Ideal para estudo de backend e SQL avançado.


### Mais detalhes

- 📃 Licença: [MIT](https://choosealicense.com/licenses/mit/)

- 👤 Sobre mim: Guilherme Shimada Pereira ([guilhermexmada](https://github.com/guilhermexmada))


### 🔗 Referências

- Faker.js : [Faker](https://fakerjs.dev/)
- Ícones das tecnologias: [LelouchFR/skill-icons](https://github.com/LelouchFR/skill-icons)
- Emojis: [piliapp/emoji](https://getemoji.com/)

