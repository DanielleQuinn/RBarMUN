# Shifting Substitution Cipher #
# DQ #
# Updated Sept 22, 2015 #

setcode<-function(m,a,b)
{
  alpha<-letters[c((a+1):length(letters),1:(a))]
  ALPHA<-LETTERS[c((a+1):length(LETTERS),1:(a))]
    m.vec<-c()
  output<-c()
  for(i in 1:nchar(m)){ m.vec.in<-substr(m,start=i, stop=i)
    m.vec<-c(m.vec,m.vec.in)}
  for(i in 1:length(m.vec)){
    if(m.vec[i] %in% letters){ output.in<-letters[which(alpha==m.vec[i])]
      output<-c(output, output.in)
      alpha<-alpha[c((b+1):length(alpha),1:(b))]}
    if(m.vec[i] %in% LETTERS){ output.in<-LETTERS[which(ALPHA==m.vec[i])]
      output<-c(output, output.in)
      ALPHA<-ALPHA[c((b+1):length(ALPHA),1:(b))]}
    if(!m.vec[i] %in% c(letters, LETTERS)){output.in<-m.vec[i]
      output<-c(output,output.in)}}
  readme<<-paste(output, collapse='')
  return(readme)
}

# m is a character string with the message you want to encrypt
# a and b are the keys to coding and solving the message, both need to be between 1 and 24

decode<-function(m,a,b)
{
  alpha<-letters[c((length(letters)-(a-1)):length(letters),1:(length(letters)-a))]
  ALPHA<-LETTERS[c((length(LETTERS)-(a-1)):length(LETTERS),1:(length(LETTERS)-a))]
  
  m.vec<-c()
  output<-c()
  for(i in 1:nchar(m))
  {
    m.vec.in<-substr(m,start=i, stop=i)
    m.vec<-c(m.vec,m.vec.in)
  }
  for(i in 1:length(m.vec))
  {
    if(m.vec[i] %in% letters)
    {
      output.in<-letters[which(alpha==m.vec[i])]
      output<-c(output, output.in)
      alpha<-alpha[c((length(alpha)-(b-1)):length(alpha),1:(length(alpha)-b))]      
    }
    if(m.vec[i] %in% LETTERS)
    {
      output.in<-LETTERS[which(ALPHA==m.vec[i])]
      output<-c(output, output.in)
      ALPHA<-ALPHA[c((length(ALPHA)-(b-1)):length(ALPHA),1:(length(ALPHA)-b))]      
    }
    if(!m.vec[i] %in% c(letters, LETTERS))
    {
      output.in<-m.vec[i]
      output<-c(output,output.in)
    }
  }
  readme2<<-paste(output, collapse='')
  return(readme2)
}
# m is a character string of the encrypted message
# a and b are the keys that were use to encrypt it

setcode("Hello world", 14,18)

decode(readme, 14, 18)
# or
decode("Tqfny oozbb", 14, 18)