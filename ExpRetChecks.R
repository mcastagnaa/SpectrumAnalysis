# library(ggplot2)
# 


boxplot(FundsExp[,-1], las = 2)
ggplot(ExpRollMelt, aes(x=variable, y = Exposure)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  xlab("Funds")


ggplot(RetSdRollMelt, aes(x=variable, y = SdRet)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  xlab("Funds")

summary(lm(SdRet ~ Exposure, data = RegSet))

