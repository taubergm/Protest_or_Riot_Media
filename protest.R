  if (!require(ggplot2)) {
    install.packages("ggplot2", repos="http://cran.us.r-project.org")
  }
  if (!require(wordcloud)) {
    install.packages("wordcloud", repos="http://cran.us.r-project.org")
  }
  library(wordcloud)
  if (!require(tm)) {
    install.packages("tm", repos="http://cran.us.r-project.org")
  }
  library(tm)
  if (!require(slam)) {
    install.packages("slam", repos="http://cran.us.r-project.org")
  }
  if (!require(SnowballC)) {
    install.packages("SnowballC", repos="http://cran.us.r-project.org")
  }
  library(SnowballC)
  if (!require(dplyr)) {
    install.packages("dplyr", repos="http://cran.us.r-project.org")
  }
  library(dplyr)
  if (!require(tidytext)) {
    install.packages("tidytext", repos="http://cran.us.r-project.org")
  }
  library(tidytext)
  if (!require(textclean)) {
    install.packages("textclean", repos="http://cran.us.r-project.org")
  }
  library(textclean)
  if (!require(xts)) {
    install.packages("xts", repos="http://cran.us.r-project.org")
  }
  library(xts)
  
  
  trim <- function (x) gsub("^\\s+|\\s+$", "", x)
  
  GenerateWordClouds <- function(dt, data_name, redundant_words) {
    dt$title = gsub('\'',"",as.character(dt$title))
    dt$title = gsub('\"',"",as.character(dt$title))
    dt$title = gsub('\'s',"",as.character(dt$title))
    
    #dt_sent = unnest_tokens(dt, "sentences", content, token = "sentences")
    #subject_words = dt_sent[grep(data_name, dt_sent$sentences),]$sentences
    subject_words = dt$title
    subject_words = strip(subject_words, apostrophe.remove=TRUE)
  
    words = Corpus(VectorSource(subject_words))
    corpus <- tm_map(words, content_transformer(tolower))
    
    words = tm_map(words, stripWhitespace)
    words = tm_map(words, tolower)
    
    
    complete_stopwords = c(stopwords('english'), "will", "2020", "campaign", "says", "news", "new", "error", "said", "video")
    complete_stopwords  = c(complete_stopwords, redundant_words)
    complete_stopwords = c(complete_stopwords, "fox", "george", "floyd", "cnn", "cnnpolitics", "say", "man", "know", "trumps")
    # Generate wordcloud removing all stop words
    png(sprintf("./images/%s_stopwords_wordcloud.png", data_name))
    words = tm_map(words, removeWords, complete_stopwords)
    wordcloud(words, max.words = 40, min.freq=5, random.order=FALSE, colors=brewer.pal(8,"Dark2"))
    
    dev.off()
  }
  
  get_top_media = function(dt) {
    dt = dt[order(dt$Freq, decreasing=TRUE),]
    dt$Var1 = factor(dt$Var1, levels = dt$Var1[order(dt$Freq, decreasing=TRUE)])
    top_ten = dt[1:10,]
    return(top_ten)
  }
  
  outlet_bar_plotter = function(top_words, data_name){
    p = ggplot(top_words, aes(x=Var1, y=Freq)) + geom_bar(stat="identity") 
    p = p + ggtitle(sprintf("%s - Top Outlets", toupper(data_name)))
    p = p + theme(plot.title = element_text(hjust = 0.5))
    p = p + theme(axis.text.x=element_text(angle=90, hjust=1,face="bold"))
    p = p + theme(axis.text=element_text(size=16,face="bold"), axis.title=element_text(size=13), axis.title.x=element_blank())
    p = p + theme(plot.title = element_text(size=18,face="bold"))
    p = p + ylab("Number of Headlines") 
    ggsave(filename = sprintf("./images/%s_top.png", data_name) , plot=p, width=4.5, height=6)
  }
  
  polarity_histogram_plotter = function(data, data_name) {
    data = data[!is.na(data$polarity),]
    data$polarity = factor(data$polarity)
    xnames = c('far left', 'left', 'center', 'right', 'far right')
    p = ggplot(data, aes(x=polarity)) + geom_bar() 
    p = p + ggtitle(sprintf('Histogram of "%s" Articles', toupper(data_name)))
    p = p + theme(plot.title = element_text(hjust = 0.5))
    p = p + theme(axis.text.x=element_text(angle=90, hjust=1,face="bold"))
    p = p + theme(axis.text=element_text(size=13,face="bold"), axis.title=element_text(size=13), axis.title.x=element_blank())
    p = p + theme(plot.title = element_text(size=15,face="bold"))
    p = p + ylab("Number of Articles") 
    #p = p + xlab("news polarity") 
    p = p + scale_x_discrete(labels = xnames)
    ggsave(filename = sprintf("./images/%s_histogram.png", data_name) , plot=p, width=8, height=6)
  }
  # write nice histogram function
  
  
  setwd("/Users/mtauberg/projects/protests/")
  riot = read.csv("./csvs/riot_2020.csv")
  protests = read.csv("./csvs/protest_2020.csv")
  looting = read.csv("./csvs/looting_2020.csv")
  mob = read.csv("./csvs/mob_2020.csv")
  unrest = read.csv("./csvs/unrest_2020.csv")
  floyd = read.csv("./csvs/floyd_2020.csv")
  dc = read.csv("./csvs/dc_2020.csv")
  capitol_riot = read.csv("./csvs/capitol_riot_2020.csv")
  capitol_protest = read.csv("./csvs/capitol_protest_2020.csv")
  blm = read.csv("./csvs/blm_2020.csv")
  insurrection = read.csv("./csvs/insurrection_2020.csv")
  police = read.csv("./csvs/police_2020.csv")
  pb = read.csv("./csvs/pb_2020.csv")
  antifa = read.csv("./csvs/antifa_2020.csv")
  yemen = read.csv("./csvs/yemen_2020.csv")
  syria = read.csv("./csvs/syria_2020.csv")
  racism = read.csv("./csvs/racism_2020.csv")
  
  # use lower case titles for easy grepping
  riot$title = tolower(riot$title)
  protests$title = tolower(protests$title)
  looting$title = tolower(looting$title)
  unrest$title = tolower(unrest$title)
  mob$title = tolower(mob$title)
  floyd$title = tolower(floyd$title)
  dc$title = tolower(dc$title)
  blm$title = tolower(blm$title)
  insurrection$title = tolower(insurrection$title)
  police$title = tolower(police$title)
  pb$title = tolower(pb$title)
  antifa$title = tolower(antifa$title)
  mob$title = tolower(mob$title)
  yemen$title = tolower(yemen$title)
  syria$title = tolower(syria$title)
  
  # clean media names
  riot$media_name = trim(riot$media_name)
  protests$media_name = trim(protests$media_name)
  looting$media_name = trim(looting$media_name)
  unrest$media_name = trim(unrest$media_name)
  mob$media_name = trim(mob$media_name)
  floyd$media_name = trim(floyd$media_name)
  dc$media_name = trim(dc$media_name)
  blm$media_name = trim(blm$media_name)
  insurrection$media_name = trim(insurrection$media_name)
  police$media_name = trim(police$media_name)
  pb$media_name = trim(pb$media_name)
  antifa$media_name = trim(antifa$media_name)
  mob$media_name = trim(mob$media_name)
  yemen$media_name = trim(yemen$media_name)
  syria$media_name = trim(syria$media_name)
  
  # remove duplicates from everything
  riot = riot[grep("riot", riot$title),]
  riot = riot[!duplicated(riot[,c('title')], fromLast=FALSE),]
  unrest = unrest[grep("unrest", unrest$title),]
  unrest = unrest[!duplicated(unrest[,c('title')], fromLast=FALSE),]
  protests = protests[grep("protest", protests$title),]
  protests = protests[!duplicated(protests[,c('title')], fromLast=FALSE),]
  floyd = floyd[!duplicated(floyd[,c('title')], fromLast=FALSE),]
  looting = looting[grep("looting", looting$title),]
  looting = looting[!duplicated(looting[,c('title')], fromLast=FALSE),]
  police = police[grep("police", police$title),]
  police = police[!duplicated(police[,c('title')], fromLast=FALSE),]
  dc = dc[grep("capitol", dc$title),]
  dc = dc[!duplicated(dc[,c('title')], fromLast=FALSE),]
  blm = blm[grep("blm", blm$title),]
  blm = blm[!duplicated(blm[,c('title')], fromLast=FALSE),]
  mob = mob[grep("mob", mob$title),]
  mob = mob[!duplicated(mob[,c('title')], fromLast=FALSE),]
  yemen = yemen[grep("yemen", yemen$title),]
  yemen = yemen[!duplicated(yemen[,c('title')], fromLast=FALSE),]
  syria = syria[grep("syria", syria$title),]
  syria = syria[!duplicated(syria[,c('title')], fromLast=FALSE),]
  
  floyd_riot = floyd[grep("riot", floyd$title), ]
  floyd_protest = floyd[grep("protest", floyd$title), ]
  
  
  dc_riot = dc[grep("riot", dc$title), ]
  dc_riot = dc_riot[!duplicated(dc_riot[,c('title')], fromLast=FALSE),]
  dc_protest = dc[grep("protest", dc$title), ]
  dc_protest = dc_protest[!duplicated(dc_protest[,c('title')], fromLast=FALSE),]
  
  
  # capitol hill stuff only after 1/6/2020
  dc$publish_date = substring(dc$publish_date, 1, 19)
  dc$publish_date = as.Date(dc$publish_date)
  dc = dc[dc$publish_date > as.Date('2021-01-05'),]  
  
  # get list of media entities
  media_list = trim(protests$media_name)
  media_list = levels(factor(media_list))
  
  
  
  # compare to this - https://www.improvethenews.org/
  
  
  # POLARITY OF ARTICLES
  polarity_histogram_plotter(floyd, "All George Floyd Articles In Sample")
  polarity_histogram_plotter(floyd_riot, "Floyd + Riot")
  polarity_histogram_plotter(floyd_protest, "Floyd + Protest")
  polarity_histogram_plotter(riot, "Riot")
  polarity_histogram_plotter(protests, "Protest")
  polarity_histogram_plotter(unrest, "Unrest")
  polarity_histogram_plotter(looting, "Looting")
  polarity_histogram_plotter(pb, "Proud Boys")
  polarity_histogram_plotter(antifa, "Antifa")
  polarity_histogram_plotter(insurrection, "Insurrection")
  polarity_histogram_plotter(dc, "Capitol")
  polarity_histogram_plotter(dc_riot, "Capitol")
  polarity_histogram_plotter(dc_protest, "Capitol")
  polarity_histogram_plotter(blm, "BLM")
  polarity_histogram_plotter(mob, "Mob")
  polarity_histogram_plotter(yemen, "Yemen")
  polarity_histogram_plotter(syria, "Syria")
  polarity_histogram_plotter(racism, "Racism")
  
  # TOP OUTLETS PER TOPIC
  floyd_media = as.data.frame(table(floyd$media_name))
  top_floyd_media = get_top_media(floyd_media)
  outlet_bar_plotter(top_floyd_media, "floyd")
  
  police_media = as.data.frame(table(police$media_name))
  top_police_media = get_top_media(police_media)
  outlet_bar_plotter(top_police_media, "police")
  
  unrest_media = as.data.frame(table(unrest$media_name))
  top_unrest_media = get_top_media(unrest_media)
  outlet_bar_plotter(top_unrest_media, "unrest")
  
  riot_media = as.data.frame(table(riot$media_name))
  top_riot_media = get_top_media(riot_media)
  outlet_bar_plotter(top_riot_media, "riot")
  
  protest_media = as.data.frame(table(protests$media_name))
  top_protest_media = get_top_media(protest_media)
  outlet_bar_plotter(top_protest_media, "protest")
  
  looting_media = as.data.frame(table(looting$media_name))
  top_looting_media = get_top_media(looting_media)
  outlet_bar_plotter(top_looting_media, "looting")
  
  looting_media = as.data.frame(table(looting$media_name))
  top_looting_media = get_top_media(looting_media)
  outlet_bar_plotter(top_looting_media, "looting")
  
  capitol_media = as.data.frame(table(dc$media_name))
  top_capitol_media = get_top_media(capitol_media)
  outlet_bar_plotter(top_capitol_media, "capitol")
  
  pb_media = as.data.frame(table(pb$media_name))
  top_pb_media = get_top_media(pb_media)
  outlet_bar_plotter(top_pb_media, "proud boys")
  
  antifa_media = as.data.frame(table(antifa$media_name))
  top_antifa_media = get_top_media(antifa_media)
  outlet_bar_plotter(top_antifa_media, "antifa")
  
  dc_riot_media = as.data.frame(table(dc_riot$media_name))
  top_dc_riot_media = get_top_media(dc_riot_media)
  outlet_bar_plotter(top_dc_riot_media, "capitol riot")
  
  dc_protest_media = as.data.frame(table(dc_protest$media_name))
  top_dc_protest_media = get_top_media(dc_protest_media)
  outlet_bar_plotter(top_dc_protest_media, "capitol protest")
  
  insurrection_media = as.data.frame(table(insurrection$media_name))
  top_insurrection_media = get_top_media(insurrection_media)
  outlet_bar_plotter(top_insurrection_media, "capitol protest")
  
  blm_media = as.data.frame(table(blm$media_name))
  top_blm_media = get_top_media(blm_media)
  outlet_bar_plotter(top_blm_media, "capitol protest")
  
  mob_media = as.data.frame(table(mob$media_name))
  top_mob_media = get_top_media(mob_media)
  outlet_bar_plotter(top_mob_media, "mob")
  
  yemen_media = as.data.frame(table(yemen$media_name))
  top_yemen_media = get_top_media(yemen_media)
  outlet_bar_plotter(top_yemen_media, "yemen")
  
  syria_media = as.data.frame(table(syria$media_name))
  top_syria_media = get_top_media(syria_media)
  outlet_bar_plotter(top_syria_media, "syria")
  
  
  mob_media = as.data.frame(table(mob$media_name))
  top_mob_media = get_top_media(mob_media)
  outlet_bar_plotter(top_mob_media, "capitol protest")
  # FOX VS CNN
  
  # specific examples of CNN vs FoxNews
  cnn_protest = protests[protests$media_name == "CNN",]
  cnn_riot = riot[riot$media_name == "CNN",]
  cnn_looting = looting[looting$media_name == "CNN",]
  cnn_blm = blm[blm$media_name == "CNN",]
  cnn_floyd = floyd[floyd$media_name == "CNN",]
  cnn_dc = dc[dc$media_name == "CNN",]
  cnn_unrest = unrest[unrest$media_name == "CNN",]
  cnn_insurrection = insurrection[insurrection$media_name == "CNN",]
  cnn_police = police[police$media_name == "CNN",]
  cnn_pb = pb[pb$media_name == "CNN",]
  cnn_antifa = antifa[antifa$media_name == "CNN",]
  cnn_dc = dc[dc$media_name == "CNN",]
  cnn_mob = mob[mob$media_name == "CNN",]
  
  fox_protest = protests[protests$media_name == "Fox News",]
  fox_riot = riot[riot$media_name == "Fox News",]
  fox_looting = looting[looting$media_name == "Fox News",]
  fox_blm = blm[blm$media_name == "Fox News",]
  fox_floyd = floyd[floyd$media_name == "Fox News",]
  fox_dc = dc[dc$media_name == "Fox News",]
  fox_unrest = unrest[unrest$media_name == "Fox News",]
  fox_insurrection = insurrection[insurrection$media_name == "Fox News",]
  fox_police = police[police$media_name == "Fox News",]
  fox_pb = pb[pb$media_name == "Fox News",]
  fox_antifa = antifa[antifa$media_name == "Fox News",]
  fox_dc = dc[dc$media_name == "Fox News",]
  fox_mob = mob[mob$media_name == "Fox News",]
  
  
  remove_words = c("police", "fox", "cnn", "news", "riot", "protest", "protests", "protesters", "riots", "unrest")
  GenerateWordClouds(fox_riot, "fox_riot", remove_words )
  GenerateWordClouds(cnn_riot, "cnn_riot", remove_words )
  GenerateWordClouds(fox_protest, "fox_protest", remove_words )
  GenerateWordClouds(cnn_protest, "cnn_protest", remove_words )
  GenerateWordClouds(fox_unrest, "fox_unrest", remove_words )
  GenerateWordClouds(cnn_unrest, "cnn_unrest", remove_words )
  
  remove_words = c("floyd", "floyds", "police", "death")
  GenerateWordClouds(fox_floyd, "fox_floyd",  remove_words )
  GenerateWordClouds(cnn_floyd, "cnn_floyd",  remove_words )
  
  remove_words = c("police", "officer", "officers", "chief")
  GenerateWordClouds(fox_police, "fox_police", remove_words )
  GenerateWordClouds(cnn_police, "cnn_police", remove_words )
  
  remove_words = c("looting")
  GenerateWordClouds(fox_looting, "fox_looting",  remove_words )
  GenerateWordClouds(cnn_looting, "cnn_looting",  remove_words )
  
  remove_words = c("capitol")
  GenerateWordClouds(fox_dc, "fox_capitol",  remove_words )
  GenerateWordClouds(cnn_dc, "cnn_capitol",  remove_words )
  
  remove_words = c("proud", "boys")
  GenerateWordClouds(fox_pb, "fox_proud_boys",  remove_words )
  GenerateWordClouds(cnn_pb, "cnn_proud_boys",  remove_words )
  
  remove_words = c("antifa")
  GenerateWordClouds(fox_antifa, "fox_antifa",  remove_words )
  GenerateWordClouds(cnn_antifa, "cnn_antifa",  remove_words )
  
  remove_words = c("black", "lives", "matter", "blm")
  GenerateWordClouds(fox_blm, "fox_blm",  remove_words )
  GenerateWordClouds(cnn_blm, "cnn_blm",  remove_words )
  
  remove_words = c("mob")
  GenerateWordClouds(fox_mob, "fox_mob",  remove_words )
  GenerateWordClouds(cnn_mob, "cnn_mob",  remove_words )
  
  # insurrection as a special case
  
  
  remove_words = c("insurrection")
  GenerateWordClouds(insurrection, "insurrection_article",  remove_words )
  
  
  insurrection = insurrection[grep("insurrection", insurrection$title),]
  insurrection = insurrection[!duplicated(insurrection[,c('title')], fromLast=FALSE),]
  cnn_insurrection = insurrection[insurrection$media_name == "CNN",]
  fox_insurrection = insurrection[insurrection$media_name == "Fox News",]
  GenerateWordClouds(insurrection, "insurrection_headline",  remove_words )
  

  
  
  
  
  
