library(tidyverse)
library(dplyr)
library(lubridate)
library(plotly)
library(ggplot2)
lab_sodra <- read.csv("C:/Users/Zenbook/OneDrive/Desktop/BANDYMAS45/KTU-duomenu-vizualizacija/laboratorinis/data/lab_sodra.csv")
summary(lab_sodra)

#############       UŽDUOTIS NR. 1              ##################

Data_uzd_1 <- lab_sodra %>% filter(ecoActCode==461000) 
summary(Data_uzd_1)

ttt <- ggplot(Data_uzd_1,aes(Data_uzd_1$avgWage))+geom_histogram(bins=200)+
  labs( x="46100 average salary", y="frequency")

ggsave(ttt,file="C:/Users/Zenbook/OneDrive/Desktop/BANDYMAS45/KTU-duomenu-vizualizacija/laboratorinis/img/rplot1.png",width =30, height = 10, units = "cm")


#############       UŽDUOTIS NR. 2              ##################

max5 <- lab_sodra %>% filter(ecoActCode==461000) %>% group_by(name,code) %>%
  summarise(wage=max(avgWage)) %>% arrange(desc(wage)) %>%
  head(5)

plot2 <- lab_sodra %>%
  filter(code %in% max5$code)

plot2 <- mutate (plot2,month1=parse_date_time(month, "ym"))


tt <- ggplot(plot2, aes(x=month1, y=avgWage, group=name, color=name)) +
  geom_line(size = 0.9, linetype = 4, alpha=0.4)+geom_point(color="plum3")+theme_bw()+
  labs(colour="COMPANY", y="Average salary", x="Month")+
  scale_x_datetime(date_labels="%b %y",date_breaks  ="1 month")
ggsave(tt,file="C:/Users/Zenbook/OneDrive/Desktop/BANDYMAS45/KTU-duomenu-vizualizacija/laboratorinis/img/rplot2.png",width =30, height = 10, units = "cm")

#############       UŽDUOTIS NR. 3             ##################

plot3 <- plot2  %>% group_by(name,code) %>% summarise(max_insured=max(numInsured)) %>%
  na.omit() %>%
  arrange (desc(max_insured))
plot3

t1<-plot3 %>% ggplot(aes(x=reorder(code, -max_insured), max_insured,group=code, fill=name))+geom_col()+
  scale_y_continuous(labels = scales::number_format())+theme_light()+
  labs(fill= "COMPANY", y="Maximum amount of insured people", x="Comapny Code")

ggsave(t1,file="C:/Users/Zenbook/OneDrive/Desktop/BANDYMAS45/KTU-duomenu-vizualizacija/laboratorinis/img/rplot3.png", width =17, height = 10, units = "cm")




