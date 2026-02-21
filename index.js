import express from "express"
import connection from "./config/connection/sequelize-config.js"
import clientesRoute from "./routes/clientes.route.js"

// instanciando express
const app = express()

// configurando view engine
app.set("view engine", "ejs")

// definindo diretório padrão p/ arquivos estáticos
app.use(express.static("public"));

// configurando recebimento de dados via forms
app.use(express.urlencoded({extended: false}))

// configurando caminho inicial das rotas
app.use("/clientes", clientesRoute)

// rota raiz
app.get("/", (req, res) => {
    res.render("index")
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