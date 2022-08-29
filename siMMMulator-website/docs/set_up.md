# Setting Up siMMMulator

### Installing R

siMMMulator is an R-code package. Make sure you have the latest version of R installed. To install R, you can follow a tutorial provided by DataCamp.

### How to Install siMMMulator R-Package:

Use `remotes` package. 

```

install.packages("remotes") # Run this line if you do not have remotes installed yet

library(remotes)

remotes::install_github(
    repo = "facebookexperimental/siMMMulator"
)

library(siMMMulator)

```