import connection from "../config/connection/sequelize-config.js"

class PostModel {

    // operação SQL para buscar postagens em modo booleano
    static async buscar(termo, limite, offset) {
        try {
            const resultado = await connection.query(
                "CALL buscar(?,?,?)",
                {
                    replacements: [termo, limite, offset]
                }
            )
            return resultado
        } catch (error) {
            console.log(`Erro ao pesquisar postagens: ${error}`)
        }
    }
    
    // operação SQL para buscar postagens em modo de linguagem natural
    static async buscarAvancado(termo, limite, offset) {
        try {
            const resultado = await connection.query(
                "CALL buscarAvancado(?,?,?)",
                {
                    replacements: [termo, limite, offset]
                }
            )
            return resultado
        } catch (error) {
            console.log(`Erro ao pesquisar postagens: ${error}`)
        }
    }
}

export default PostModel

