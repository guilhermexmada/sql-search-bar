import express from "express"
import PostsController from "../controllers/PostsController.js"

const router = express.Router()

router.get("/posts/", PostsController.buscar)  // fulltext search

export default router // importado como 'postsRoute'