#IMPORT DATA (SCOPUS AND WOS IN OUR CASE)
library(readxl)

SCOPUS_ALL <- read_excel("../00_DATA/00_SCOPUS/SCOPUS_MASTER_FILE.xlsx")
WOS_ALL <- read_excel("../00_DATA/01_WOS/01_WOS_MASTER_10_08_26.xlsx")

#identify in your selected two data sources the percentage of publications with: 
#DOI (Digital Object Identifier) 
SCOPUS_ALL%>%filter(!is.na(SCOPUS_ALL$DOI))%>%summarize(n())/nrow(SCOPUS_ALL)*100
WOS_ALL%>%filter(!is.na(WOS_ALL$DOI))%>%summarize(n())/nrow(WOS_ALL)*100

#ORCID-linked author
SCOPUS_ALL%>%filter(!is.na(SCOPUS_ALL$`Author(s) ID`))%>%summarize(n())/nrow(SCOPUS_ALL)*100
WOS_ALL%>%filter(!is.na(WOS_ALL$ORCIDs))%>%summarize(n())/nrow(WOS_ALL)*100

#Open Access (OA) status 
SCOPUS_ALL%>%filter(!is.na(SCOPUS_ALL$`Open Access`))%>%summarize(n())/nrow(SCOPUS_ALL)*100
WOS_ALL%>%filter(!is.na(WOS_ALL$`Open Access Designations`))%>%summarize(n())/nrow(WOS_ALL)*100

#Funding information 
SCOPUS_ALL%>%filter(!is.na(SCOPUS_ALL$`Funding Texts`))%>%summarize(n())/nrow(SCOPUS_ALL)*100
WOS_ALL%>%filter(!is.na(WOS_ALL$`Funding Text`))%>%summarize(n())/nrow(WOS_ALL)*100
