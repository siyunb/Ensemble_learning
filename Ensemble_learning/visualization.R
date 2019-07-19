library(ggplot2)
library(gplots)
library(plyr)
library(dplyr)
library(showtext)  #ʹ��ͼ��������ӷḻ
library(RColorBrewer)  #���ӵ�ɫ��
taiwan<- read.csv("D:/bigdatahw/�㷨/��ҵ/card1.csv",head=TRUE,sep=',') #��ȡ̨����������
taiwan$SEX<-as.factor(taiwan$SEX)         
taiwan$EDUCATION<-as.factor(taiwan$EDUCATION)
taiwan$MARRIAGE<-as.factor(taiwan$MARRIAGE)
taiwan$default.payment.next.month<-as.factor(taiwan$default.payment.next.month)
names(taiwan)[25]="default"              #������
levels(taiwan$SEX)=list(M="1",F="2")     #�����������ȼ�
levels(taiwan$EDUCATION)=list(others="0",graduate="1",university="2", highschool="3",others="4",others="5",others="6")
levels(taiwan$MARRIAGE)=list(married="1", single="2",others="3",others="0")
levels(taiwan$default)=list(T="1", F="0")
#����״����ΥԼռ�ȱ�״ͼ������ķ�õ��ͼ
label<-c("others","highschool","university","graduate")
taiwan$EDUCATION<- ordered(taiwan$EDUCATION, levels = label)
ggplot(taiwan,aes(x=default,fill=EDUCATION))+
  geom_bar()+coord_polar(theta = 'x')+
  scale_fill_brewer(palette='Spectral')+facet_wrap(~SEX)+theme_bw()+ 
  labs(x="ΥԼ״��",y="Ƶ��",fill="ѧ��״��",title='�����õ��ͼ')+scale_x_discrete()+coord_polar(theta="x")+
  theme(plot.title = element_text(hjust = 0.5,family="myFont",size=18,color="gold3"),panel.background=element_rect(fill='aliceblue')) 

#ΥԼ������ֲ�ֱ��ͼ
label<-c("F","T")
taiwan$default<- ordered(taiwan$default, levels = label)
p<-ggplot(taiwan,aes(x=AGE,fill=default)) 
p+geom_histogram(position="identity",alpha=0.5)+ggtitle('��ѧ��ΥԼ״��������ֲ�ֱ��ͼ')+
  theme(plot.title = element_text(hjust = 0.5,family="myFont",size=18,color="red"),panel.background=element_rect(fill='aliceblue')) + xlab("����") + 
  ylab("Ƶ��")+facet_wrap(~EDUCATION)
 
#���и��������ΥԼ����ͼ
ggplot(taiwan,aes(x=default,y=LIMIT_BAL,fill=default))+
  geom_boxplot(outlier.size=1.5, outlier.shape=15,notch=TRUE,alpha=.35)+
  stat_summary (fun.y="mean",geom="point",shape=23,size=2,fill="white")+
  xlab("ΥԼ���") + ylab("���������ö��") +ggtitle('�������ö����ΥԼ����ͼ')+ylim(0,550000)+
  theme(plot.title = element_text(hjust = 0.5,  family="myFont",size=18,color="red"), 
        panel.background=element_rect(fill='aliceblue',color='black')) 

#����״����ΥԼ֮���ϵ
ggplot(taiwan,aes(x=factor(1),fill=default))+
  geom_bar(aes(fill=default),position="fill")+coord_polar(theta="y")+
  ggtitle('����״����ΥԼ֮���ϵ')+
  theme(plot.title = element_text(hjust = 0.5,family="myFont",size=18,color="black"),      
       panel.background=element_rect(fill='aliceblue',color='black'))+facet_wrap(~MARRIAGE) 

#������ΥԼ��ϵ
ggplot(taiwan, aes(EDUCATION))+geom_bar(aes(fill=default),position="fill")+
  coord_polar(theta = "y")+
  ggtitle('����ˮƽ��ΥԼ֮���ϵ')+
  theme(plot.title = element_text(hjust = 0.5,family="myFont",size=18,color="black"),      
        panel.background=element_rect(fill='aliceblue',color='black'))

#�����������ȹ�ϵ
taiwan<-taiwan[which(taiwan$default=='T'),]
p=ggplot(taiwan,aes(x=AGE,y=log(LIMIT_BAL)))
#Ĭ�ϵȸ���ͼ���з��仯����
p+geom_point(alpha=0.2)+stat_bin2d()+scale_fill_gradient(low="lightblue",high="red")+stat_density2d()+
  theme(plot.title = element_text(hjust = 0.5,family="myFont",size=18,color="slateblue2"),panel.background=element_rect(fill='papayawhip'))+
  labs(x='����',y='log(�������)',title='�������������ܶȹ�ϵ')