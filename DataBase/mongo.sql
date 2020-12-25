//  Manual: https://docs.mongodb.com/manual

/*************************************  CREATE COLLECTION   */
/*  SQL: Seria necessário realizar um CREATE TABLE  passsando os parametros e tipo de dados  */
db.createCollection("alunos");

/*************************************  INSERT COLLECTION   */
/*  SQL: Seria necessário realizar o CREATE TABLE de tabela de ALUNO,CURSO,HABILIDADE,NOTAS e Realizar o insert em todas conforme os Id's  */
db.alunos.insert(
    {
    "nome" : "Rui Barbosa",
    "data_nascimento" : new Date("1997-08-08"),
    "curso" : {
        "nome" : "Engenharia de Software"
    },
    "notas" : [10.0 , 9.0 , 8.5],
    "habilidades" : [
        {
        "nome" : "inglês",
        "nivel" : "intermediario"
        },
        {
        "nome" : "mongodb",
        "nivel" : "basico"
        }
    ]
    }
);

db.alunos.insert(
    {
        "nome" : "Daniela",
        "data_nascimento" : new Date("1996-05-18T16:00:00Z"),
        "curso" : {
            "nome" : "Medicina"
        },
        "habilidades" : [
            {
                "nome" : "inglês",
                "nivel" : "avancado"
            }
        ]
    }
);


db.alunos.insert(
    {
        "nome" : "Fernando",
        "data_nascimento" : new Date("1994-03-12T00:00:00Z"),
        "notas": [10.0, 4.5, 7],
        "curso" : {
            "nome" : "Sistemas da informacao"
        },
    }
);

/*************************************  SELECT COLLECTION   */
/*  Realizando consulta geral   */
/*  SQL: Seria necessário realizar um SELECT * FROM  */
db.alunos.find();

/*  Realizando consulta filtrando por nome do aluno   */
/*  SQL: Seria necessário realizar um SELECT * FROM WHERE NOME = "RUI BARBOSA" com joins nas tabelas */
db.alunos.find(
    {
        nome:"Rui Barbosa"
    }
);

/*  Realizando consulta filtrando por habilidade em ingles   */
db.alunos.find(
    {
        "habilidades.nome":"inglês"
    }
);

/*  Realizando consulta filtrando por nome e habilidade em ingles   */
db.alunos.find(
    {
        "nome": "Rui Barbosa",
        "habilidades.nome":"inglês"
    }
);

/*  Realizando consulta filtrando com clausula de OR   */
db.alunos.find({
    $or : [
        {"curso.nome" : "Medicina"},
        {"curso.nome" : "Engenharia de Software"}
    ]}
);

/*  Realizando consulta filtrando com clausula de OR & AND  */
db.alunos.find({
    $or : [
        {"curso.nome" : "Medicina"},
        {"curso.nome" : "Engenharia de Software"}
    ],
        "nome" : "Daniela"
    }
);
/*  Realizando consulta filtrando com clausula de OR & AND  */
db.alunos.find({
    "curso.nome" : { $in : ["Medicina",
                            "Engenharia de Software"]}
});

/*  Realizando consulta filtrando > 8.5  */
db.alunos.find({
    "notas" : {$gt : 8.5}
});

/*  Realizando consulta TOP 1 filtrando > 8.5  */
db.alunos.findOne({
    "notas" : {$gt : 8.5}
});

/*  Realizando consulta TOP 1 filtrando < 8.5  */
db.alunos.find({"notas":{$lt:8.5}});

/*  Realizando consulta order by asc ou desc  */
db.alunos.find().sort({"nome" : 1});
db.alunos.find().sort({"nome" : -1});

/*  Realizando consulta ordenado e limitado em apenas 1  */
db.alunos.find().sort({"nome" : 1}).limit(1);


/*************************************  UPDATE COLLECTION  */
/*  SQL: Seria necessário realizar um UPDATE SET NOME = "Sistemas da Informacao" WHERE NOME = "Sistemas da informacao"  */
db.alunos.update(
    {"curso.nome" : "Sistemas da informacao"},
    {
        $set : {
            "curso.nome" : "Sistemas da Informacao"
        }
    }
);

db.alunos.update(
    {"_id" : ObjectId("5fe51507ca5ac03ebc8519bb")},
    {
        $push : {
            "notas" : "8.5"
        }
    }
);

/*  SQL: Seria necessário realizar um DELETE FROM passando o Id */
db.alunos.remove({
    "_id" : ObjectId("5fe5152cca5ac03ebc8519bd")
})





/*************************************  FIND LAT LONG   */
db.alunos.update(
    {"nome" : "Rui Barbosa"},
    {
        $set : {
        localizacao : {
            "endereco" : "Rua Vergueiro, 3185",
            "cidade" : "São Paulo",
            "coordinates" : [-23.858213,-46.622356],
            "type" : "Point"
        }
      }
    }
);
db.alunos.update(
    {"nome" : "Daniela"},
    {
        $set : {
            localizacao : {
            "endereco" : "Rua Vergueiro, 3244",
            "cidade" : "São Paulo",
            "coordinates" : [-28.469080,-52.205059],
            "type" : "Point"
            }
        }
    }
);
db.alunos.update(
    {"nome" : "Fernando"},
    {
        $set : {
            localizacao : {
            "endereco" : "Avenida Paulista",
            "cidade" : "São Paulo",
            "coordinates" : [-23.563210,-46.654251],
            "type" : "Point"
            }
        }
    }
);

db.alunos.createIndex({
    localizacao : "2dsphere"
});

db.alunos.aggregate([
{
    $geoNear : {
        near : {
            coordinates: [-23.5640265, -46.6527128],
            type : "Point"
        },
        distanceField : "distancia.calculada",
        spherical : true
    }
},
{ $skip :1 }
])