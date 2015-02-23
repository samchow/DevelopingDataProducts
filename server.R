library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  set.seed(12345)
  idxs <- sample(1:nrow(diamonds), 10000)
  ddata <- diamonds[idxs,c("cut", "color", "carat", "price")]
  cuts <- unique(ddata[,"cut"])
  colors <- unique(ddata[,"color"])
  
  all_colors <- rep(colors, length(cuts))
  all_cuts <- NULL
  for (ct in cuts) {
    all_cuts <- c(all_cuts, rep(ct, length(colors)))
  }
  
  combo <- data.frame(cut=all_cuts, color=all_colors)
  
  pred0 <- lm(price ~ carat -1, data=ddata)
  pred1 <- lm(price ~ carat, data=ddata)
  pred2 <- lm(price ~ carat + factor(color) -1 , data=ddata)
  pred3 <- lm(price ~ carat + factor(cut) -1 , data=ddata)
  
  cSize <- nrow(combo)
    
  output$mytable <- renderDataTable({
    iCarat <- input$carat
    in_carats <- rep(iCarat, cSize)
    temp_df <- cbind(combo, carat=in_carats)
    prices0 <- predict(pred0, newdata=temp_df)
    prices1 <- predict(pred1, newdata=temp_df)
    prices2 <- predict(pred2, newdata=temp_df)
    prices3 <- predict(pred3, newdata=temp_df)
    prices <- round(prices0, 0)
    for (i in  1:cSize) {
      prices[i] <- max(prices[i], prices1[i])
      avg_price <- mean(prices2[i], prices3[i])
      if (iCarat >= 1.0 & avg_price > prices[i]) {
        prices[i] <- round(avg_price, 0)
      } else {
        prices[i] <- round(max(prices[i], avg_price), 0)
      } 
    }
    cbind(temp_df[,-3], EstimatedPrice=prices)
  })
})
