

# Uttam Saket
# Capstone project no. 2 - Sentiment Analysis on "Reviews.csv dataset"

read.csv("D:\\Capstone project_IIT Madras_For certificate\\Reviews.csv")->review
View(review)
table(review$Score)

# since there is only one record where null value is found, we will omit that record
na.omit(review)->review
View(review)

# Now, we will remove all duplicate ratings as data reprocessing:

library(dplyr)
review %>%  group_by(UserId, ProductId) %>% mutate(N=n())->review
View(review)
table(review$N)

review %>% filter(N>1)-> duplicate_review
View(duplicate_review)
table(duplicate_review$Score)


review %>% filter(N==1)->unique_review
View(unique_review)
nrow(unique_review)
table(unique_review$Score)


# Answer to 1a - Highest and lowest rating for the products:

unique_review %>% group_by(ProductId) %>% summarize(number_rating_per_product=n())-> count_of_product_rating
View(count_of_product_rating)
range(count_of_product_rating$number_rating_per_product)

#  So, highest rating for any product is  588
#  and lowest rating for any product is   1


# Percentage wise product ratings for entire data:

my_table<-table(unique_review$Score)
my_prop<-prop.table(my_table)
cbind(my_table, my_prop)->percentage_wise_rating
class(percentage_wise_rating)
as.data.frame(percentage_wise_rating)->percentage_wise_rating
percentage_wise_rating$my_prop[ ]*100 ->percentage_wise_rating$my_prop
View(percentage_wise_rating)

# Rating                     1           2                3              4                 5
# No.                        3141        1966             2777           4935              21520
# percentage of 
# rating distribution        9.14%        5.72%           8.08%         14.37%              62.66%


####################################################

# Answer to 1 b. 
# Total no. of reviews by unique profiles:

View(unique_review)
nrow(unique_review)
table(unique_review$Score)

# So, the total no. of reviews by unique profiles = 34339

# No. of customers or profiles who have reviewed more than one product:

unique_review %>%  group_by(UserId) %>% mutate(Reviewed=n())->unique_review
View(unique_review)

unique_review %>% filter(Reviewed>1)->more_than_one
View(more_than_one)
nrow(more_than_one)
range(more_than_one$Reviewed)

# So, the total no. of customers or profiles who have reviewed more than one product = 8732


##########################################################


# Answer to 2. -- Sentiment Analysis

View(unique_review)
class(unique_review)
sentiment_analysis<- unique_review[ ,c(1,10)]
View(sentiment_analysis)

sentiment<-gsub("http.*", "", sentiment_analysis$Text)

sentiment<-gsub("https.*", "", sentiment)

sentiment<-gsub("#.*", "", sentiment)

sentiment<- gsub("@.*", "", sentiment)

class(sentiment)
View(sentiment)

### Finding 8 types of emotion & their frequency in all 34339 text reviews:

install.packages("syuzhet")
library(syuzhet)

emotion<- get_nrc_sentiment(sentiment)
emotion_df<- cbind(sentiment, emotion)
View(emotion_df)

### Finding the sentiment score :

View(sentiment)
sentiment.value<-get_sentiment(sentiment)
View(sentiment.value)

## Most positive sentiment value & review :

max(sentiment.value)
range(sentiment.value)
most_positive<- sentiment[sentiment.value==max(sentiment.value)]
most_positive

## Most negative sentiment value & review :

min(sentiment.value)
most_negative<- sentiment[sentiment.value==min(sentiment.value)]
most_negative


### Classification of Positive / Negative / Neutral reviews :

## Positive reviews -

positive_reviews<-sentiment[sentiment.value>0]
length(positive_reviews)
# 30554


## Negative reviews -

negative_reviews<-sentiment[sentiment.value<0]
length(negative_reviews)
# 3147


## Neutral reviews -

neutral_reviews<-sentiment[sentiment.value==0]
length(neutral_reviews)
# 638


###################### Thank You ############################




