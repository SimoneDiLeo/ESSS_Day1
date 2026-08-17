#LIBRARIES
library(readxl)
library(readr)
library(dplyr)
library(tidyverse)
library(writexl)

#MERGE WOS FILES
WOS1= read_excel("../00_DATA/01_WOS/savedrecs.xls")
WOS2= read_excel("../00_DATA/01_WOS/savedrecs (1).xls")
WOS3= read_excel("../00_DATA/01_WOS/savedrecs (2).xls")
WOS4= read_excel("../00_DATA/01_WOS/savedrecs (3).xls")
WOS5= read_excel("../00_DATA/01_WOS/savedrecs (4).xls")
WOS6= read_excel("../00_DATA/01_WOS/savedrecs (5).xls")
WOS7= read_excel("../00_DATA/01_WOS/savedrecs (6).xls")
WOS8= read_excel("../00_DATA/01_WOS/savedrecs (7).xls")


WOS=rbind(WOS1,
          WOS2,
          WOS3,
          WOS4,
          WOS5,
          WOS6,
          WOS7,
          WOS8)

rm(WOS1,WOS2,WOS3,WOS4,WOS5,WOS6,WOS7,WOS8)


#filter only for Articles, Reviews and Letters (A/R/L)
unique(WOS$`Document Type`)

selection=c("Article",
            "Review",
            "Article; Early Access",
            "Review; Early Access",
            "Letter")

WOS_ARL=WOS%>%filter(`Document Type`%in% selection)

#TO SAVE THE DATA
write.csv2(WOS,"WOS_FILE.csv")
write.csv2(WOS_ARL,"WOS_FILE_ARL.csv")


#FILTERING SCOPUS DATA

SCOPUS <- read_csv("../00_DATA/00_SCOPUS/SCOPUS_10_08_26.csv")
SCOPUS_ARL <- read_csv("../00_DATA/00_SCOPUS/SCOPUS_ARL_10_08_26.csv")

unique(SCOPUS$`Document Type`)

selection=c("Article", "Review","Letter")

SCOPUS_ARL_TEST=SCOPUS%>%filter(`Document Type`%in% selection)

sheets <- list("All" = SCOPUS, "ARL" = SCOPUS_ARL)
library(openxlsx)
write.xlsx(sheets, file  = "SCOPUS_MASTER_FILE.xlsx")


#OPENALEX IMPORT
OA <- read_csv("../00_DATA/02_OPENALEX/OA_10_08_26.csv")
OAARL <- read_csv("../00_DATA/02_OPENALEX/OA_ARL_10_08_26.csv")

write.csv2(OA,"OPENALEX_FILE.csv")
write.csv2(OAARL,"OPENALEX_ARL.csv")
