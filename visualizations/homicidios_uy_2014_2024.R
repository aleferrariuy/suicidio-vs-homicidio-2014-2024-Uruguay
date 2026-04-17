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
# nueva columna necesaria para la grafica a crear
datos_tidy <- datos_sh %>%
  pivot_longer(
    cols = c(suicidios, homicidios), 
    names_to = "Tipo_Evento",        
    values_to = "Cantidad"           
  )
# grafica a crear
grafico_homicidio <- ggplot(
  data = datos_sh,
  aes(
    x = factor(anio_def),
    y = hom_rasa_100m,
    group = 1
  )
) +
  geom_text(
    aes(label = hom_rasa_100m), 
    vjust = -1,                 
    hjust = 0.5,                
    size = 3.5,                 
    color = "darkgreen"         
  ) +
  geom_line(color="red") +
  geom_point(color = "black") +
  labs(
    title = "Homicidio en Uruguay, evolucion anual",
    x = "Anio",
    y = "Tasa cada 100mil/hab"
  ) +
scale_y_continuous(expand = expansion(mult = c(0.1, 0.2))) +
theme_minimal() + 
theme(plot.title = element_text(hjust = 0.5, face = "bold")) 


print(grafico_homicidio)
