import connection from "../config/connection/sequelize-config.js"

class PostModel {

    static async buscar(termo, offset) {
        try {
            const resultado = await connection.query(
                "CALL buscar(?,?)",
                {
                    replacements: [termo, offset]
                }
            )
            // console.log(pesquisa)
            return resultado
        } catch (error) {
            console.log(`Ocorreu um erro ao pesquisar: ${error}`)
            throw new Error("Não foi possível consultar os dados")
        }
    }
}


export default PostModel

