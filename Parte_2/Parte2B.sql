/*
Detectar anomalias na base de dados: campos com dados suspeitos (isto é, que
nitidamente estão errados: uma data de nascimento em 1800, um nome preenchido
somente com números, etc), dados faltantes, etc;
*/

SELECT * FROM vacinacaocovid.paciente;
SELECT * FROM vacinacaocovid.vacina;
SELECT * FROM vacinacaocovid.estabelecimento;

/*Verificar datas inconsitentes*/
-- Uma pessoa nascida em 1901 teria 120 anos de idade.
SELECT * FROM vacinacaocovid.paciente WHERE paciente_datanascimento < '1901-01-01';
-- Com o comando abaixo verificamos a pessoa com maior idade.
SELECT MIN(paciente_datanascimento) FROM vacinacaocovid.paciente;
-- Com o comando abaixo verificamos a pessoa com menor idade.
SELECT MAX(paciente_datanascimento) FROM vacinacaocovid.paciente;

/*um nome preenchido com números, */
-- Usando expressoes regulares para verificar erros em nomes
SELECT * FROM vacinacaocovid.vacina WHERE vacina_fabricante_nome REGEXP '[0-9].+';

/* Dados faltantes*/
-- Nao ha dados null ou ' ' na tabela estabelecimento.
SELECT * FROM vacinacaocovid.estabelecimento WHERE estabelecimento_uf IS NULL OR estabelecimento_uf = ' ';
-- Selecionando os dados com paciente_endereco_cep faltando.
SELECT * FROM vacinacaocovid.paciente WHERE paciente_endereco_cep IS NULL OR paciente_endereco_cep = ' ';
-- Verificando a quantidade de dados faltando na coluna paciente_endereco_cep.
SELECT COUNT(*) FROM vacinacaocovid.paciente WHERE paciente_endereco_cep IS NULL OR paciente_endereco_cep = ' ';
-- A coluna id_sistema_origem nao possui nenhuma linha com valor.
SELECT * FROM vacinacaocovid.vacina WHERE id_sistema_origem != ' ';

/*Analisando os valores distintos*/
SELECT distinct paciente_endereco_nmmunicipio FROM vacinacaocovid.paciente;

/*AS ANOMALIAS DETECTADAS EM 20/06/2021 SAO: dados com paciente_endereco_cep faltando e coluna id_sistema_origem nao possui nenhuma linha com valor. */