library(stargazer)

stargazer(SDonEXP, table.placement = "h", title = "Regression results",
          style = "aer", out="Regression3.tex", digits = 5)

