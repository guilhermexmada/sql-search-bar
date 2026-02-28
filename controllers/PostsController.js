import PostModel from "../models/Post.js"

class PostsController {

    static async buscar(req, res) {
        try {
            const termo = req.query.termo || ""
            const pagina = parseInt(req.query.pagina) || 1
            let totalRegistros = 0
            let totalPaginas = 0

            const offset = (pagina - 1) * 20 // limit = 20 por padrão

            const resultado = await PostModel.buscar(termo, offset)
            //res.json(resultado)

            if (resultado.length > 0) {
                totalRegistros = resultado[0].totalRegistros
                totalPaginas = Math.ceil(totalRegistros / 20)
            } else{
                 totalRegistros = 0
                 totalPaginas = 0
            }

            res.render("index", {
                resultado: resultado,
                termo,
                pagina,
                totalRegistros: totalRegistros,
                totalPaginas: totalPaginas
            })

        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    }
}

export default PostsController
