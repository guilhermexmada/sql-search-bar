import connection from "../config/connection/sequelize-config.js"

class PostModel {

    static async buscar(termo, offset) {
        try {
            const pesquisa = await connection.query(
                "CALL buscar(:termo,:offset)",
                {
                    replacements: { termo : termo, offset : offset },
                    // type: connection.QueryTypes.SELECT 
                }
            )
            return pesquisa
        } catch (error) {
            console.log(`Ocorreu um erro ao pesquisar: ${error}`)
            throw new Error("Não foi possível consultar os dados")
        }
    }
}


export default PostModel

