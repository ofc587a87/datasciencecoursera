library("httr");
library("jsonlite");
library("sqldf");

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