# ---- Set Working Directory ----
setwd("C:/Users/danie/OneDrive/DQ_Documents/R/Shiny Development")

# ---- Load Packages ----
library(miniUI)
library(shiny)
library(ggplot2)

requiredpassword<-"OSC123"

# ---- FUNCTION: get_password() ----
accesspassword<-function()
{
  ui<-miniPage(gadgetTitleBar("Please enter password"),
               miniContentPanel(passwordInput("password","")))
  server<-function(input, output)
  {
    observeEvent(input$done,
                 {
                   if(input$password==requiredpassword) {access<<-input$password}
                   if(!input$password==requiredpassword) {access<<-"N"}
                   stopApp(if(input$password==requiredpassword){"Thank you!"} else {"Incorrect Password"})
                 })
    observeEvent(input$cancel,
                 {
                   stopApp("Goodbye")
                 })
  }
  runGadget(ui, server)
}

# ---- Run get_password() ----
accesspassword()

# ---- FUNCTION: choose_points() ----
choose_points<-function(data, x, y)
{
  if(!'access' %in% ls(envir=.GlobalEnv)) {print("Password Required. Please run acesspassword()")}
  if('access' %in% ls(envir=.GlobalEnv)) if(!access==requiredpassword) {print("Password Required. Please run accesspassword()")}
  if('access' %in% ls(envir=.GlobalEnv)) if(access==requiredpassword)
  {
    ui<-miniPage(
      gadgetTitleBar("Select Your Points"),
      miniContentPanel(plotOutput("plot1", height="100%", brush="brush")),
      miniButtonBlock(
        actionButton("add","",icon=icon("thumbs-up")),
        actionButton("sub","",icon=icon("thumbs-down")),
        actionButton("none","",icon=icon("ban")),
        actionButton("all","",icon=icon("refresh"))))
    server<-function(input, output)
    {
      vals<-reactiveValues(keep=rep(TRUE, nrow(data)))
      output$plot1<-renderPlot({
        keep<-data[vals$keep,,drop=FALSE]
        exclude<-data[!vals$keep,,drop=FALSE]
        ggplot(keep)+
          geom_point(aes(x=x,y=y), data=exclude, col="grey50")+
          geom_point(aes(x=x,y=y))
      })
      selected<-reactive({
        brushedPoints(data, input$brush, allRows=TRUE)$selected
      })
      observeEvent(input$add, vals$keep<-vals$keep|selected())
      observeEvent(input$sub, vals$keep<-vals$keep & !selected())
      observeEvent(input$all, vals$keep<-rep(TRUE, nrow(data)))
      observeEvent(input$none, vals$keep<-rep(FALSE, nrow(data)))
      observeEvent(input$done, {stopApp(vals$keep)})
      observeEvent(input$cancel, {stopApp(NULL)})
    }
    runGadget(ui, server)
  }
}

# ---- Create dummy data set ----
mydata<-data.frame(x=rnorm(100, mean=10, sd=6),
                   y=rnorm(100, mean=50, sd=20))

# ---- Run choose_points() ----
mydata$includepoints<-choose_points(mydata, x,y)

# ---- Check results ----
choose_points(mydata[mydata$includepoints==TRUE,],x,y)
