

dir.create("Rlibs")



install.packages("xtable", lib = "Rlibs",
                 repos = "http://cran.case.edu")



mtSub.xtable <- xtable(mtSub)
print(mtSub.xtable, type = "html")



print(mtSub.xtable)


