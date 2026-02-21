// arquivo de conexão com o banco de dados
import Sequelize from "sequelize"

// cria conexão
const connection = new Sequelize({
    dialect: "mysql",
    host: "localhost",
    username: "root",
    password: "",
    database: "sqlsearch",
    timezone: "-03:00",
})

export default connection