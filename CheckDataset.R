.pardefault <- par()

par(mfrow = c(2,3), mar= c(3,3,2,1))
boxplot(CombByDate$Spec3Ret, main = "Spectrum 3")
boxplot(CombByDate$Spec4Ret, main = "Spectrum 4")
boxplot(CombByDate$Spec5Ret, main = "Spectrum 5")
boxplot(CombByDate$Spec6Ret, main = "Spectrum 6")
boxplot(CombByDate$Spec7Ret, main = "Spectrum 7")
boxplot(CombByDate$Spec8Ret, main = "Spectrum 8")

par(mfrow = c(2,2), mar= c(3,3,2,1))
boxplot(CombByDate$IMA35Med, main = "IMA med 0-35")
boxplot(CombByDate$IMA60Med, main = "IMA med 20-60")
boxplot(CombByDate$IMA85Med, main = "IMA med 40-85")
boxplot(CombByDate$IMAfMed, main = "IMA med Flex")

par(mfrow = c(2,2), mar= c(3,3,2,1))
boxplot(CombByDate$IMA35Med, main = "IMA avg 0-35")
boxplot(CombByDate$IMA60Med, main = "IMA avg 20-60")
boxplot(CombByDate$IMA85Med, main = "IMA avg 40-85")
boxplot(CombByDate$IMAfMed, main = "IMA avg Flex")


par(.pardefault)