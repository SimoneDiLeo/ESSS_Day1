#WOS
WOS_ARL <- read_excel("../00_DATA/01_WOS/01_WOS_MASTER_10_08_26.xlsx",sheet="ARL")

WOS_COUNT=WOS_ARL %>%
  count(`WoS Categories`, sort = TRUE)
WOS_COUNT=WOS_COUNT[1:20,]

OA_ARL <- read_excel("../00_DATA/02_OPENALEX/01_OPENALEX_MASTER_10_08_26.xlsx",sheet="ARL")

OA_COUNT=OA_ARL %>%
  count(Subfield, sort = TRUE)
OA_COUNT=OA_COUNT[1:20,]
