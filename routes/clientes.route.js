import express from "express"
import ClientesController from "../controllers/ClientesController.js"

// instanciando funções de rotas
const router = express.Router()

router.get("/", ClientesController.listar) // rota para consultar todos os clientes

export default router // importado como 'clientesRoute'