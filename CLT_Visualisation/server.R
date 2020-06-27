library(shiny)

shinyServer(function(input, output) {
    output$plot <- renderPlot({
        library(ggplot2)
        
        if (input$check_binom) {
            binom_means <- as.data.frame(matrix(nrow = input$slider_binom_sam, ncol = 2))
            set.seed(7345)
            for (i in 1:input$slider_binom_sam) {
                binom_means[i, 2] <- mean(rbinom(input$slider_binom_obs, input$slider_binom_obs, 0.5))
            }
            binom <- geom_histogram(data = binom_means, mapping = aes(x = scale(V2), y = ..density..),
                                    binwidth = 0.25, fill = "blue", colour = "darkblue", alpha = 0.1, lwd = 1)
            output$binom_mean <- renderText({
                signif(mean(scale(binom_means$V2)), 4)
            })
        }
        
        if (input$check_pois) {
            pois_means <- as.data.frame(matrix(nrow = input$slider_pois_sam, ncol = 2))
            set.seed(2634)
            for (i in 1:input$slider_pois_sam) {
                pois_means[i, 2] <- mean(rpois(input$slider_pois_obs, 5))
            }
            pois <- geom_histogram(data = pois_means, mapping = aes(x = scale(V2), y = ..density..),
                                    binwidth = 0.25, fill = "yellow", colour = "orange", alpha = 0.1, lwd = 1)
            output$pois_mean <- renderText({
                signif(mean(scale(pois_means$V2)), 4)
            })
        }
        
        if (input$check_exp) {
            exp_means <- as.data.frame(matrix(nrow = input$slider_exp_sam, ncol = 2))
            set.seed(2634)
            for (i in 1:input$slider_exp_sam) {
                exp_means[i, 2] <- mean(rexp(input$slider_exp_obs, 5))
            }
            expon <- geom_histogram(data = exp_means, mapping = aes(x = scale(V2), y = ..density..),
                                   binwidth = 0.25, fill = "green", colour = "darkgreen", alpha = 0.1, lwd = 1)
            output$exp_mean <- renderText({
                signif(mean(scale(exp_means$V2)), 4)
            })
        }
        
        ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) +
            theme_minimal() + labs(x = "x", y = "Proportion") +
            stat_function(fun = dnorm, geom = "line",
                          args = list(mean = 0, sd = 1),
                          lwd = 2, colour = "tomato") +
            {if (exists("binom")) get("binom")} +
            {if (exists("pois")) get("pois")} +
            {if (exists("expon")) get("expon")}
    })
})