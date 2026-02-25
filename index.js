import express from "express"
import connection from "./config/connection/sequelize-config.js"
import postsRoute from "./routes/posts.route.js"

// instanciando express
const app = express()

// tenta conectar ao banco
connection.authenticate().then(() => {
    console.log("Conexão com o banco de dados foi bem-sucedida!")
}).catch((error) => {
    console.log(`Ocorreu um erro ao conectar ao banco de dados: ${error}`)
})

// configurando view engine
app.set("view engine", "ejs")

// definindo diretório padrão p/ arquivos estáticos
app.use(express.static("public"));

// configurando recebimento de dados via forms
app.use(express.urlencoded({extended: true})) // true = permite

app.use(express.json())

// configurando caminho inicial das rotas
app.use("/posts", postsRoute)

// rota raiz
app.get("/", (req, res) => {
    res.render("index", { clientes: []}) // passar array vazio impede erro de referência ao abrir a página pela primeira vez
})

// inicia servidor HTTP
const port = 8080
app.listen(port, (error) => {
    if (error) {
        console.log(`Oops! Não foi possível iniciar o servidor: ${error}`)
    } else {
        console.log(`Servidor iniciado com sucesso em http://localhost:${port}`)
    }
})