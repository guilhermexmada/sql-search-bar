import PostModel from "../models/Post.js"

class PostsController {

    // método para buscar postagens 
    static async buscar(req, res) {
        try {
            const termo = req.query.termo || ""
            const pagina = parseInt(req.query.pagina) || 0
            const limite = req.query.limite || 20
            const tipo = req.query.tipo || "booleana"
            const offset = (pagina - 1) * limite
            let totalRegistros = 0
            let totalPaginas = 0
            let busca

            if (tipo == "booleana") {
                busca = await PostModel.buscar(termo, limite, offset) // chama Model p/ busca booleana
            } else if (tipo == "natural"){
                busca = await PostModel.buscarAvancado(termo, limite, offset) // chamada Model p/ busca natural language
            }

            const resultado = busca

            // calcula total de registros e páginas encontrados
            if (resultado.length > 0) {
                totalRegistros = resultado[0].totalRegistros
                totalPaginas = Math.ceil(totalRegistros / limite)
            }

            res.render("index", {
                resultado,
                termo,
                pagina,
                totalRegistros,
                totalPaginas,
                limite,
                tipo
            })

        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    }
}

export default PostsController
