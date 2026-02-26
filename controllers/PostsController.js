import PostModel from "../models/Post.js"

class PostsController {

    static async buscar(req, res){
        try{
            const termo = req.body.termo
            const pesquisa = await PostModel.buscar(termo)
            // res.json(pesquisa)
            // console.log(pesquisa)
            res.render("index",{pesquisa : pesquisa})
            
        } catch (error){
            res.status(500).json({ error: error.message})
        }
    }
}

export default PostsController
