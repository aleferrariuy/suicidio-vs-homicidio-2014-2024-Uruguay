library(readxl)     # leer archivos xl
library(ggplot2)    # buenas graficas
library(dplyr)      # preprosesamiento de datos

# datos archivo a leer
nombre_archivo <- "suicidios_homicidios_uy.xlsx"
nombre_hoja <- "sui_hom"
# acceso a dataset
datos_sh <- read_excel(
  path = nombre_archivo,   
  sheet = nombre_hoja)

datos_con_comparacion <- datos_sh %>%
  mutate(
    suicidio_mayor_por = sui_tasa_100m / hom_rasa_100m
  )

# grafica a crear
grafico_razon <- ggplot(
  data = datos_con_comparacion,
  aes(
    x = anio_def,           
    y = suicidio_mayor_por  
  )
) +
  geom_hline( # línea de referencia crucial en Y=1
    yintercept = 1,
    linetype = "dashed",  
    color = "black"
  ) +
  geom_hline( # línea punteada para diferenciarla de los datos
    yintercept = 2,
    linetype = "dashed",       
    color = "red"
  ) +
  geom_point( # capa de puntos
    size = 4, 
    color = "darkblue"
  ) +
  geom_line( # línea de conexión para ver la tendencia de la razón
    group = 1,    
    color = "darkblue",
    size = 1
  ) +
    labs(
      title = "Razon Tasa de Suicidios / Tasa de Homicidios por Anio",
      x = "Anio",
      y = "Razon (Ratio Suicidios/Homicidios)",
      subtitle = "Razon > 1 indica tasa de suicidio es mayor | Razon = 2 indica tasa de suicidio duplica"
    ) +
  scale_x_continuous(breaks = unique(datos_con_comparacion$anio_def)) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))


print(grafico_razon)