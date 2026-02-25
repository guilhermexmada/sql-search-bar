import Sequelize from "sequelize"
import connection from "../config/connection/sequelize-config.js"

class PostModel {
    // consulta os dados de todos os clientes no banco
    static async listar() {
        try {
            const [clientes] = await connection.query("SELECT * FROM vw_clientes")
            return clientes
        } catch (error) {
            console.log(`Ocorreu um erro ao listar os clientes: ${error}`)
            throw new Error("Não foi possível consultar os clientes")
        }
    }

    static async buscar(termo) {
        try {
            const [pesquisa] = await connection.query(
                "CALL buscar(:termo)",
            {
                replacements: { termo },
                type: connection.QueryTypes.SELECT // arruma problema de retornar apenas 01 registro por conta do aninhamento dos dados do JSON -> NODE
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

