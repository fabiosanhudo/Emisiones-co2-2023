# TRABAJO PL1 - EMISIONES CO2 #

emisionesco2.con.datos = read.csv2("EmisionesCO2.csv")

(emisiones=emisionesco2.con.datos$Emisiones_Anno_Millones_Toneladas)
(pib=emisionesco2.con.datos$PIB)

# MEDIDAS ESTADÍSTICAS
# 1 - Tamaño de la muestra
length(emisiones)
tapply(emisiones, pib, length)

# MEDIDAS DE CENTRALIZACIÓN
# 1 - Media
media=round(mean(emisiones),2)
round(mean(emisiones),2)
round(tapply(emisiones,pib,mean),2)
# 1.1 - Media Alto PIB
media.altopib=round(mean(emisiones.altopib),2)
round(mean(emisiones.altopib),2)
# 1.2 - MEdia Bajo PIB
media.bajopib=round(mean(emisiones.bajopib),2)
round(mean(emisiones.bajopib),2)

# 2 - Mediana
median=round(median(emisiones),2)
round(median(emisiones),2)
round(tapply(emisiones,pib,median),2)
# 2.1 - Mediana Alto PIB
median.altopib=round(median(emisiones.altopib),2)
round(median(emisiones.altopib),2)
# 2.2 -- Mediana Bajo PIB
median.bajopib=round(median(emisiones.bajopib),2)
round(median(emisiones.bajopib),2)

# MEDIDAS DE DISPERSIÓN
# 1 - Mínimo
min=min(emisiones)
min(emisiones)
tapply(emisiones,pib,min)

# 2 - Máximo
max=max(emisiones)
max(emisiones)
tapply(emisiones,pib,max)

# 3 - Rango
range=max(emisiones)-min(emisiones)
max(emisiones)-min(emisiones)
tapply(emisiones,pib,max)-tapply(emisiones,pib,min)

# 4 - Varianza Muestral
varianza=round(var(emisiones),2)
round(var(emisiones),2)
round(tapply(emisiones,pib,var),2)

# 5 - Desviacón Estándar
sd=round(sd(emisiones),2)
round(sd(emisiones),2)
round(tapply(emisiones,pib,sd),2)

# 6 - Coeficiente de Variación
Coeficiente_var=round(sd(emisiones)/mean(emisiones),2)
round(sd(emisiones)/mean(emisiones),2)
round(tapply(emisiones,pib,sd)/tapply(emisiones,pib,mean),2)

# MEDIDAS DE LOCALIZACIÓN
# 1 - Cuartiles
round(summary(emisiones),2)
tapply(emisiones,pib,quantile)

# 2 - Rango Intercuartílico
round(IQR(emisiones),2)
round(tapply(emisiones,pib,IQR),2)

# MEDIDAS DE FORMA
install.packages("e1071")
library(e1071)

# 1 - Coeficiente de Asimetria
round(skewness(emisiones),2)
round(tapply(emisiones,pib,skewness),2)

# 2 - Coeficiente de apuntamiento o Curtosis
round(kurtosis(emisiones),2)
round(tapply(emisiones,pib,kurtosis),2)

# OTRAS MEDIDAS
# 1 - Valores inferiores a la media
(emisiones.inferiores.media=length(emisiones[emisiones<mean(emisiones)]))
round(100*emisiones.inferiores.media/length(emisiones))

emisiones.altopib=emisionesco2.con.datos[emisionesco2.con.datos$PIB=="Alto PIB per capita",]$Emisiones_Anno_Millones_Toneladas
emisiones.bajopib=emisionesco2.con.datos[emisionesco2.con.datos$PIB=="Bajo PIB per capita",]$Emisiones_Anno_Millones_Toneladas

(emisiones.altopib.inferiores.media=length(emisiones.altopib[emisiones.altopib<mean(emisiones.altopib)]))
round(100*emisiones.altopib.inferiores.media/length(emisiones.altopib))

(emisiones.bajopib.inferiores.media=length(emisiones.bajopib[emisiones.bajopib<mean(emisiones.bajopib)]))
round(100*emisiones.bajopib.inferiores.media/length(emisiones.bajopib))

# 2 - Valores superiores a la media
(emisiones.superiores.media=length(emisiones[emisiones>mean(emisiones)]))
round(100*emisiones.superiores.media/length(emisiones))

(emisiones.altopib.superiores.media=length(emisiones.altopib[emisiones.altopib>mean(emisiones.altopib)]))
round(100*emisiones.altopib.superiores.media/length(emisiones.altopib))

(emisiones.bajopib.superiores.media=length(emisiones.bajopib[emisiones.bajopib>mean(emisiones.bajopib)]))
round(100*emisiones.bajopib.superiores.media/length(emisiones.bajopib))

# TABLA DE FRECUENCIAS
# Regla de Sturges para una muestra de 147
ceiling(1+3.322*log10(147)) # -> 9 Intervalos (usaremos 10 para facilitar división de clases)

# 1 - Tabla de contigencia con 10 clases
L1=c(0, 5, 15, 30, 60, 120, 200, 350, 550, 800, 1000)
emisiones.agrupadas1=cut(emisiones, breaks=L1, right=FALSE, include.lowest=TRUE)
addmargins(table(emisiones.agrupadas1, pib))
round(addmargins(prop.table(table(emisiones.agrupadas1,pib))),2)

# Vamos a comprobar la distribución de frecuencias por nivel de calificación, con 4 intervalos:
# [0,30) para Baja Emisión, [30,120) para Media/Baja Emisión, [120,550) para Media/Alta Emisión y [550,1000] para Altas Emisiones.

# 2 - Tabla de contigencia con 4 clases
L2=c(0, 30, 120, 550, 1000) 
emisiones.agrupadas2=cut(emisiones, breaks=L2, right=FALSE, include.lowest=TRUE)
addmargins(table(emisiones.agrupadas2,pib))
round(addmargins(prop.table(table(emisiones.agrupadas2,pib))),2)

# DIBUJAR DIAGRAMAS
# 1 - Diagrama de tarta
par(mfrow=c(1,1))
ft=table(pib)
etiquetas.pib=c("Alto PIB", "Bajo PIB")
propt=round(ft/sum(ft)*100)
etiquetas.pib=paste(etiquetas.pib, propt)
etiquetas.pib=paste(etiquetas.pib,"%",sep="")
pie(ft,labels=etiquetas.pib, col=rainbow(2))


###################DIAGRAMA TARTA GGPLOT PRUEBA################
# install.packages("ggplot2")
# library(ggplot2)
# 
# ggplot(df, aes(x = "", y = porcentaje, fill = etiqueta)) +
#   geom_bar(stat = "identity", width = 1) +
#   coord_polar("y", start = 0) +
#   theme_void() +
#   labs(title = "Distribución del PIB") +
#   geom_text(aes(label = paste0(etiqueta, " (", round(porcentaje, 1), "%)")),
#             position = position_stack(vjust = 0.5)) +
#   scale_fill_manual(values = c("#66c2a5", "#fc8d62")) +
#   theme(
#     plot.title = element_text(hjust = 0.5),
#     legend.title = element_blank()
#   )
###################################################


# 2 - Diagramas de tarta de calificaciones
# 2.1 - Globales
par(mfrow=c(1,1))
L2=c(0, 30, 120, 550, 1000)
fn=table(emisiones.agrupadas2)
etiquetas.pib.calificacion <- c("Baja Emisión", "Media/Baja Emisión", "Media/Alta Emisión", "Alta Emisión")
prop <- round(fn/sum(fn)*100)
etiquetas.pib.calificacion=paste(etiquetas.pib.calificacion, prop)
etiquetas.pib.calificacion=paste(etiquetas.pib.calificacion,"%",sep="")
pie(fn,labels=etiquetas.pib.calificacion, col=rainbow(4), main="Emisiones")

# 2.2 - Alto PIB
emisiones.agrupadas.altopib=cut(emisiones.altopib, breaks=L2, right=FALSE, include.lowest=TRUE)
fm=table(emisiones.agrupadas.altopib)
etiquetas.altopib <- c("Baja Emisión", "Media/Baja Emisión", "Media/Alta Emisión", "Alta Emisión")
prop <- round(fm/sum(fm)*100)
etiquetas.altopib=paste(etiquetas.altopib, prop)
etiquetas.altopib=paste(etiquetas.altopib,"%",sep="")
pie(fm,labels=etiquetas.altopib, col=rainbow(4), main="Emisiones Alto PIB")

# 2.3 - Bajo PIB
emisiones.agrupadas.bajopib=cut(emisiones.bajopib, breaks=L2, right=FALSE, include.lowest=TRUE)
fp=table(emisiones.agrupadas.bajopib)
etiquetas.bajopib <- c("Baja Emisión", "Media/Baja Emisión", "Media/Alta Emisión", "Alta Emisión")
prop <- round(fp/sum(fp)*100)
etiquetas.bajopib=paste(etiquetas.bajopib, prop)
etiquetas.bajopib=paste(etiquetas.bajopib,"%",sep="")
pie(fp,labels=etiquetas.bajopib, col=rainbow(4), main="Emisiones Bajo PIB")

# HISTOGRAMAS Y DIAGRAMAS DE CAJA
# 1 - Histogramas y Boxplot 
par(mfrow=c(1,1))
hist(emisiones, breaks=L1, main="Distribución Relativa CO2/País", ylab="Fecuencia Relativa", xlab="Emisiones (millones Toneladas)")
abline(v=median(emisiones), lwd=2, col="blue")
abline(v=mean(emisiones), lwd=2, lty=2, col="darkred")

# 1.1 - Alto PIB
hist(emisiones.altopib, breaks=L1, main="Distribución Relativa CO2/Alto PIB", ylab="Fecuencia Relativa", xlab="Emisiones Alto PIB (millones Toneladas)")
abline(v=median(emisiones.altopib), lwd=2, col="blue")
abline(v=mean(emisiones.altopib), lwd=2, lty=2, col="darkred")

# 1.2 - Bajo PIB
hist(emisiones.bajopib, breaks=L1, main="Distribución Relativa CO2/Bajo PIB", ylab="Fecuencia Relativa", xlab="Emisiones Bajo PIB (millones Toneladas)")
abline(v=median(emisiones.bajopib), lwd=2, col="blue")
abline(v=mean(emisiones.bajopib), lwd=2, lty=2, col="darkred")

# 2 - Boxplot
boxplot(emisiones, horizontal=TRUE, ylimc=c(0,1000))
segments(x0=mean(emisiones), y0=0.8, x1=mean(emisiones), y1=1.2, col="darkred", lwd=2, lty=2)

# 2.1 - Boxplot Alto PIB
boxplot(emisiones.altopib, horizontal=TRUE, ylimc=c(0,1000))
segments(x0=mean(emisiones.altopib), y0=0.8, x1=mean(emisiones.altopib), y1=1.2, col="darkred", lwd=2, lty=2)

# 2.2 - Boxplot Bajo PIB
boxplot(emisiones.bajopib, horizontal=TRUE, ylimc=c(0,1000))
segments(x0=mean(emisiones.bajopib), y0=0.8, x1=mean(emisiones.bajopib), y1=1.2, col="darkred", lwd=2, lty=2)

###################################################
###################################################

# ***GGPLOT2***
# HISTOGRAMAS Y DIAGRAMAS DE CAJA
install.packages("ggplot2")
library(ggplot2)
emisiones.altopib.df=data.frame(emisiones.altopib)
emisiones.bajopib.df=data.frame(emisiones.bajopib)
install.packages("patchwork")
library(patchwork)

###GLOBALES###
iqr <- IQR(emisionesco2.con.datos$Emisiones_Anno_Millones_Toneladas, na.rm = TRUE)
n <- sum(!is.na(emisionesco2.con.datos$Emisiones_Anno_Millones_Toneladas))
binwidth <- 3.3 * iqr / (n^(1/3))
binwidth

histograma <- ggplot(emisionesco2.con.datos, aes(x = emisiones)) +
  geom_histogram(aes(y = after_stat(density)),
                 binwidth = binwidth,
                 fill = "skyblue", color = "black", alpha = 0.6) +
  geom_vline(aes(xintercept = media), color = "blue", linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept = median), color = "green", linetype = "dotted", linewidth = 1) +
  labs(
    title = "Emisiones Anuales Global",
    subtitle = "Media (azul) / Mediana (verde)",
    x = "Emisiones (millones de toneladas)",
    y = "Densidad"
  ) +
  theme_minimal()

boxplot <- ggplot(emisionesco2.con.datos, aes(x = emisiones)) +
  geom_boxplot(fill = "skyblue", color = "black", alpha = 0.6,
               outlier.color = "red", width = 0.25) +
  geom_vline(aes(xintercept = media), color = "blue", linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept = median), color = "green", linetype = "dotted", linewidth = 1) +
  labs(x = "Emisiones (millones de toneladas)", y = "") +
  theme_minimal() +
  theme(
    axis.text.y = element_blank()
  )

# Combinar: histograma arriba, boxplot abajo
histograma / boxplot

###ALTOPIB###
iqr <- IQR(emisiones.altopib.df$emisiones.altopib, na.rm = TRUE)
n <- sum(!is.na(emisiones.altopib.df$emisiones.altopib))
binwidth <- iqr / (n^(1/3))
binwidth

histograma_altopib <- ggplot(emisiones.altopib.df, aes(x = emisiones.altopib)) +
  geom_histogram(aes(y = after_stat(density)),
                 binwidth = binwidth,
                 fill = "skyblue", color = "black", alpha = 0.6) +
  geom_vline(aes(xintercept = media.altopib), color = "blue", linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept = median.altopib), color = "green", linetype = "dotted", linewidth = 1) +
  labs(
    title = "Emisiones Anuales Alto PIB",
    subtitle = "Media (azul) / Mediana (verde)",
    x = "Emisiones (millones de toneladas)",
    y = "Densidad"
  ) +
  theme_minimal()

# Boxplot horizontal
boxplot_altopib <- ggplot(emisiones.altopib.df, aes(x = emisiones.altopib)) +
  geom_boxplot(fill = "skyblue", color = "black", alpha = 0.6,
               outlier.color = "red", width = 0.25) +
  geom_vline(aes(xintercept = media.altopib), color = "blue", linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept = median.altopib), color = "green", linetype = "dotted", linewidth = 1) +
  labs(x = "Emisiones (millones de toneladas)", y = "") +
  theme_minimal() +
  theme(
    axis.text.y = element_blank()
  )

# Mostrar ambos gráficos uno encima del otro
histograma_altopib / boxplot_altopib

####BAJOPIB####
iqr <- IQR(emisiones.bajopib.df$emisiones.bajopib, na.rm = TRUE)
n <- sum(!is.na(emisiones.bajopib.df$emisiones.bajopib))
binwidth <- 5.5 * iqr / (n^(1/3))
binwidth

histograma_bajopib <- ggplot(emisiones.bajopib.df, aes(x = emisiones.bajopib)) +
  geom_histogram(aes(y = after_stat(density)),
                 binwidth = binwidth,
                 fill = "skyblue", color = "black", alpha = 0.7) +
  geom_vline(aes(xintercept = media.bajopib), color = "blue", linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept = median.bajopib), color = "green", linetype = "dotted", linewidth = 1) +
  labs(
    title = "Emisiones Anuales Bajo PIB",
    subtitle = "Media (azul) / Mediana (verde)",
    x = "Emisiones (millones de toneladas)",
    y = "Densidad"
  ) +
  theme_minimal()

# Boxplot horizontal
boxplot_bajopib <- ggplot(emisiones.bajopib.df, aes(x = emisiones.bajopib)) +
  geom_boxplot(fill = "skyblue", color = "black", alpha = 0.7,
               outlier.color = "red", width = 0.25) +
  geom_vline(aes(xintercept = media.bajopib), color = "blue", linetype = "dashed", linewidth = 1) +
  geom_vline(aes(xintercept = median.bajopib), color = "green", linetype = "dotted", linewidth = 1) +
  labs(x = "Emisiones (millones de toneladas)", y = "") +
  theme_minimal() +
  theme(
    axis.text.y = element_blank()
  )

# Mostrar ambos gráficos uno debajo del otro
histograma_bajopib / boxplot_bajopib


