library(shiny)

shinyUI(fluidPage(
    titlePanel("Visualising CLT"),
    h3("Documentation:"),
    ("This app is aimed at helping to visualise Central Limit Theorem (CLT). From
    Wikipedia we can read that 'when independent random variables are added, their
    properly normalized sum tends toward a normal distribution (informally a bell
    curve) even if the original variables themselves are not normally distributed'."),
    br(), br(),
    ("In the side bar, you can decide from what type of distribution (binomial,
    Poisson and/or exponential) you would like to sample, how many samples you
    would like to have, and how many observations you would like in each sample.
    These are then standardised before being plotted.
    You will see that as both the number of samples and the number of observations
    per sample increases, the distribution of the means of these samples tends
    towards a normal distribution."),
    br(), br(),
    ("You can display multiple distributions at a time. The normal distribution
    density plot is fixed and serves as a reference. It has a mean of 0 and standard
    deviation of 1."),
    br(), br(),
    sidebarLayout(
        sidebarPanel(
            h3("Pick and Choose"),
            
            checkboxInput("check_binom", "Binomial"),
            conditionalPanel(
                condition = "input.check_binom == true",
                h4("Samples from Binomial Distribution"),
                sliderInput("slider_binom_sam", "How many samples? The mean of
                            each of these will be taken and then plotted",
                            min = 1, max = 10000, value = 5),
                sliderInput("slider_binom_obs", "How many observations per sample?",
                            min = 1, max = 100, value = 2)),
            
            checkboxInput("check_pois", "Poisson"),
            conditionalPanel(
                condition = "input.check_pois == true",
                h4("Samples from Poisson Distribution"),
                sliderInput("slider_pois_sam", "How many samples? The mean of
                            each of these will be taken and then plotted",
                            min = 1, max = 10000, value = 5),
                sliderInput("slider_pois_obs", "How many observations per sample?",
                            min = 1, max = 100, value = 2)),
            
            checkboxInput("check_exp", "Exponential"),
            conditionalPanel(
                condition = "input.check_exp == true",
                h4("Samples from Exponential Distribution"),
                sliderInput("slider_exp_sam", "How many samples? The mean of
                            each of these will be taken and then plotted",
                            min = 1, max = 10000, value = 5),
                sliderInput("slider_exp_obs", "How many observations per sample?",
                            min = 1, max = 100, value = 2)),
        ),
        mainPanel(
            plotOutput("plot")
        ))
))