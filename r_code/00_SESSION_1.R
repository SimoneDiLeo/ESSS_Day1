# - We should start with generating an Rproject so all paths are relative, e.g. "data/somedata.XSLX"
#LIBRARIES
library(tidyverse)
library(readxl) 
library(openxlsx)
library(writexl)
library(janitor)


#MERGE WOS FILES

WOS1 <- read_excel("../00_DATA/01_WOS/savedrecs.xls")
WOS2 <- read_excel("../00_DATA/01_WOS/savedrecs (1).xls")
WOS3 <- read_excel("../00_DATA/01_WOS/savedrecs (2).xls")
WOS4 <- read_excel("../00_DATA/01_WOS/savedrecs (3).xls")
WOS5 <- read_excel("../00_DATA/01_WOS/savedrecs (4).xls")
WOS6 <- read_excel("../00_DATA/01_WOS/savedrecs (5).xls")
WOS7 <- read_excel("../00_DATA/01_WOS/savedrecs (6).xls")
WOS8 <- read_excel("../00_DATA/01_WOS/savedrecs (7).xls")

# STG: Suggestion: use bind_rows (included in tidyverse) to allow for column matching.
WOS <- rbind(WOS1,
          WOS2,
          WOS3,
          WOS4,
          WOS5,
          WOS6,
          WOS7,
          WOS8)
WOS<- clean_names(WOS)

rm(WOS1,WOS2,WOS3,WOS4,WOS5,WOS6,WOS7,WOS8)


#filter only for Articles, Reviews and Letters (A/R/L)

unique(WOS$document_type)

selection <- c("Article",
            "Review",
            "Article; Early Access",
            "Review; Early Access",
            "Letter")

WOS_ARL <- WOS %>% 
  filter(document_type %in% selection)

#TO SAVE THE DATA
sheets <- list("All" = WOS, "ARL" = WOS_ARL)
write.xlsx(sheets, file  = "WOS_MASTER_FILE.xlsx",keepNA=T)

#FILTERING SCOPUS DATA

SCOPUS <- read_csv("../00_DATA/00_SCOPUS/SCOPUS_10_08_26.csv")
SCOPUS<- clean_names(SCOPUS)
unique(SCOPUS$document_type)

selection=c("Article", "Review","Letter")

SCOPUS_ARL <- SCOPUS %>%
  filter(document_type%in% selection)

sheets <- list("All" = SCOPUS, "ARL" = SCOPUS_ARL)
write.xlsx(sheets, file  = "SCOPUS_MASTER_FILE.xlsx",keepNA=T)

#OPENALEX IMPORT
OA <- read_csv("../00_DATA/02_OPENALEX/OA_18_08_26.csv")
OA <-clean_names(OA)
unique(OA$type)
selection=c("article", "review","letter")

OA_ARL <- OA %>%
  filter(type%in% selection)

sheets <- list("All" = OA, "ARL" = OA_ARL)
write.xlsx(sheets, file  = "OA_MASTER_FILE.xlsx",keepNA=T)

