# Setting Up siMMMulator

### Installing R

siMMMulator is an R-code package. Make sure you have the latest version of R installed. To install R, you can follow a tutorial provided by DataCamp.

### How to Install siMMMulator R-Package:

Use `remotes` package. 

```
# If you don't have remotes installed yet, first run this line: 
install.packages("remotes") 

# install siMMMulator 
remotes::install_github(
    repo = "facebookexperimental/siMMMulator"
)

library(siMMMulator)

```