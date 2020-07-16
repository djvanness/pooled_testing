rm(list = ls())
library(igraph)
library(InteractiveIGraph)
tmat_0 = matrix(data = c(1,1,0,0,
                       0,1,1,1,
                       0,0,1,0,
                       0,0,0,1),nrow = 4,ncol = 4,byrow = TRUE)
colnames(tmat_0) = rownames(tmat_0) = c("S","I","R","D")
network_0 = graph.adjacency(tmat_0)
plot(network_0)

tmat_1 = matrix(data = rep(0,27^2), nrow = 27,ncol = 27)
colnames(tmat_1) = rownames(tmat_1) = c("S", #1 Susceptible
                                        "ST", #2 Susceptible tested
                                        "ST+", #3 Susceptible awaiting results positive
                                        "ST-", #4 Susceptible awaiting results negative
                                        "SQ", #5 Susceptible quarantined
                                        "A", #6 Asymptomatic
                                        "AT", #7 Asymptomatic tested
                                        "AT+", #8 Asymptomatic awaiting results positive
                                        "AT-", #9 Asymptomatic awaiting results negative
                                        "AQ", #10 Asymptomatic quarantined
                                        "P", #11 Presymptomatic
                                        "PT", #12 Presymptomatic tested
                                        "PT+", #13 Presymptomatic awaiting results positive
                                        "PT-", #14 Presymptomatic awaiting results negative
                                        "PQ", #15 Presymptomatic quarantined
                                        "I", #16 Infected/symptomatic 
                                        "IT", #17 Infected/symptomatic tested
                                        "IT+", #18 Infected/symptomatic awaiting results positive
                                        "IT-", #19 Infected/symptomatic awaiting results negative
                                        "IQ", #20 Infected/symptomatic quarantine
                                        "H", #21 Hospitalized (no vent)
                                        "V", #22 Ventilated
                                        "RA", #23 Recovered after asymptomatic
                                        "RI", #24 Recovered after infected/symptomatic
                                        "RH", #25 Recovered after hospitalized (no vent)
                                        "RV", #26 Recovered after ventilated
                                        "D") #27 Dead
tmat_1[1,c(1,2,6,7,11,12)] = 1
tmat_1[2,c(3,4)] = 1
tmat_1[3,c(3,5,8,10,13,15)] = 1
tmat_1[4,c(4,1,6,9,11,14)] = 1
tmat_1[5,c(5,1,6,10,11,15)] = 1
tmat_1[6,c(6,7,23)] = 1
tmat_1[7,c(8,9)] = 1
tmat_1[8,c(8,10,23)] = 1
tmat_1[9,c(9,6,23)] = 1
tmat_1[10,c(10,23)] = 1
tmat_1[11,c(11,12,16,17)] = 1
tmat_1[12,c(13,14)] = 1
tmat_1[13,c(13,15,18,20)] = 1
tmat_1[14,c(14,11,16,19)] = 1
tmat_1[15,c(15,11,20)] = 1
tmat_1[16,c(16,17,21,22,24,27)] = 1
tmat_1[17,c(18,19)] = 1
tmat_1[18,c(18,20,21,22,24,27)] = 1
tmat_1[19,c(19,16,21,22,24,27)] = 1
tmat_1[20,c(20,21,22,24,27)] = 1
tmat_1[21,c(21,25,27)] = 1
tmat_1[22,c(22,26,27)] = 1
tmat_1[23,c(23)] = 1
tmat_1[24,c(24)] = 1
tmat_1[25,c(25)] = 1
tmat_1[26,c(26)] = 1
tmat_1[27,c(27)] = 1

network_1 = graph.adjacency(tmat_1)
plot.igraph(network_1, layout = layout_as_star(network_1),edge.arrow.size=.6,edge.loop.angle=1,edge.curved=.6)
plot.igraph(network_1, layout = layout_on_grid(network_1,width = 5),edge.arrow.size=.6,edge.loop.angle=1,edge.curved=.6)

tkplot(graph = network_1)
layout_nicely(network_1)














