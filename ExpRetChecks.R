library(ggplot2)
library(lattice)


#boxplot(FundsExp[,-1], las = 2)
ggplot(ExpRollMelt, aes(x=variable, y = Exposure)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  xlab("Funds")


ggplot(RetSdRollMelt, aes(x=variable, y = SdRet)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  xlab("Funds")

ggplot(RegSet, aes(x=Exposure, y = SdRet 
                   , colour = factor(variable)
       )) + 
  geom_point(shape=1) +    # Use hollow circles
  labs(x = "Eq.Funds exposure", y = "StDev of returns") +
  ggtitle(paste("Rolling", RollingObs, "observations"))
  
ggplot(RegSet, aes(x=Exposure, y = SdRet)) + 
  geom_smooth(method="lm") + 
  geom_point(shape=1) +    # Use hollow circles
  labs(x = "Eq.Funds exposure", y = "StDev of returns") +
  ggtitle(paste("Rolling", RollingObs, "observations"))

#xyplot(SdRet ~ Exposure | variable, data = RegSet)

summary(lm(SdRet ~ Exposure, data = RegSet))

