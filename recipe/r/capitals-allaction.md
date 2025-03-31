+++
title = "capitals re-allaction"
date = Date(2017, 8, 16)
icon = "r-project"
tags = ["simulation", "capitals allocation", ]
+++

```r

reallocate_captials <- function(
    nPersons=100,  #  persons that models contains
    maxRound=360*50, # rounds
    allowLoan=TRUE, # addmit that one can loan from others
    iniCapValue=100, # initial captial
    iniCapVec=NULL, # initial captial vector
    plots=FALSE, # whether plot result
    inxSelected=NULL, # indice labeled for red in plots
    tax=FALSE, # where impose tax on top acctors
    taxOrigin=200,
    rseed=NULL){
  set.seed(ifelse(is.null(rseed), 2017, rseed))
  # initialize capitals vector
  if (is.null(iniCapVec)) {
    capitalVec <- rep(iniCapValue, nPersons)
  } else {
    capitalVec <- iniCapVec
    nPersons <- length(iniCapVec)
  }
  dailyPay <- rep(1, nPersons)  # initialize variality vector
  accrualProb <- rep(1/nPersons, nPersons)  # probability that everyone benifit
  colorInx <- rep("cyan", nPersons) 
  colorInx[inxSelected] <- "red"

  accrual <- result <- matrix(0, nr=nPersons, nc=maxRound)
  colnames(accrual) <- colnames(result) <- paste("Round", 1:maxRound, sep='')
  rownames(accrual) <- rownames(result) <- paste("Actor", 1:nPersons, sep='')
  result <- cbind(capitalVec, result)

  pb <- winProgressBar("MaxRound", "Round", 1, 100, 0)
  thresholds <- rep(1, nPersons)
  for(i in 1:maxRound){
    if(!allowLoan){thresholds <- result[, i] != 0}  # active actors
    activeActorsNum <- sum(thresholds)
    accrual[, i] <- rmultinom(1, activeActorsNum, accrualProb) - thresholds
    if(tax){
	  taxAccrual <- rep(0, nPersons)
	  topInx <- which(result[, i] > 200)
       botInx <- which(result[, i] <= 0)
	  ifelse(sum(botInx), taxAccrual[botInx] <- sum(result[topInx, i] - 200)/sum(botInx),
					   taxAccural <- sum(result[topInx, i] - 200) / nPersons)
	  taxAccrual[topInx] <- taxAccrual[topInx]-200
	  accrual[, i] <- accrual[, i] + taxAccrual
    }
    result[, i+1] <- result[, i] + accrual[, i]
    setWinProgressBar(pb, round(i*100/maxRound), sprintf("MaxRound: %d", maxRound), sprintf("Round %.f%%", floor(i*100/maxRound)))
  }
  close(pb)

  # plot the captials after re-allocation
  if(plots){
    figInx <- 0:(maxRound/30)
    picsNames <- paste("./Figures/Fig", figInx, ".pdf", sep="")
    pb <- winProgressBar("Plotting...", " ", 0, 100, 0)
    for(i in figInx){
      pdf(picsNames[i+1], height=10, width=10)
      ords <- order(result[, 30*i+1])
      barplot(result[ords, 30*i+1], col=colorInx[ords], 
      main=paste("Round", 10*i), xlab="Actors", ylab="Capitals",
      ylim=range(result)+c(-5, 5))
      dev.off()
      setWinProgressBar(pb, round(i*100/length(figInx)), "Plotting...", sprintf("%.f%%", round(i*100/length(figInx))))
    }
    close(pb)
  }
  return(result)
}

```
