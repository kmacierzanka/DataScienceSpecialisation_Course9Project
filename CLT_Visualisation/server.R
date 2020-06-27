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
            binom <- geom_histogram(data = binom_means, mapping = aes(x = scale(V2), y = ..density..,
                                                                      fill = "blue", colour = "darkblue"),
                                    binwidth = 0.25, alpha = 0.1, lwd = 1)
        }
        
        if (input$check_pois) {
            pois_means <- as.data.frame(matrix(nrow = input$slider_pois_sam, ncol = 2))
            set.seed(2634)
            for (i in 1:input$slider_pois_sam) {
                pois_means[i, 2] <- mean(rpois(input$slider_pois_obs, 5))
            }
            pois <- geom_histogram(data = pois_means, mapping = aes(x = scale(V2), y = ..density..,
                                                                    fill = "yellow", colour = "orange"),
                                    binwidth = 0.25, alpha = 0.1, lwd = 1)
        }
        
        if (input$check_exp) {
            exp_means <- as.data.frame(matrix(nrow = input$slider_exp_sam, ncol = 2))
            set.seed(2634)
            for (i in 1:input$slider_exp_sam) {
                exp_means[i, 2] <- mean(rexp(input$slider_exp_obs, 5))
            }
            expon <- geom_histogram(data = exp_means, mapping = aes(x = scale(V2), y = ..density..,
                                                                    fill = "green", colour = "darkgreen"),
                                   binwidth = 0.25, alpha = 0.1, lwd = 1)
        }
        
        ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) +
            theme_minimal() + labs(x = "x", y = "Proportion") +
            stat_function(fun = dnorm, geom = "line",
                          args = list(mean = 0, sd = 1),
                          lwd = 2, colour = "tomato") +
            scale_fill_manual(name = "Sampled from:",
                              values = c({if (exists("binom")) "blue"},
                                         {if (exists("pois")) "yellow"},
                                         {if (exists("expon")) "green"}),
                              labels = c({if (exists("binom")) "Binomial"},
                                         {if (exists("pois")) "Poisson"},
                                         {if (exists("expon")) "Exponential"})) +
            scale_colour_manual(name = "Sampled from:",
                                values = c({if (exists("binom")) "darkblue"},
                                           {if (exists("pois")) "orange"},
                                           {if (exists("expon")) "darkgreen"}),
                                labels = c({if (exists("binom")) "Binomial"},
                                           {if (exists("pois")) "Poisson"},
                                           {if (exists("expon")) "Exponential"})) +
            {if (exists("binom")) get("binom")} +
            {if (exists("pois")) get("pois")} +
            {if (exists("expon")) get("expon")}
    })
})