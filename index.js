import express from "express"
import connection from "./config/connection/sequelize-config.js"
import postsRoute from "./routes/posts.route.js"

// configurações express
const app = express()
app.set("view engine", "ejs")
app.use(express.static("public"));
app.use(express.urlencoded({extended: true}))
app.use(express.json())

// tenta conectar ao banco
connection.authenticate().then(() => {
    console.log("Conexão com o banco de dados foi bem-sucedida!")
}).catch((error) => {
    console.log(`Ocorreu um erro ao conectar ao banco de dados: ${error}`)
})

// configurações rotas
app.get("/", (req, res) => {
    res.render("index", { pesquisa: []}) // passar array vazio impede erro de referência ao abrir a página pela primeira vez
})
app.use("/posts", postsRoute)

// inicia servidor HTTP
const port = 8080
app.listen(port, (error) => {
    if (error) {
        console.log(`Oops! Não foi possível iniciar o servidor: ${error}`)
    } else {
        console.log(`Servidor iniciado com sucesso em http://localhost:${port}`)
    }
})