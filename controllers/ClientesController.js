import ClienteModel from "../models/Cliente.js"


class ClientesController {
    // requisita a consulta de todos os clientes
    static async listar(req, res) {
        try {
            const clientes = await ClienteModel.listar()
            res.render("index",{clientes})
            //res.json(clientes)
        } catch (error) {
            res.status(500).json({ error: error.message })
        }
    }

    static async buscar(req, res){
        //console.log('rota acionada')
        try{
            const termo = req.body.termo
            const pesquisa = await ClienteModel.buscar(termo)
            res.json(pesquisa)
            //res.render("index",{clientes : pesquisa})
        } catch (error){
            res.status(500).json({ error: error.message})
        }
    }
}

export default ClientesController
