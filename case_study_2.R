#Install packages using 
#install.packages("package name")

library(tibble)
library(dplyr)
library(broom)
library(ggplot2)

#look at data
data(mtcars)
names(mtcars)

#run model and visualizae coefficients
results <- lm(mpg ~ ., data = mtcars)
summary(results)

td <- broom::tidy(results)
td$conf.low <- td$estimate - td$std.error
td$conf.high <- td$estimate + td$std.error

ggplot2::ggplot(td, aes(estimate, term, color = term)) + 
  geom_point() + 
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high))


#subset by cyl and run model
results2 <- mtcars %>% dplyr::group_by(cyl) %>%  dplyr::do(fit = lm(mpg ~ ., data = .))

td <- results2 %>% broom::tidy(fit)

td$conf.low <- td$estimate - td$std.error
td$conf.high <- td$estimate + td$std.error


ggplot2::ggplot(td, aes(estimate, term, color = term)) + 
  geom_point() + 
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) + 
  facet_grid(.~cyl)


#reshape data
td_wide <- td %>% dplyr::select(cyl, term, estimate) %>% tidyr::spread(term, estimate)