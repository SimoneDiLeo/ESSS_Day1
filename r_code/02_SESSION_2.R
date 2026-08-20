#Time series (2015-2024) of annual publication 
library(dplyr)
library(readxl)
library(ggplot2)
library(janitor)
SCOPUS_ARL <- read_excel("./SCOPUS_MASTER_FILE.xlsx",sheet="ARL")%>% clean_names()
WOS_ARL <- read_excel("./WOS_MASTER_FILE.xlsx",sheet="ARL")%>% clean_names()


SCOPUS_TL <- SCOPUS_ARL %>%
  group_by(year) %>%
  summarize(n=n())

WOS_TL <- WOS_ARL %>%
  group_by(year =publication_year) %>%
  summarize(n=n())

WOS_TL$source <- "WOS"
SCOPUS_TL$source <- "SCOPUS"

TS <- rbind(WOS_TL,SCOPUS_TL)

# cleaner and more tidy approach.
TS %>% 
  filter(year<2025) %>%
ggplot() +
  aes(x=year, y=n, color=source) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(min(TS$year), 2024, by = 1)) +
  theme_minimal() +
  labs(
    title = "Number of Indexed Publications",
    x = "Year",
    y = "Number of Publication",
    color = "Database"
  )

#Growth Indicator

TS_indexed <- TS %>%
  filter(year <= 2024 & year >= 2015) %>% 
  group_by(source) %>%
  mutate(
    val_2015 = n[year == 2015],
    Indexed_Trend = (n / val_2015) * 100
  ) %>%
  ungroup()

ggplot(TS_indexed, aes(x = year, y = Indexed_Trend, color = source)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_hline(yintercept = 100, linetype = "dashed", color = "gray50") +
  scale_x_continuous(breaks = seq(2015, 2024, by = 1)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  theme_minimal() +
  labs(
    title = "Indexed Trend of Publications (2015 = 100%)",
    x = "Year",
    y = "Growth Index (Base 2015 = 100%)",
    color = "Database"
  )
