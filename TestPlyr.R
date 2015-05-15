dfTest <- data.frame(label = as.character(rep(1:3, c(33,33,33))),
                        val = runif(99, min = -100, max = 100))
ddply(dfTest, ~label, colwise(mean))
tapply(dfTest$val, dfTest$label,mean)
