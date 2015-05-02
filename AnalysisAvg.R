library(PerformanceAnalytics)
library(Hmisc)

RetSet <- subset(CombByDate,
                 Date > as.Date("2014-04-30") & 
                   Date <= as.Date("2015-04-30"),
                 select = c(Spec3Ret,
                                        Spec4Ret,
                                        Spec5Ret,
                                        Spec6Ret,
                                        Spec7Ret,
                                        Spec8Ret,
                                        IMA35Avg,
                                        IMA60Avg,
                                        IMA85Avg,
                                        IMAfAvg
                                        ))

chart.Correlation(RetSet, histogram = TRUE)

chart.CumReturns(RetSet,
                 wealth.index = TRUE,
                 legend.loc = "topleft",
                 begin = "first",
                 main="Value of $1",
                 ylab = "absolute returns",
                 xlab = NULL, 
                 date.format = "%b/%y")

chart.Boxplot(RetSet, sort.by = "variance")

chart.RiskReturnScatter(RetSet, 
                        add.boxplot = TRUE)

result <- t(table.Stats(RetSet[, , drop = F]))
textplot(format.df(result, na.blank=TRUE, numeric.dollar=FALSE, cdec=c(rep(1,2),rep(3,14))),
         rmar = 0.8, cmar = 1.5,  max.cex=.9, halign = "center", valign = "top",
         row.valign="center", wrap.rownames=10, wrap.colnames=10, mar = c(0,0,3,0)+0.1)
title(main="Statistics for relative returns")

table.DownsideRisk(RetSet[,1:10, drop=F], Rf = 0) #RawData.r[,7, drop=F])

#table.Drawdowns(RetSet[,1, drop=F])

