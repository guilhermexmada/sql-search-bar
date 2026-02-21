import Sequelize from "sequelize"
import connection from "../config/connection/sequelize-config.js"

class ClienteModel {
    // consulta os dados de todos os clientes no banco
    static async listar() {
        try {
            const [clientes] = await Sequelize.query("SELECT * FROM vw_clientes")
            return clientes
        } catch (error) {
            console.log(`Ocorreu um erro ao listar os clientes: ${error}`)
            //throw new Error("Não foi possível consultar os clientes")
        }
    }
}

export default ClienteModel

