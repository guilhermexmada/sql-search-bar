import express from "express"

// instanciando express
const app = express()

// configurando view engine
app.set("view engine", "ejs")

// definindo diretório padrão p/ arquivos estáticos
app.use(express.static("public"));

// rota raiz -> index.ejs
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