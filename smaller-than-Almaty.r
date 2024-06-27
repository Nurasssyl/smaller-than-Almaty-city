# Установка необходимых пакетов
install.packages("ggplot2")
install.packages("ggimage")
install.packages("countrycode")

library(ggplot2)
library(ggimage)
library(countrycode)

# Данные
countries <- data.frame(
  country = c("Ватикан", "Монако", "Науру", "Тувалу", "Сан-Марино", "Лихтенштейн", "Маршалловы Острова", 
              "Сент-Китс и Невис", "Мальдивы", "Мальта", "Гренада", "Сент-Винсент и Гренадины", 
              "Барбадос", "Антигуа и Барбуда", "Сейшельские Острова", "Палау", "Андорра", "Сент-Люсия"),
  area = c(0.49, 2.02, 21, 26, 61, 160, 181, 261, 300, 316, 344, 389, 430, 442, 455, 459, 468, 616),
  code = c("VA", "MC", "NR", "TV", "SM", "LI", "MH", "KN", "MV", "MT", "GD", "VC", "BB", "AG", "SC", "PW", "AD", "LC")
)

# Добавление Алматы
almaty <- data.frame(country = "Алматы", area = 682, code = "KZ")

# Объединение данных
all_data <- rbind(countries, almaty)

# Добавление ссылок на флаги
all_data$image <- ifelse(all_data$country == "Алматы",
                         "C:/Users/User/Desktop/R/Coat_of_arms_of_Almaty.png",
                         paste0("https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/", 
                                tolower(all_data$code), ".png"))


# Создание столбчатой диаграммы с флагами
gg <- ggplot(all_data, aes(x = reorder(country, area), y = area)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_hline(yintercept = 682, color = "red", linetype = "dashed") +
  geom_text(aes(label = area), vjust = 0.5, hjust = -0.3, size = 3) +
  geom_image(aes(y = area + 40, image = image), size = 0.03) +
  coord_flip() +
  labs(title = "Площадь стран, не превышающих площади города Алматы",
       x = "Страны",
       y = "Площадь (км²)") +
  theme_minimal()

# Сохранение графика в формате PNG
ggsave("C:/Users/User/Desktop/R/smaller-than-Almaty-city.jpg", plot = gg, width = 10, height = 6, units = "in")

