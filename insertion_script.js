import faker from '@faker-js/faker'
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

// escolhe termo aleatório dentro de um tema
function escolheTermo(array, tema){
    return array[tema][Math.floor(Math.random() * array.length)] // retorna elemento aleatório
}





