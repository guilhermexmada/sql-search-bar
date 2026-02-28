import PostModel from "../models/Post.js"

class PostsController {

    static async buscar(req, res){
        try{
            const termo = req.query.termo || ""
            const pagina = parseInt(req.query.pagina) || 1
            
            const offset = (pagina - 1) * 20 // limit = 20 por padrão

            const pesquisa = await PostModel.buscar(termo, offset)
            // res.json(pesquisa)
            // console.log(pesquisa)

            const totalRegistros = pesquisa.length
            // const totalPaginas = Math.ceil(totalRegistros / 20)

            res.render("index",{
                pesquisa : pesquisa,
                termo,
                pagina,
                totalRegistros,
            })
            
        } catch (error){
            res.status(500).json({ error: error.message})
        }
    }
}

export default PostsController
