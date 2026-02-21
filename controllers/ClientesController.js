import ClienteModel from "../models/Cliente.js"


class ClientesController {
    // requisita a consulta de todos os clientes
    static async listar(req, res) {
        try {
            const clientes = await Cliente.listar()
            res.json(clientes)
        } catch (error) {
            //res.status(500).json({ error: error.message })
        }
    }
}

export default ClientesController
