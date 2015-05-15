library("httr");
library("jsonlite");
library("sqldf");
library("XML");

question1 <- function() {
    
    # used tutorial at
    # https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
    
    # 1. Find OAuth settings for github:
    #    http://developer.github.com/v3/oauth/
    oauth_endpoints("github")
    
    # 2 - configure app
    app = oauth_app("github", key="XXXX", secret="XXXXX");
    
    # 3. Get OAuth credentials
    github_token <- oauth2.0_token(oauth_endpoints("github"), app)
    
    # 4. Use API
    gtoken <- config(token = github_token)

    # GET data ( see https://developer.github.com/v3/repos/#get )
    req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
    stop_for_status(req)
    jsonContent <- content(req)
    
    # transform from JSON
    mtxData = jsonlite::fromJSON(toJSON(jsonContent));
    
    mtxData[c(2,45)]
    #message(paste("Resository created at ", mtxData[mtxData$name == "datasharing"]));
}

question2 <- function()
{
    querys = c("select pwgtp1 from acs",
               "select pwgtp1 from acs where AGEP < 50",
               "select * from acs where AGEP < 50 and pwgtp1",
               "select * from acs where AGEP < 50");
    
    acs=read.csv("getdata-data-ss06pid.csv", header = TRUE);
    
    for(i in 1:length(querys)) {
        message(paste("Query", i, "->", querys[i], ":"));
        str(sqldf(querys[i]));
    }
}

question3 <- function()
{
    querys = c("select distinct AGEP from acs",
               "select unique * from acs",
               "select unique AGEP from acs",
               "select AGEP where unique from acs");
    
    acs=read.csv("getdata-data-ss06pid.csv", header = TRUE);
    
    for(i in 1:length(querys)) {
        message(paste("Query", i, "->", querys[i], ":"));
        try(str(sqldf(querys[i])), silent = FALSE);
    }
}

question4 <- function() {
    
    #leemos el HTML
    con <- url("http://biostat.jhsph.edu/~jleek/contact.html");
    htmlContent <- readLines(con);
    close(con);
    
    message(paste("Tamaño del HTML:", length(htmlContent)));
    message(paste("Linea 10:", nchar(htmlContent[10])));
    message(paste("Linea 20:", nchar(htmlContent[20])));
    message(paste("Linea 30:", nchar(htmlContent[30])));
    message(paste("Linea 100:", nchar(htmlContent[100])));
}

question5 <- function() {
    data <- read.fwf("getdata-wksst8110.for", skip = 4, header = F,
                     widths = c(10, 9, 4, 9, 4, 9, 4, 9, 4));
    
    sum(data[4], na.rm = TRUE);
}

