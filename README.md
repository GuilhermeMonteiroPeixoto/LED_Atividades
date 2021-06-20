# LED_Atividades

## TAREFAS DA SELEÇÃO DE NOVOS ALUNOS

Disposições gerais: o aluno não é obrigado a completar todas as atividades listadas, mas a quantidade será avaliada. O código também será avaliado, isto é, a organização, a lógica
por trás dos algoritmos implementados, etc. Não há obrigatoriedade do uso de uma linguagem de programação específica, apesar de recomendarmos o uso da linguagem Python.

### Parte 1:
Faça o download da base de dados ‘us-500.csv’ do link https://www.briandunning.com/sample-data/
* Cheque se há algum dado faltante na base de dados ‘us-500’;
* Classifique os endereços por ‘state’;
* Suponha que o zip code deve sempre ter 5 dígitos, ache todos os zip codes
irregulares;
* Separe a coluna ‘address’ em três partes: o número na rua, o nome da rua e o
número de quartos. (Considere que pode haver partes faltantes)
Ex. 8 W Cerritos Ave #54 → ‘8’, ‘W Cerritos Ave’, ‘ #54’
6649 N Blue Gum St → ‘6649’, ‘N Blue Gum St’, ‘ ‘.

### Parte 2:
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
* Disponibilizar o dump da base através de link.

### Parte 3:
Baixe as seguintes bases de dados sobre a vacinação em Alagoas, link1 e link2 (link2 disponível a partir das 12:00 do dia 19/06/2021). As bases são de dias diferentes,
sendo a primeira mais antiga e a segunda mais recente. Nesta parte, sua tarefa é comparar
as duas bases de dados no tempo: 
* Tentar fazer o match dos registros iguais;
* Detectar registros com dados que foram alterados, registros novos, registros excluídos, etc.
Faça uma exploração temporal da evolução das bases.
