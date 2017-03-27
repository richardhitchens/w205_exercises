import tweepy

consumer_key = "N0SsOB0IyPTOxuFBuKQkFRyao";

consumer_secret = "L17MK9XvFnY5HqbpnVC5rvcg5tyiMziQkIZLxuLD3fmq1eDxZ5";

access_token = "4759717250-3IuExWW1GYMSttzaDxH9eeQCrx28ytov8nBqFoV";

access_token_secret = "1QMpNwIOU7S3CuBjY9Y4296D3j9FpysnbqiRGkb3sOwxP";

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



