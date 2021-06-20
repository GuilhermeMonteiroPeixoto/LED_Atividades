#!/usr/bin/env python
# coding: utf-8

# # PARTE 1

# Download da base de dados ‘us-500.csv’ do link https://www.briandunning.com/sample-data/

# #### Instalando biblioteca missingno

# 'missingno' fornece um pequeno conjunto de ferramentas de visualizações e utilitários de dados perdidos flexíveis e fáceis de usar que permite obter um rápido resumo visual da integridade (ou falta dela) do seu conjunto de dados.

get_ipython().system('pip install missingno')


# #### Importando bibliotecas que serão utilizadas

import pandas as pd
import missingno as msno

# #### Carregando dataset


df = pd.read_csv("us-500.csv")


# #### Visualizando dataset

print(df)


# ### A. Cheque se há algum dado faltante na base de dados ‘us-500’;

# A matriz de nulidade `msno.matrix` é uma exibição densa de dados que permite selecionar visualmente os dados faltantes.

msno.matrix(df)


# Com esse gráfico, podemos identificar que nossa base de dados possui 500 linhas, 12 colunas e nenhum dado faltando.
# Os dados faltantes apareceriam em branco (Exemplo: https://github.com/GuilhermeMonteiroPeixoto/Data-Analysis-and-Visualization/tree/master/Python-libraries/UseMissingno).

# O comando `msno.bar` mostra outra maneira de mostrar dados faltantes usando gráfico de barras. Essas barras mostram valores que são proporcionais aos dados ausentes e não ausentes no conjunto de dados.


msno.bar(df)


# Assim, podemos afirmar que não há dados faltantes na nossa base de dados.

# ## B. Classifique os endereços por ‘state’;

# Use a função `groupby()` para formar grupos com base em uma ou mais categorias


df_groupbystate = df.groupby(['state', 'address'])

df_groupbystate.first()


# Agora podemos visualizar os endereços classificados por estado.

# Outra opção viável é organizar a tabela por ordem alfabetica da coluna 'state'. 


df.sort_values(by='state',inplace=True)
print(df)


# ## C. Suponha que o zip code deve sempre ter 5 dígitos, ache todos os zip codes irregulares;

# Podemos usar a função `loc` para selecionarmos apenas as linhas com zip codes irregulares, usando `df['zip'].astype(str).str.len() != 5` como argumento.


df.loc[(df['zip'].astype(str).str.len() != 5)]


# Assumindo que você prefira retirar as linhas com zip codes irregulares, use a função `drop` e passe `df.loc[(df['zip'].astype(str).str.len() != 5)]` como argumento.


df.drop(df.loc[(df['zip'].astype(str).str.len() != 5)].index, inplace = True)


# ## D. Separe a coluna ‘address’ em três partes: o número na rua, o nome da rua e o número de quartos. (Considere que pode haver partes faltantes)

# O jeito mais elegante para se fazer isso, é usando expressões regulares.

# Então, primeiro vamos criar novas colunas que receberão `df.address.str.extract('ER', expand = True)`


df['numero_rua'] = df.address.str.extract('(\d+ )', expand = True)
df['nome_rua'] = df.address.str.extract(r'([a-zA-Z].+[a-zA-Z])', expand = True)
df['numero_quartos'] = df.address.str.extract(r'(#.+)$', expand = True)


# Em seguinda, retiramos a coluna address usando `drop`


df.drop('address', axis=1, inplace=True)


# #### Visualizando o novo dataset

print(df)
