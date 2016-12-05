# This is an educational example of how R and RStudio can be used 
# to analyze data and produce graphics.

# Это пример того, как можно использовать среду R/RStudio 
# для анализа данных и построения графиков

# Alexey Knorre, 30.11.2016
# http://alexeyknorre.ru/courses/datavis2016/datavis-6.pdf


# Калькулятор

2 + 2
56 * 32
45 ^ 55

# Переменные

x <- 7
x * 10

# Строки

hello <- "Привет, меня зовут "
name <-"_впишите_сюда_имя_"
paste0(hello, name)


# Повторение переменной x 10 раз:

rep(x, 10)
rep(name, 10)

# Создание последовательности чисел:

seq(1,10)
seq(5,9)
seq(3,9) * 3

# Помощь по функции seq:
help(seq)

# Векторы и датафреймы
height <- c(145, 167, 176, 123, 150)
height

weight <- c(51, 63, 64, 40, 55)
weight

data <- data.frame(weight, height)
data
data$weight

# Вычисляем среднее:
mean(data$weight)
mean(data$height)

# Как коррелируют вес и рост:
cor(data$weight, data$height)

# Таблица сопряженности:
table(data$weight, data$height)

## Графики

# Сделаем диаграмму рассеяния:
plot(data$weight, data$height, type = "p") # Попробуйте "o" "p" "l" "b"

# Прокачиваем изображение:
plot(data$weight, data$height, 
     col = "red", # красный цвет кружков
     pch = 16, # фигура для нанесения на график. 16 - заполненные точки. Попробуйте другие числа
     xlab = "Вес", # подпись оси X
     ylab = "Рост", # подпись оси Y
     main = "Диаграмма рассеяния веса и роста") # заголовок изображения

## Сохраняем изображение

# Сначала узнаем, куда R сохраняет по умолчанию:
getwd()

# Можно изменить папку сохранения на рабочий стол - не забудьте изменить имя пользователя:
setwd("C:/Users/Alexey/Desktop/")

# Сохраняем изображение в формате PNG:

png("test.png")

plot(data$weight, data$height, 
     col = "red", # красный цвет кружков
     pch = 16, # фигура для нанесения на график. 16 - заполненные точки. Попробуйте другие числа
     xlab = "Вес", # подпись оси X
     ylab = "Рост", # подпись оси Y
     main = "Диаграмма рассеяния веса и роста") # заголовок изображения

dev.off()

## Пример реальных данных: выборы в Государственную Думу РФ, 2016
## Сайт ЦИК России:
## http://www.vybory.izbirkom.ru/region/izbirkom
## Результаты выборов в Думу:
## http://www.vybory.izbirkom.ru/region/region/izbirkom?action=show&root=1&tvd=100100067795854&vrn=100100067795849&region=0&global=1&sub_region=0&prver=0&pronetvd=0&vibid=100100067795854&type=242

# Добавляем данные о партиях и процентном распределении голосов:
parties <- c("Родина", 
             "Коммунисты России",
             "Российская партия пенсионеров за справедливость",
             "Единая Россия",
             "Партия 'Зелёные'",
             "Гражданская платформа",
             "ЛДПР",
             "Партия народной свободы",
             "Партия роста",
             "Гражданская сила",
             "Яблоко",
             "КПРФ",
             "Патриоты России",
             "Справедливая Россия")

election_results <- c(1.51, 27, 1.73, 54.2, 
                      0.76, 0.22, 13.14, 
                      0.73, 1.29, 0.14,
                      1.99, 13.34, 0.59, 6.22)

elect_data <- data.frame(parties, election_results)

# Строим столбиковую диаграмму:
barplot(elect_data$election_results)

# Не нравится. Нужны подписи к осям
barplot(elect_data$election_results, names.arg = elect_data$parties)

# Не все оси подписались. Расположим подписи горизонтально:
par(las = 2)
barplot(elect_data$election_results, names.arg = elect_data$parties)

# Теперь лучше, но всё равно плохо. Перевернём диаграмму:
barplot(elect_data$election_results, names.arg = elect_data$parties, horiz = TRUE)

# Уменьшим размер подписей:
par(mar=c(3,16,3,3)) # меняем размер графика, чтобы названия помещались
barplot(elect_data$election_results, names.arg = elect_data$parties, horiz = TRUE, cex.names = 0.7)

# Отсортируем по убыванию процента голосов
elect_data <- elect_data[order(elect_data$election_results),]

# Окончательно прокачиваем график:

png("parties.png") # Позже сохраним график

par(las = 2)
par(mar=c(3,16,3,3)) # меняем размер графика, чтобы названия помещались
barplot(elect_data$election_results, 
        names.arg = elect_data$parties, 
        horiz = TRUE, 
        cex.names = 0.7,
        xlim = c(0,60), # увеличиваем длину оси X
        main = "Результаты голосования в ГД РФ, 2016",
        xlab = "Количество проголосовавших за партию, в процентах")

dev.off()
