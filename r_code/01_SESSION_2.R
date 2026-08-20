#IMPORT DATA (SCOPUS AND WOS IN OUR CASE)
library(readxl)
library(janitor)

SCOPUS_ALL <- read_excel("./SCOPUS_MASTER_FILE.xlsx")
WOS_ALL <- read_excel("./WOS_MASTER_FILE.xlsx")
SCOPUS_ALL<-SCOPUS_ALL%>% clean_names()
WOS_ALL<-WOS_ALL%>% clean_names()
#identify in your selected two data sources the percentage of publications with: 
#DOI (Digital Object Identifier) 
SCOPUS_ALL%>% 
  filter(!is.na(doi)& doi != "") %>%
  summarize(n()) / nrow(SCOPUS_ALL)*100

WOS_ALL %>% 
  filter(!is.na(doi)& doi != "")%>%
  summarize(n()) / nrow(WOS_ALL)*100

#ORCID-linked author
SCOPUS_ALL %>%
  filter(!is.na(author_s_id) & author_s_id!= "") %>%
  summarize(n())/nrow(SCOPUS_ALL)*100

WOS_ALL%>%
  filter(!is.na(orci_ds)& orci_ds!= "")%>%
  summarize(n())/nrow(WOS_ALL)*100

#Open Access (OA) status 
SCOPUS_ALL %>%
  filter(!is.na(open_access)& open_access!= "") %>%
  summarize(n()) / nrow(SCOPUS_ALL)*100

WOS_ALL %>%
  filter(!is.na(open_access_designations)& open_access_designations!= "") %>%
  summarize(n()) / nrow(WOS_ALL)*100

#Funding information 
SCOPUS_ALL %>% 
  filter(!is.na(funding_texts)& funding_texts!= "") %>%
  summarize(n()) / nrow(SCOPUS_ALL)*100

WOS_ALL %>%
  filter(!is.na(funding_text)& funding_text!= "") %>%
  summarize(n()) / nrow(WOS_ALL)*100

