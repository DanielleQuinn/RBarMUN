# ---- Russian Roulette Game ----
load_game<-function()
{
  chambers<<-c(1:8)
  bullet<<-sample(1:8,1)
}

trigger<-function()
{
  if(length(chambers)==0) print("Reload")
  if(length(chambers)>0)
  {
    gamble<-sample(chambers,1)
    chambers<<-chambers[!chambers==gamble]
    if(gamble==bullet) print("BOOM. Get back to work.")
    if(!gamble==bullet) print("*click*")
  }
  if(length(chambers)==1) if(chambers==bullet) print("Are you sure about this...?")
}

load_game()
trigger()
