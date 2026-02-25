import express from "express"
import PostsController from "../controllers/PostsController.js"

// instanciando funções de rotas
const router = express.Router()

router.get("/", PostsController.listar) // rota para consultar todos os clientes
router.post("/", PostsController.buscar) 

export default router // importado como 'postsRoute'