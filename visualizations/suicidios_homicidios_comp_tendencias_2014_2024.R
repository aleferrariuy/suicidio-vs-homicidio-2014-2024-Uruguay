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
grafico_tendencia <- ggplot(
  data = datos_tidy, 
  aes(
    x = anio_def,
    y = Cantidad,
    color = Tipo_Evento,
    group = Tipo_Evento
  )
) +
  # líneas y puntos originales
  geom_line(alpha = 0.8) +
  geom_point(color = "black") +
  
  # regresión lineal 
  geom_smooth(
    method = "lm",           # especifica el método: 'lm' es Regresión Lineal.
    formula = y ~ x,         # especificarla evita un warning
    se = TRUE, #FALSE,       # IMPORTANTE: 'se = FALSE' oculta la banda de error estándar,
                             # dejando solo la línea de tendencia.
    linetype = "dashed",     # línea punteada para distinguirla de la línea de datos.
    size = 1                 # Grosor de la línea
  ) +
    labs(
      title = "Tendencia Anual de Suicidios y Homicidios (con Regresion Lineal)",
      x = "Anio",
      y = "Numero de Casos",
      color = "Tipo de Evento"
    ) +
  scale_color_manual(values = c("homicidios" = "red", "suicidios" = "blue")) +
  scale_x_continuous(breaks = unique(datos_tidy$anio_def)) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))


print(grafico_tendencia)