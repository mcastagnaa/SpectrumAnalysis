library(xlsx)
# example of reading xlsx sheets
#file <- system.file("tests", "IMA201504.xlsx", package = "xlsx")
res <- read.xlsx("IMA201504.xlsx", 1, startrow=10, endrow=20) # read the second sheet
