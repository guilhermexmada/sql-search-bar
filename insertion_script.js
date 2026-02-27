import { faker } from '@faker-js/faker'
import fs from 'fs'

const totalRegistros = 10000

const termosComuns = [
    // programação
    [
        'desenvolvimento',
        'programação',
        'software',
        'código',
        'PHP',
        'Javascript',
        'C#',
        'Go',
        'Java',
        'orientação a objetos',
        'design gráfico',
        'HTML',
        'CSS',
        'C++',
        'front-end',
        'back-end',
        'API',
        'fullstack',
        'sistemas',
        'mobile',
        'web'
    ],
    // dados
    [
        'engenharia de dados',
        'Cloud',
        'banco de dados',
        'SQL',
        'NoSQL',
        'Postgre',
        'MySQL',
        'Mongo',
        'data mining',
        'IA',
        'inteligência artificial',
        'machine learning',
        'data centers',
        'redes neurais',
        'queries',
        'análise de dados',
        'dados',
        'Firebase',
        'grafos',
        'aprendizado de máquina',
        'prompt'
    ],
    // infraestrutura
    [
        'redes',
        'infraestrutura',
        'devops',
        'servidores',
        'switch',
        'LANs',
        'WLANs',
        'mikrotik',
        'Cisco',
        'Huawei',
        'Dell',
        'suporte de infraestrutura',
        'dispositivos de rede',
        'cabeamento ethernet',
        'redes TCP/IP',
        'roteadores',
        'arquitetura de rede',
        'Windows Server',
        'Linux',
        'wi-fi'
    ]
]

const termosTecnicos = [
    // programação
    [
        'polimorfismo',
        'encapsulamento',
        'herança',
        'recursão',
        'serialização',
        'disserialização',
        'garbage collection',
        'concorrência',
        'paralelismo',
        'deadlock',
        'refatoração',
        'ORM',
        'API REST',
        'middleware',
        'testes unitários'
    ],
    // dados
    [
        'normalização',
        'índice composto',
        'chave primária',
        'chave estrangeira',
        'data warehouse',
        'ETL',
        'big data',
        'query',
        'JOIN',
        'Stored Procedure',
        'trigger',
        'modelagem relacional',
        'cardinalidade'
    ],
    // infraestrutura
    [
        'DHCP',
        'DNS',
        'NAT',
        'VLAN',
        'Firewall',
        'Proxy',
        'Gateway',
        'sub-rede',
        'balanceamento de carga',
        'HTTPS',
        'VPN'
    ]
]

const termosRaros = [
    // programação
    [
        'currying',
        'memoization',
        'duck typing',
        'metaprogramação',
        'idempotência',
        'side effects',
        'lazy evaluation',
        'backpressure',
        'imutabilidade estrutural'
    ],
    // dados
    [
        'star schema',
        'data lineage',
        'sharding',
        'particionamento horizontal',
        'data vault',
        'tabelas heap',
        'HASH JOIN',
        'bitmap index',
    ],
    // infraestrutura
    [
        'BGP',
        'OSPF',
        'ARP spoofing',
        'STP',
        'QoS',
        'Reverse proxy',
        'split horizon',
        'route reflector',
        'VXLAN',
    ]
]

// retorna termo aleatório dentro de um tema
function escolheTermo(array, tema) {
    return array[tema][Math.floor(Math.random() * array.length)]
}

// retorna conteúdo aleatório p/ post
function gerarConteudo() {
    const tamanhoBase = faker.number.int({ min: 5, max: 20 }) // 5 a 20 termos por post
    const qtdTags = faker.number.int({ min: 1, max: 3 }) // 1 a 3 tags por post
    const t = Math.random()
    const palavras = []
    const tags = []
    let tema = 0

    // escolhe tema
    if (t < 0.3) {
        tema = 0
    } else if (t >= 0.3 && t < 0.6) {
        tema = 1
    } else {
        tema = 2
    }

    for (let i = 0; i < tamanhoBase; i++) { // monta array c/ termos escolhidos
        const p = Math.random()
        // escolhe raridade do termo
        if (p < 0.6) {
            palavras.push(escolheTermo(termosComuns, tema))
        } else if (p < 0.9) {
            palavras.push(escolheTermo(termosTecnicos, tema))
        } else {
            palavras.push(escolheTermo(termosRaros, tema))
        }
    }

    // monta array c/ tags escolhidas
    for (let i = 0; i < qtdTags; i++) {
        tags.push(escolheTermo(termosComuns, tema))
    }

    const post = montarPost(palavras)
    const tagsFormatadas = tags.map( tag => `#${tag}`).join(" ")
    const conteudo = [post, tagsFormatadas]
    return conteudo
}

function montarPost(palavras) { // monta post com lista de palavras escolhidas
    const c = faker.number.int({ min: 1, max: 5 }) // até 5 prompts de post possíveis
    let restantes = palavras.slice(4, palavras.length) // pega os últimos termos e separa por vírgula
    restantes = restantes.join(", ") + ".";
    let post = ""

    if (c == 1) {
        post = `Recentemente comecei a estudar sobre ${palavras[0]} e estou gostando muito! 
            Cada dia estou aprendendo mais sobre como funciona ${palavras[1]},${palavras[2]} e ${palavras[3]}. 
            Estou particularmente interessado em trabalhar com ${restantes}`
    } else if (c == 2) {
        post = `Você já trabalhou com ${palavras[0]}? Já pensou em entender como funciona ${palavras[1]} ou ${palavras[2]}? 
        Se você quiser saber como dominar tudo sobre ${palavras[3]}, me segue aí! Tenho um curso especializado sobre ${restantes}`
    } else if (c == 3) {
        post = `Acompanhando o mercado de tecnologia, descobri que ${palavras[0]} e ${palavras[1]} estão cada dia mais em alta 
        na internet. Quem aqui acha que o ano pode terminar com ${palavras[2]} e ${palavras[3]} no centro das atenções? Também gostaria de ouvir a 
        opinião de vocês sobre ${restantes}`
    } else if (c == 4) {
        let nome = faker.person.firstName()
        let companhia = faker.company.name()
        post = `Olá! Eu sou ${nome} e trabalho com ${palavras[0]} na ${companhia}. Estou procurando profissionais de nível técnico ou superior para trabalhar comigo em 
        um grande projeto. Se você tem experiência com ${palavras[1]}, ${palavras[2]} ou ${palavras[3]}. Também aceitamos quem souber mexer com ${restantes}`
    } else if (c == 5) {
        let start = faker.date.soon()
        let end = faker.date.soon({ refDate: start })
        let cidade = faker.location.city()
        let rua = faker.location.streetAddress()
        let num = faker.number.int({ min: 1, max: 1000 })
        post = `Atenção profissionais de ${palavras[0]}! Vocês estão convidados para participar de um evento especial sobre ${palavras[1]}, ${palavras[2]} e ${palavras[3]} 
        que ocorrerá de ${start} a ${end} no endereço ${rua}, ${num} em ${cidade}. Também serão tratados temas como ${restantes}`
    }

    return post;
}

// escrevendo query SQL
let sql = "INSERT INTO postagens (usuario_id,titulo,conteudo,tags,visualizacoes,status) VALUES\n";

for (let i = 0; i < totalRegistros; i++) {
    const conteudoFake = gerarConteudo()

    const postFake = conteudoFake[0].replace(/'/g,"")
    const tagFake = conteudoFake[1].replace(/'/g,"")

    const usuario_id = faker.number.int({ min: 1, max: 20 })
    const titulo = faker.company.catchPhrase().replace(/'/g,"")
    const conteudo = postFake
    const tags = tagFake
    const visualizacoes = faker.number.int({ min: 0, max: 5000 })
    const status = "ativo"

    sql += `(${usuario_id},'${titulo}','${conteudo}','${tags}',${visualizacoes},'${status}')`

    sql += i < totalRegistros - 1 ? ",\n" : ";\n"
    
}

fs.writeFileSync("inserts_postagens.sql", sql)

console.log("Arquivo inserts_postagens.sql gerado com sucesso!")





