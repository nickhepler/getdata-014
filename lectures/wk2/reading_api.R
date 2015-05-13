#  reading_api.R
#  Reading Data from APIs

require(httr)
myapp <- oauth_app("twitter",
                  key="g3hZF3yMnG5Ss4icLW3SlJVHQ",
                  secret="9hDnoFv3Uo8bTSZtGo6gczaPvKjGbfqLPwPJ9h26Fb6zBZDkW7")
sig <- sign_oauth1.0(myapp,
                    token = "21576971-hF57z1pGUfNpWQL9bTm9qvbd0BHMNTExmvr2XCP8S",
                    token_secret = "lmXtbstH7bLXRSSkhnTqColsRx5F97XGi4zhjPqGl2hXx")
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

detach("package:httr", unload=TRUE)
