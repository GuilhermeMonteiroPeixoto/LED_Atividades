# PARTE 2

Baixe a base de dados sobre a vacinação em Alagoas no site https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao/resource/ef3bd0b8-b605-474b-9ae5-c97390c197a8 e desenvolva os seguintes itens:
* Modelar um banco de dados relacional (MySQL ou Postgres) para a base referida:
documentar o banco e implementá-la;
* Detectar anomalias na base de dados: campos com dados suspeitos (isto é, que
nitidamente estão errados: uma data de nascimento em 1800, um nome preenchido
somente com números, etc), dados faltantes, etc;
* Discutir quão seguro estão os dados pessoais dos vacinados. Você pode utilizar o
que quiser. Tentar identificar algum ponto fraco na anonimização dos dados,
inconsistências com a LGPD, etc. Faça uma discussão dos dados nesse sentido;
* Exportar a base de dados (dump);
* Disponibilizar o código no GitHub ou GitLab ou Bitbucket;
* Disponibilizar o dump da base através de link. (https://github.com/GuilhermeMonteiroPeixoto/LED_Atividades/blob/main/Parte_2/Self-ContainedFile_Dump_Structure_and_Data.sql)
________________________________

### Modelagem banco de dados relacional (MySQL)
Essa modelagem não é a mais apropriada. O ideal seria separarmos a tabela vacina, paciente e estabelecimento ainda mais.

![matrix](https://github.com/GuilhermeMonteiroPeixoto/LED_Atividades/blob/main/Parte_2/DiagramDB.png)

________________________________

A tabela `estabelecimento` contêm os dados relacionados ao local de vacinação.
```
CREATE TABLE IF NOT EXISTS `vacinacaocovid`.`estabelecimento` (
  `estabelecimento_valor` INT(11) NOT NULL,
  `estabelecimento_razaosocial` VARCHAR(70) NULL DEFAULT NULL,
  `estalecimento_nofantasia` VARCHAR(70) NULL DEFAULT NULL,
  `estabelecimento_municipio_codigo` INT(11) NULL DEFAULT NULL,
  `estabelecimento_municipio_nome` VARCHAR(70) NULL DEFAULT NULL,
  `estabelecimento_uf` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`estabelecimento_valor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;
```

A tabela `paciente` contêm todas as informações do paciente (Incluindo endereço).
```
CREATE TABLE IF NOT EXISTS `vacinacaocovid`.`paciente` (
  `document_id` VARCHAR(70) NOT NULL COMMENT 'Comentario document_id',
  `paciente_id` VARCHAR(80) NOT NULL COMMENT 'Comentario paciente_id',
  `paciente_idade` TINYINT(3) NULL DEFAULT NULL COMMENT 'Comentario paciente_idade',
  `paciente_datanascimento` DATE NOT NULL COMMENT 'Comentario paciente_nascimento',
  `paciente_enumsexobiologico` VARCHAR(2) NULL DEFAULT NULL,
  `paciente_racacor_codigo` TINYINT(2) NULL DEFAULT NULL,
  `paciente_racacor_valor` VARCHAR(30) NULL DEFAULT NULL,
  `paciente_endereco_coibgemunicipio` INT(11) NULL DEFAULT NULL,
  `paciente_endereco_copais` TINYINT(4) NULL DEFAULT NULL COMMENT 'Comentario paciente_endereco_copais',
  `paciente_endereco_nmmunicipio` VARCHAR(45) NULL DEFAULT NULL,
  `paciente_endereco_nmpais` VARCHAR(45) NULL DEFAULT NULL,
  `paciente_endereco_uf` VARCHAR(30) NULL DEFAULT NULL,
  `paciente_endereco_cep` VARCHAR(30) NULL DEFAULT NULL,
  `paciente_nacionalidade_enumnacionalidade` VARCHAR(30) NULL DEFAULT NULL,
  `estabelecimento_estabelecimento_valor` INT(11) NOT NULL,
  PRIMARY KEY (`document_id`),
  CONSTRAINT `fk_paciente_estabelecimento1`
    FOREIGN KEY (`estabelecimento_estabelecimento_valor`)
    REFERENCES `vacinacaocovid`.`estabelecimento` (`estabelecimento_valor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;
```

A tabela `vacina` contêm informações sobre a vacinação e sobre a vacina.
```
CREATE TABLE IF NOT EXISTS `vacinacaocovid`.`vacina` (
  `id_sistema_origem` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_grupoatendimento_codigo` INT(11) NULL DEFAULT NULL,
  `vacina_grupoatendimento_nome` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_categoria_codigo` TINYINT(3) NULL DEFAULT NULL,
  `vacina_categoria_nome` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_lote` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_fabricante_nome` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_fabricante_referencia` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_dataaplicacao` DATE NULL DEFAULT NULL,
  `vacina_descricao_dose` VARCHAR(45) NULL DEFAULT NULL,
  `vacina_codigo` INT(11) NULL DEFAULT NULL,
  `vacina_nome` VARCHAR(45) NULL DEFAULT NULL,
  `sistema_origem` VARCHAR(45) NULL DEFAULT NULL,
  `data_importacao_rnds` VARCHAR(45) NULL DEFAULT NULL,
  `idvacina` INT(11) NOT NULL AUTO_INCREMENT,
  `paciente_document_id` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`idvacina`),
  CONSTRAINT `fk_vacina_paciente1`
    FOREIGN KEY (`paciente_document_id`)
    REFERENCES `vacinacaocovid`.`paciente` (`document_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;
```
_______________________________

### Detectar anomalias na base de dados

#### Verificar datas inconsitentes
Uma pessoa nascida em 1901 teria 120 anos de idade. Por isso, seria inconsistente encontrar uma data de nascimento menor que 1901.

```SELECT * FROM vacinacaocovid.paciente WHERE paciente_datanascimento < '1901-01-01';```

Com o comando abaixo verificamos a pessoa com maior idade.

```SELECT MIN(paciente_datanascimento) FROM vacinacaocovid.paciente;```

Com o comando abaixo verificamos a pessoa com menor idade

```SELECT MAX(paciente_datanascimento) FROM vacinacaocovid.paciente;```

#### Procurando nome preenchido com números
Podemos usar `SELECT` e expressões regulares para verificar erros em nomes

```SELECT * FROM vacinacaocovid.vacina WHERE vacina_fabricante_nome REGEXP '[0-9].+';```

#### Dados faltantes
Nao ha dados null ou ' ' na tabela estabelecimento. Podemos procurar dados faltantes usando o seguinte comando:

```SELECT * FROM vacinacaocovid.estabelecimento WHERE estabelecimento_uf IS NULL OR estabelecimento_uf = ' ';```

Selecionando os dados com paciente_endereco_cep faltando.

```SELECT * FROM vacinacaocovid.paciente WHERE paciente_endereco_cep IS NULL OR paciente_endereco_cep = ' ';```

Verificando a quantidade de dados faltando na coluna paciente_endereco_cep.

```SELECT COUNT(*) FROM vacinacaocovid.paciente WHERE paciente_endereco_cep IS NULL OR paciente_endereco_cep = ' ';```

A coluna id_sistema_origem nao possui nenhuma linha com valor.

```SELECT * FROM vacinacaocovid.vacina WHERE id_sistema_origem != ' ';```

#### Analisando os valores distintos
Outra forma de analisar as tabelas, é identificando valores distintos.

```SELECT distinct paciente_endereco_nmmunicipio FROM vacinacaocovid.paciente;```

ANOMALIAS DETECTADAS EM 20/06/2021: dados com paciente_endereco_cep faltando e coluna id_sistema_origem nao possui nenhuma linha com valor.
_______________________________

### Discussão Segurança dos dados

```A Lei Geral de Proteção de Dados Pessoais cita o dado anonimizado, que é aquele que, originariamente, era relativo a uma pessoa, mas que passou por etapas que garantiram a desvinculação dele a essa pessoa. Se um dado for anonimizado, então a LGPD não se aplicará a ele. Vale frisar que um dado só é considerado efetivamente anonimizado se não permitir que, via meios técnicos e outros, se reconstrua o caminho para "descobrir" quem era a pessoa titular do dado - se de alguma forma a identificação ocorrer, então ele não é, de fato, um dado anonimizado e sim, apenas, um dado pseudonimizado e estará, então, sujeito à LGPD.```

A identificação direta do paciente nos dados disponibilizados, está criptografada. Podemos ver isso na tabela paciente, coluna `paciente_id` e `documento_id`. Entretanto, a proteção a alguns dados sensíveis como endereço não está sendo feita. Um exemplo disso é que podemos encontrar alguns indivíduos presentes no banco de dados:

- Indivíduo: ?
- Idade: 98
- Sexo: Masculino
- Raça/Cor: Branca
- Município: Piaçabuçu
- CEP: 57210
- Nacionalidade: Extrangeiro

Visto que a cidade de Piaçabuçu possui 17848 pessoas, fica fácil encontrar alguem com essas características. O que mostra um ponto 
fraco na anonimização dos dados.
