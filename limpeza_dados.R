usethis::use_github()

fs
getwd()

dados <- read.csv('C:/Users/User/Desktop/Gustavo/Unicamp/Dados_carto/dados_diabetes_cardio.csv')

#Para Cardiopatias
dplyr::select(df,
              nome_munic,
              codigo_ibge,
              idade,
              cs_sexo,
              diagnostico_covid19,
              obito,
              cardiopatia,
              data_inicio_sintomas) |>  #selecionar para cardiopatia
  filter(!(cardiopatia=='IGNORADO' | cs_sexo=='IGNORADO')) |>
  filter(obito==1, cardiopatia=='SIM', diagnostico_covid19=='CONFIRMADO')|>
  group_by(codigo_ibge)|>
  summarise(mean(idade)) |>
  rename(idade_media = 'mean(idade)')

#Para Diabetes
dplyr::select(df,
              nome_munic,
              codigo_ibge,
              idade,
              cs_sexo,
              diagnostico_covid19,
              obito,
              diabetes,
              data_inicio_sintomas) |>  filter(!(diabetes=='IGNORADO' | cs_sexo=='IGNORADO')) |>
  filter(obito==1, diabetes=='SIM', diagnostico_covid19=='CONFIRMADO') |>
  group_by(codigo_ibge)|>
  summarise(mean(idade)) |>
  rename(idade_media_diabetes = 'mean(idade)')

dplyr::left_join(
  mun_sp,
  dados,
  by='codigo_ibge')
