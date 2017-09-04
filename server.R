library(shiny)
library(caret)
library(randomForest)
library(e1071)
library(party)
library(partykit)
new_train<-read.csv("D:/LearningR/Titanic/train.csv")
new_train$Class<-as.factor(new_train$Class)

new_train<-as.data.frame(new_train)
#new_train<-na.omit(new_train, cols="Age")
new_train$Family<-as.factor(new_train$Family)

str(new_train)
fit_LR<- glm(formula=factor(Survived)~Family+Class+Sex+Title+Embarked,data=new_train,  family=binomial)
set.seed(123)
RF<-randomForest(factor(Survived)~Family+Class+Sex+Title+Embarked,data=new_train,norm.votes = TRUE, proximity = TRUE)
SVM<- svm (factor(Survived)~Family+Class+Sex+Title+Embarked, new_train, probability=TRUE, cost = 100, gamma = 1)
CItree<- ctree(factor(Survived)~Family+Class+Sex+Title+Embarked,data=new_train)


predict_prob_1<-function(Family,Sex,Embarked,Class,Title){
  inputdata<-NULL
  inputdata<-c(Family,Sex,Embarked,Class,Title)
  predict_data<-as.data.frame(t(inputdata))
  #predict_data$V1<-as.factor(predict_data$V1)
  #predict_data$V2<-as.numeric(predict_data$V2)
  
  colnames(predict_data)<-c("Family","Sex","Embarked","Class","Title")
  str(predict_data)
  
  print(predict_data)
  
  
  #common<-intersect(names(new_train),names(predict_data))
  #print(common)
  #for (p in common){
   # if (class(predict_data[[p]])=="factor")
   # {levels(predict_data[[p]])<-levels(new_train[[p]])}}
  #str(predict_data)
  #predict_data[1,1]=Family
  #predict_data[1,2]=Sex
  #predict_data[1,3]=Embarked
  #predict_data[1,4]=Class
  #predict_data[1,5]=Title
  #print(predict_data)
  sur_prob<-predict(fit_LR,predict_data,type="response")
  #set.seed(123)
  #sur_prob<-predict(RF,predict_data,type="prob")
  #sur_prob<-predict(SVM,predict_data,probability=TRUE)
  
  return(sur_prob)
}

predict_prob_2<-function(Family,Sex,Embarked,Class,Title){
  inputdata<-NULL
  inputdata<-c(Family,Sex,Embarked,Class,Title)
  predict_data<-as.data.frame(t(inputdata))
  #predict_data$V1<-as.factor(predict_data$V1)
  #predict_data$V2<-as.numeric(predict_data$V2)
  
  colnames(predict_data)<-c("Family","Sex","Embarked","Class","Title")
  str(predict_data)
  
  print(predict_data)
  
  
  common<-intersect(names(new_train),names(predict_data))
  print(common)
  for (p in common){
    if (class(predict_data[[p]])=="factor")
    {levels(predict_data[[p]])<-levels(new_train[[p]])}}
  str(predict_data)
  predict_data[1,1]=Family
  predict_data[1,2]=Sex
  predict_data[1,3]=Embarked
  predict_data[1,4]=Class
  predict_data[1,5]=Title
  print(predict_data)
  #sur_prob<-predict(fit_LR,predict_data,type="response")
  set.seed(123)
  sur_prob<-predict(RF,predict_data,type="prob")
  #sur_prob<-predict(SVM,predict_data,probability=TRUE)
  
  return(sur_prob)
}

shinyServer(
  function(input, output) {
    output$LR <-renderText({predict_prob_1(input$f,input$s,input$e, input$c,input$t)})
    output$RF<-renderText({predict_prob_2(input$f,input$s,input$e, input$c,input$t)})
    
    
    
    
    output$plot<-renderPlot(plot(CItree))
    output$summary<-renderPrint({
      CItree
    })

  
})
  
