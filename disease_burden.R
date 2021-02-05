library(tidyverse)
library(janitor)

db <- read.csv("data/disease_burden.csv") %>%
  clean_names() %>%
  rename(deaths_per_100k = death_rate_per_100_000)

db_sub <- db %>%
  filter(country_name %in% c("United States", "Japan", 
                             "Afghanistan", "Somalia")) %>%
  filter(age_group == "0-6 days", sex == "Both")

ggplot(data = db_sub) +
  geom_line(aes(x = year,
                y = deaths_per_100k,
                color = country_name)) +
  scale_color_manual(values = c("black", "blue", "magenta", "orange")) +
  annotate(geom = "text",
           x = 1985,
           y = 2.2e5,
           label = "Afghanistan",
           size = 2.5) +
  geom_vline(xintercept = 2000,
             lty = 2) +
  theme_minimal() +
  ggsave(("final_graphs/disease_graph.png"), width = 5, height = 3)