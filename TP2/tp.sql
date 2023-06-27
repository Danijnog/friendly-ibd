-- Dados que utilizamos para popular a tabela municipio_crimes e crime: https://dados.gov.br/dados/conjuntos-dados/crimes-violentos

CREATE TABLE municipio_crimes (
	id_municipio SERIAL PRIMARY KEY,
	cod_municipio int,
	municipio varchar(50),
	risp int,
	rmbh varchar(10)
);

CREATE TABLE crime (
	id_municipio int,
	natureza varchar(50),
	FOREIGN KEY (id_municipio) REFERENCES municipio_crimes(id_municipio),
	registros int,
	mes int,
	ano int
);

CREATE TABLE escola (
	id_municipio int,
	FOREIGN KEY(id_municipio) REFERENCES municipio_crimes(id_municipio),
	co_entidade int,
	no_entidade varchar(100),
	co_distrito int,
	no_municipio varchar(100),
	co_municipio int,
	qt_mat_bas int,
	qt_mat_inf int,
	qt_mat_fund int,
	qt_mat_fund_ai int,
	qt_mat_fund_af int,
	qt_mat_med int,
	qt_mat_prof int,
	qt_mat_prof_tec int,
	qt_mat_eja int,
	qt_mat_eja_fund int,
	qt_mat_eja_med int,
	qt_mat_bas_0_3 int,
	qt_mat_bas_4_5 int,
	qt_mat_bas_6_10 int,
	qt_mat_bas_11_14 int,
	qt_mat_bas_15_17 int,
	qt_mat_bas_18_mais int
);

CREATE TABLE municipio_populacao (
	id_pop SERIAL PRIMARY KEY,
	id_municipio SERIAL,
	FOREIGN KEY(id_municipio) REFERENCES municipio_crimes(id_municipio),
	cod_municipio int,
	nome_municipio varchar(100),
	populacao int
);

-- Inserindo as informações na tabela municipio_populacao
COPY municipio_populacao(cod_municipio, nome_municipio, populacao)
FROM 'C:\Users\danie\Dropbox\PC\Downloads\POP2021_20221212 (2).csv'
DELIMITER ';' CSV HEADER;

-- Tabela temporária criada com o intuito de facilitar a inserção de dados da educação básica
CREATE TEMPORARY TABLE temp_table (
	id_municipio SERIAL,
	no_municipio varchar(100),
	co_municipio int,
	co_distrito int,
	no_entidade varchar(100),
	co_entidade int,
	qt_mat_bas int,
	qt_mat_inf int,
	qt_mat_fund int,
	qt_mat_fund_ai int,
	qt_mat_fund_af int,
	qt_mat_med int,
	qt_mat_prof int,
	qt_mat_prof_tec int,
	qt_mat_eja int,
	qt_mat_eja_fund int,
	qt_mat_eja_med int,
	qt_mat_bas_0_3 int,
	qt_mat_bas_4_5 int,
	qt_mat_bas_6_10 int,
	qt_mat_bas_11_14 int,
	qt_mat_bas_15_17 int,
	qt_mat_bas_18_mais int
);

COPY temp_table(no_municipio, co_municipio, co_distrito, no_entidade, co_entidade,
			   qt_mat_bas, qt_mat_inf, qt_mat_fund, qt_mat_fund_ai, qt_mat_fund_af, qt_mat_med,
			   qt_mat_prof, qt_mat_prof_tec, qt_mat_eja, qt_mat_eja_fund, qt_mat_eja_med, qt_mat_bas_0_3,
			   qt_mat_bas_4_5, qt_mat_bas_6_10, qt_mat_bas_11_14, qt_mat_bas_15_17, qt_mat_bas_18_mais)
FROM 'C:\Users\danie\Dropbox\PC\Downloads\microdados_ed_basica_2022.csv'
DELIMITER ',' CSV HEADER;

INSERT INTO escola(id_municipio, 
	co_entidade,
	no_entidade,
	co_distrito,
	no_municipio,
	co_municipio,
	qt_mat_bas,
	qt_mat_inf,
	qt_mat_fund,
	qt_mat_fund_ai,
	qt_mat_fund_af,
	qt_mat_med,
	qt_mat_prof,
	qt_mat_prof_tec,
	qt_mat_eja,
	qt_mat_eja_fund,
	qt_mat_eja_med,
	qt_mat_bas_0_3,
	qt_mat_bas_4_5,
	qt_mat_bas_6_10,
	qt_mat_bas_11_14,
	qt_mat_bas_15_17,
	qt_mat_bas_18_mais)

SELECT id_municipio, 
	co_entidade,
	no_entidade,
	co_distrito,
	no_municipio,
	co_municipio,
	qt_mat_bas,
	qt_mat_inf,
	qt_mat_fund,
	qt_mat_fund_ai,
	qt_mat_fund_af,
	qt_mat_med,
	qt_mat_prof,
	qt_mat_prof_tec,
	qt_mat_eja,
	qt_mat_eja_fund,
	qt_mat_eja_med,
	qt_mat_bas_0_3,
	qt_mat_bas_4_5,
	qt_mat_bas_6_10,
	qt_mat_bas_11_14,
	qt_mat_bas_15_17,
	qt_mat_bas_18_mais
FROM temp_table;

-- Comando principal que analisamos os dados obtidos das tabelas de população, dados de escolaridade e crimes, fazendo correlação entre eles.
SELECT no_municipio, populacao,
    (SUM(qt_mat_bas) + SUM(qt_mat_inf) + SUM(qt_mat_fund) + SUM(qt_mat_fund_ai) + SUM(qt_mat_fund_af) + 
    SUM(qt_mat_med) + SUM(qt_mat_prof) + SUM(qt_mat_prof_tec) + SUM(qt_mat_eja) + SUM(qt_mat_eja_fund) + 
    SUM(qt_mat_eja_med) + SUM(qt_mat_bas_0_3) + SUM(qt_mat_bas_4_5) + SUM(qt_mat_bas_6_10) + SUM(qt_mat_bas_11_14) + 
    SUM(qt_mat_bas_15_17) + SUM(qt_mat_bas_18_mais))::float / populacao AS proporcao_matricula_populacao,
	
	SUM(qt_mat_bas) + SUM(qt_mat_inf) + SUM(qt_mat_fund) + SUM(qt_mat_fund_ai) + SUM(qt_mat_fund_af) + 
    SUM(qt_mat_med) + SUM(qt_mat_prof) + SUM(qt_mat_prof_tec) + SUM(qt_mat_eja) + SUM(qt_mat_eja_fund) + 
    SUM(qt_mat_eja_med) + SUM(qt_mat_bas_0_3) + SUM(qt_mat_bas_4_5) + SUM(qt_mat_bas_6_10) + SUM(qt_mat_bas_11_14) + 
    SUM(qt_mat_bas_15_17) + SUM(qt_mat_bas_18_mais) AS total_matriculas,
	
	SUM(registros) AS total_registros
FROM 
	escola
JOIN 
	municipio_crimes
ON 
	municipio_crimes.id_municipio = escola.id_municipio
JOIN 
	crime
ON 
	escola.id_municipio = crime.id_municipio
JOIN 
	municipio_populacao
ON 
	crime.id_municipio = municipio_populacao.id_municipio
WHERE
	municipio_populacao.populacao > 100000
GROUP BY 
	no_municipio, populacao
HAVING 
	   SUM(qt_mat_bas) + SUM(qt_mat_inf) + SUM(qt_mat_fund) + SUM(qt_mat_fund_ai) + SUM(qt_mat_fund_af) + 
       SUM(qt_mat_med) + SUM(qt_mat_prof) + SUM(qt_mat_prof_tec) + SUM(qt_mat_eja) + SUM(qt_mat_eja_fund) + 
       SUM(qt_mat_eja_med) + SUM(qt_mat_bas_0_3) + SUM(qt_mat_bas_4_5) + SUM(qt_mat_bas_6_10) + SUM(qt_mat_bas_11_14) + 
       SUM(qt_mat_bas_15_17) + SUM(qt_mat_bas_18_mais) IS NOT NULL
	   
AND SUM(registros) <> 0
ORDER BY total_registros DESC;



