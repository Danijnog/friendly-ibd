Trabalho Prático 2

Introdução a Banco de Dados

Daniel Nogueira Junqueira - 2021072244
Lucas Lourenço Reis Resende - 2021014767
Rafael Camacho F. T de Oliveira - 2020030106


































Introdução e Objetivos

O seguinte trabalho tem como objetivo trabalhar com os dados recuperados do governo relacionado a crimes violentos fazendo correlação com os indicativos de educação nos municípios de Minas Gerais.

Objetivos

	O objetivo deste trabalho consiste em encontrar relações diretas ou indiretas entre índices de educação e de crimes a partir da análise e correlação dos dados do Censo Escolar e de Crimes Violentos dos municípios de Minas Gerais.

	Com relação a isso, a principal hipótese levantada pelo grupo é a da existência de uma relação inversa entre os indicadores, ou seja, municípios com resultados relativamente piores nos dados de educação tendem a ter um número maior de crimes, partindo do pressuposto de que manter uma pessoa nas escolas reduz a chance dela cometer delitos.
Para realizar a análise, buscamos dados do INPE, do portal de dados abertos do Governo Federal e do IBGE, que estão citados a seguir.

Crimes Violentos:  https://dados.gov.br/dados/conjuntos-dados/crimes-violentos
Censo Escolar 2022: 
https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/censo-escolar/resultados
População Municipal: https://www.ibge.gov.br/estatisticas/sociais/populacao/9103-estimativas-de-populacao.html

A tabela abaixo apresenta os metadados sobre os dados obtidos, contendo informações sobre a obtenção destes e informações de cobertura.

Metadados dos conjuntos analisados

Manipulação dos dados

Os dados obtidos foram inseridos em um SGBD, mais específico no PostgreSQL de acordo com o esquema relacional obtido através da análise exploratória, após a filtragem e elaboração do modelo relacional, como apresentado no próximo tópico.

Análise exploratória

	Buscando um melhor aproveitamento dos dados, primeiramente, foi realizada uma filtragem para eliminar indicadores que seriam de pouca relevância para a análise e proposta do trabalho. Mais especificamente, foram removidos indicadores do censo escolar, que continha muitas colunas e campos que não eram interessantes trabalharmos ou não ia fazer diferença na análise que estávamos fazendo. Mesmo realizando essa limpeza em certas colunas nos dados de censo escolar, o conteúdo dos dados ainda ficou bem grande devido a vários aspectos da educação que o arquivo aborda.

No link abaixo estão os dados já tratados.
https://drive.google.com/drive/folders/1MOWbzztH9BlRBuBzar6vdqc4TEyqbSm_?usp=drive_link

Modelo Relacional

Para permitir a importação e análise dos dados foi elaborado um modelo relacional que representa o conjunto obtido após a filtragem e adaptação para possibilitar o carregamento para o SGBD. A imagem abaixo apresenta esse diagrama.


Modelo relacional para o conjunto de dados

Dicionário de Dados

	Buscando possibilitar o entendimento do significado das variáveis e indicadores utilizados foi elaborado um dicionário de dados para os conjuntos de dados utilizados a partir das informações disponibilizadas pelas fontes dos dados. As tabelas a seguir apresentam o nome das variáveis, uma breve descrição, seu tipo e se se trata de uma chave primária ou estrangeira.


Dicionário de dados para a tabela “Escola”


Dicionário de dados para a tabela “Crime”


Dicionário de dados para a tabela “Municipio_Crimes”


Dicionário de dados para a tabela “Municipio_Populacao”
Análise Descritiva e de Correlação

A análise de correlação foi pautada no número de registros de crimes de um município e a quantidade de pessoas matriculadas em institutos de educação de cada município. Porém, após plotar os dois dados em gráficos analisá-los foi possível perceber que municípios com maior número de matrículas não necessariamente teriam maior índice de escolaridade uma vez que não a população de cada área não estava sendo considerada. Logo, foi necessário a adição de uma tabela com a população de cada município em nosso banco de dados.

Em seguida, após as alterações necessárias no modelo, foi dado seguimento à análise de correlação entre a quantidade de registros de crimes e a quantidade de matrículas por população total de cada município. Para a análise foram gerados gráficos de proporção de pessoas matriculadas pela população total x número de registros de crimes, em cada município.

	Para melhorar a visualização foram plotados apenas os dados referentes aos municípios com população menor que 50.000 e apesar de inicialmente apresentar um resultado de acordo com o proposto ao mostrar um maior número de registros nas cidades com menor índice de escolaridade, o restante do gráfico deixa claro como os dados do banco de dados apresentam inconsistências com diversos municípios com nenhum registro de crime, principalmente em cidades menores como essas com menor população em que a disseminação desses dados acontece de forma mais precária.

Em uma análise mais focada foram selecionadas 5 cidades com número expressivo de registros para facilitar a comparação. No primeiro gráfico é possível perceber a curva descendente de registros enquanto no segundo foram removidos os registros de crimes para perceber o aumento na escolaridade quase que na mesma proporção do decaimento dos delitos.


Conclusão

	Para realização deste trabalho foram necessárias diversas decisões tomadas pelo grupo para enfrentar uma série de dificuldades que nos foram apresentadas durante todo o seu decorrer, visando a criação de um banco de dados relacional o mais estável e íntegro possível para fazer cruzamentos de dados e análise dos mesmos. Desde a preparação dos dados considerando a normalização do banco até a consideração de uma tabela populacional para uma análise de correlação mais precisa e otimizada.

	O resultado esperado inicialmente seria que o número de crimes de um município seria menor de acordo o número de pessoas matriculadas por população do município aumentasse, criando assim uma relação inversa entre um indicativo educacional e a criminalidade de uma região. Os resultados finais da análise de nossos dados se mostraram incapazes de gerar uma relação entre os dados com precisão, uma vez que vários dados apresentavam registros duvidosos como o número de crimes em diversos municípios igual a 0 e partes das tabelas em branco. Apesar dessa variação dos dados, foi possível observar uma relação entre o índice de educação e a criminalidade dos municípios em alguns dados do banco como demonstrado nos últimos gráficos.

