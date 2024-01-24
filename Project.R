library('markovchain')

################################################################################

data <- c(-5.7, -3.9, -7.1, -3.9, -5.6, -13.0, -10.3,
            + -7.6, -9.0, -2.6, -3.9, -0.7, -10.2, -6.6, -1.4,
            + -1.0, -5.5, -3.1, -1.1, 0.5, 2.9, 1.1, 0.8, 2.7, 1.2, 
            + 0.5, 0.9, 0.1, -1.2, -0.5, -1.5, # End of January
            + -1.4, -2.3, -1.0, 1.8, 2.2, 1.0, 6.0, 3.0, -0.1, 
            + -0.1, 1.2, -1.2, -1.8, -1.3, -3.1, -3.3, -5.0, 
            + -4.9, -5.6, -6.0, -6.5, -9.3, -0.4, 0.7, 0.6, 1.4, 
            + 1.6, 1.5, # End of February
            + -1.0, 0.5, 0.8, 4.7, 5.3, 5.6, 1.8, 2.0, 4.1, 2.7, 2.5, 0.9,
            + 0.2, 0.6, 2.8, 3.9, 2.3, 1.5, -0.2, 0.5, 0.0, 1.0, 4.0, 3.1, 
            + -2.6, -0.3, 4.5, 9.6, 9.5, 6.2, 5.8, # End of March
            + 6.0, 7.1, 10.0, 12.4, 13.0, 11.4, 12.6, 14.2, 14.0, 13.1, 10.2,
            + 10.4, 9.1, 10.3, 11.5, 10.8,10.1, 12.3, 12.4, 9.6, 10.5, 10.4, 
            + 9.0, 10.6, 11.4, 12.9, 13.8, 14.1, 14.0, 14.5, # End of April
            + 13.2, 12.2, 12.8, 11.6, 9.9, 10.9, 11.7, 15.9, 15.8, 16.6, 15.3, 
            + 11.5, 9.1, 9.2, 12.9, 13.6, 15.7, 16.8, 14.9, 16.2, 18.2, 17.3, 
            + 13.5, 14.0, 16.9, 17.9, 13.8, 12.7, 8.3, 10.6, 12.2, # End of May
            + 10.9, 11.8, 12.9, 9.7, 10.4, 12.7, 17.5, 17.9, 19.4, 17.2, 17.2, 
            + 12.0, 12.0, 16.0, 20.0, 16.3, 15.2, 17.9, 18.4, 11.9, 12.2, 13.1, 
            + 17.6, 19.2, 19.3, 20.2, 18.5, 19.9, 20.6, 22.1, # End of June
            + 22.2, 21.1, 20.3, 21.6, 20.6, 21.6, 21.6, 17.2, 16.4, 16.2, 14.4, 
            + 16.0, 18.2, 21.8, 25.4, 22.7, 23.2, 23.7, 15.6, 17.1, 18.6, 23.2, 
            + 26.2, 22.2, 16.1, 15.6, 16.2, 19.1, 18.7, 21.9, 21.2, # End of July
            + 20.2, 23.4, 22.0, 19.0, 19.5, 19.7, 19.7, 17.8, 17.5, 19.2, 17.2, 
            + 16.9, 15.6, 16.5, 17.4, 20.0, 22.3, 20.2, 17.2, 18.1, 19.5, 19.0, 
            + 16.1, 15.1, 18.0, 21.2, 21.3, 20.9, 16.9, 15.1, 15.2, # End of August
            + 16.9, 18.2, 20.2, 16.3, 14.2, 13.8, 14.7, 13.5, 15.7, 17.6, 16.8, 
            + 15.9, 14.5, 14.6, 15.7, 17.4, 17.8, 15.7, 12.6, 13.8, 16.2, 16.7, 
            + 17.3, 14.8, 13.6, 11.4, 12.7, 14.2, 13.7, 13.8, # End of September
            + 11.2, 9.5, 9.6, 11.2, 10.9, 10.7, 16.6, 17.4, 10.9, 7.3, 10.9, 
            + 8.7, 4.9, 1.2, 1.4, 2.6, 3.5, 3.5, 3.2, 5.2, 6.6, 6.6, 10.4, 
            + 8.1, 8.9, 10.1, 9.9, 7.5, 5.1, 2.4, 2.0, # End of October
            + -0.4, 0.3, -1.2, 1.0, 3.1, 2.0, 4.8, 5.4, 8.6, 5.5, 5.1, 5.2, 
            + 4.5, 4.6, 5.3, 4.0, 7.3, 8.8, 8.8, 4.7, 6.1, 4.2, 5.9, 8.8, 
            + 8.2, 3.3, 3.9, 2.9, 2.5, 8.8, # End of November
            + 9.1, 4.6, 0.4, 3.6, 3.7, 3.1, 4.6, 1.8, 4.5, 3.0, 2.1, -0.9, -3.9, 
            + -3.4, -3.1, -6.2, -8.9, -13.1, -14.3, -14.2, -10.6, -2.8, 2.5, 2.3,
            + 8.3, 2.8, -3.0, 0.1, -0.9, -0.7, 0.3) # End of December

sortedData <- sort(data)

temperatureStates <- c("very cold", "cold", "moderate", "warm", "hot")

matrix <- matrix(0, length(temperatureStates), length(temperatureStates), TRUE, dimnames = list(temperatureStates, temperatureStates))

for(i in 2:365) {
  f <- cut(data[i - 1], breaks = quantile(sortedData, probs = seq(0, 1, 1/length(temperatureStates))), labels = FALSE)
  s <- cut(data[i], breaks = quantile(sortedData, probs = seq(0, 1, 1/length(temperatureStates))), labels = FALSE)
  matrix[f, s] <- matrix[f, s] + 1
}

sums = rowSums(matrix)

for(i in 1:5) {
  for(j in 1:5) {
    matrix[i, j] <- matrix[i, j] / sums[i]
  }
}

mcTemperature <- new("markovchain", temperatureStates, TRUE, matrix, "Temperature")

################################################################################

initialState <- c(1, 0, 0, 0, 0)

after10Days <- initialState * (mcTemperature ^ 10)

weathersOfDays <- rmarkovchain(n=365, object=mcTemperature, t0="moderate")

print(weathersOfDays[1:10])

barplot(after10Days, names.arg = temperatureStates, col = "blue", main = "Probability distribution", ylab = "Probability", xlab = "Temperature states")

################################################################################

weatherFittedMLE <- markovchainFit(data = weathersOfDays, method = "mle", name = "Weather MLE")

predict(object = weatherFittedMLE$estimate, newdata = c("moderate", "cold"), n.ahead = 10)