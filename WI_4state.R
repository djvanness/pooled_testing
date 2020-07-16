#Wisconsin Simulation

rm(list=ls())
library(expm)
library(ggplot2)
library(reshape2)
library(RColorBrewer)

#Markov Transition Kernel Update
updS = function(S,M,t) {t(S)%*%(M%^%t)}

N = 5.822E+6 #WI Population
t.max = 730 #Length of simulation in days
R_0 = 3 #Initial infectiousness coefficient
i.dur = 21 #Average duration of infectious state
g = 1/i.dur # I -> R+D
d = .008 #Infection fatality ratio

#CFR - case fatality ratio: #deaths/#confirmed cases : 2-3%
#IFR - infection fatality ration : #deaths/#infections = (confirmed + unconfirmed)
#Ascertainment ratio = #confirmed cases / #infections : 2%

#S, I, R, D

updM3 = function(M_t,S_t,b_){
  M_t[1,2] = b_*S_t[2]        #Infection proportional to prevalence with infectiousness factor
  M_t[1,1] = 1-sum(M_t[1,2:4])
  return(M_t)
}

#States: S, I, R, D

M_0 = matrix(data = c(NA,NA,0,0,
                      0,(1-g),g*(1-d),g*d,
                      0,0,1,0,
                      0,0,0,1), nrow = 4,ncol = 4,byrow = TRUE)

S_t = matrix(data = NA,nrow = t.max,ncol = 4)

#Assume 20 infections on 2/5 - based on 1 observed case and ascertainment rate of 5%

S_t[1,] = c(1-.25-(20/N),20/N,.25,0)

#b = g*R_0 #Simple force of infection
b = c()

#b[1:365] = g*R_0

b[1:20] = g*R_0 #Full force of infection through 2/25
b[20:39] = .8*g*R_0 #Limited social distancing - cut contacts in half
b[40:70] = .25*g*R_0 #
b[71:730] = .8*g*R_0 #


for (j in 1:(t.max-1)){
  #b = g*R_0*(j <= 90) + 0.5*g*R_0*(j > 90)
  M_1 = updM3(M_t = M_0,S_t = S_t[j,],b_=b[j])
  S_t[j+1,] = updS(S = S_t[j,],M = M_1, t = 1)
}

df = data.frame(t = 1:t.max, S_t)


names(df) = c("t", "S", "I", "R", "D")
dfm = melt(df ,  id.vars = 't', variable.name = 'state')
ggplot(dfm, aes(t,value)) + geom_line(aes(colour = state))

