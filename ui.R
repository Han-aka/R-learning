library(shiny)

# Define UI for passenger information
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Predict your survival probability"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    
    
    #numericInput("A", label=h3("Age"),3),
    
    
    numericInput("f", label=h3("Family"),min=0, max=7, 5),
    helpText("Note: Family means the number of family members including spouse,parent and children."
             ),
    
    radioButtons("s",label=h3("Sex"),list("Male"="male","Female"="female"),selected="male"),
    radioButtons("e",label=h3("Embarked"),list("S"="S","Q"="Q","C"="C"),selected="S"),
    selectInput("c", label=h3("Class"),list("First class"="1","Second class"="2","Third class"="3"),selected = "3"),
    selectInput("t",label=h3("Title"),list("Mr"="Mr","Mrs"="Mrs","Capt"="Capt","Col"="Col","Don"="Don","Dr"="Dr","Lady"="Lady","Major"="Major","Master"="Master","Miss"="Miss","Mlle"="Mlle","Mme"="Mme","Rev"="Rev","Sir"="Sir","Countess"="Countess","Jonkheer"="Jonkheer")
               ),
    
    submitButton('Submit')
  
  ),
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    
    #h3("Probability of Survival"),
    #h4(textOutput("Probability")),
    
    
    #p("Overview of survival rate based on conditional inference tree model"),
    #h6(plotOutput("plot"))
    tabsetPanel(
    tabPanel("Prediction1_LR",h3("Probability of Survival"),h4(textOutput("LR")),"Note: This is the estimated survival probability based on logistic regression model"), 
    tabPanel("Prediction1_RF",h3("Probability of Death and Survival"),h4(textOutput("RF")),"Note: This is the estimated survival probability based on Random Forest model"),
    tabPanel("Overview", h3("Overview of survival rates"),plotOutput("plot"),"Note: This is the overall survival probability based on historical data with conditional inference tree model "),
    tabPanel("Summary","Note: This is the overall survival probability based on historical data with conditional inference tree model ", verbatimTextOutput("summary")," Note: a. 1-die 0-survive." ,
             "                       b. err means the error rate for a certain prediction.","
             For example, in [3] 5.3% err for 1 means the survival probability is 94.7%")
    
  )
)))