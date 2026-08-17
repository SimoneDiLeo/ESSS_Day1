#Time series (2015-2024) of annual publication 
library(dplyr)
library(readxl)
library(ggplot2)

SCOPUS_ARL <- read_excel("../00_DATA/00_SCOPUS/SCOPUS_MASTER_FILE.xlsx",sheet="ARL")
WOS_ARL <- read_excel("../00_DATA/01_WOS/01_WOS_MASTER_10_08_26.xlsx",sheet="ARL")


SCOPUS_TL=SCOPUS_ARL%>%group_by(Year)%>%summarize(n=n())
WOS_TL=WOS_ARL%>%group_by(Year =`Publication Year`)%>%summarize(n=n())
WOS_TL$SOURCE="WOS"
SCOPUS_TL$SOURCE="SCOPUS"
TS=rbind(WOS_TL,SCOPUS_TL)

ggplot(TS%>%filter(Year<2025),aes(x=Year,y=n,color=SOURCE))+
  geom_point()+
  geom_line()+
  scale_x_continuous(breaks = seq(min(TS$Year), 2024, by = 1)) +
  theme_minimal()+
  labs(
    title = "Number of Indexed Publications",
    x = "Year",
    y = "Number of Publication",
    color = "Database"
  )

#Growth Indicator

TS_indexed <- TS %>%
  filter(Year <= 2024 & Year >= 2015) %>% # Filtriamo dal 2015 al 2024
  group_by(SOURCE) %>%
  mutate(
    val_2015 = n[Year == 2015],
    Indexed_Trend = (n / val_2015) * 100
  ) %>%
  ungroup()

ggplot(TS_indexed, aes(x = Year, y = Indexed_Trend, color = SOURCE)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_hline(yintercept = 100, linetype = "dashed", color = "gray50") + # Linea base 2015 = 100%
  scale_x_continuous(breaks = seq(2015, 2024, by = 1)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  theme_minimal() +
  labs(
    title = "Indexed Trend of Publications (2015 = 100%)",
    x = "Year",
    y = "Growth Index (Base 2015 = 100%)",
    color = "Database"
  )
