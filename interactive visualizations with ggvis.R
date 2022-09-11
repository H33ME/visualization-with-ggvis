# load the car and ggvis packages
library(car)
library(ggvis)

# consider the Salaries dataset
data("Salaries")

## first plot
# an interactive scatterplot of salary against years of service.
# use the radio buttons to color points according to either rank, discipline or sex.
# add legend and axis as required respectively

# radio button
color_points<- input_radiobuttons(
  c("Academic Rank"= "rank",
    "Research Discipline"= "discipline",
    "Sex"= "sex"), 
  map= as.name,
  label = "Color Points Using..."
)

# plot
Salaries %>% 
  ggvis(x= ~yrs.service, y=~salary, fill= color_points) %>% 
  layer_points() %>% 
  add_legend("fill", title="") %>% 
  add_axis("x", title= "Years of Service")

## second plot
# a static plot of kernel density estimate of salary distribution 
#split according to academic rank

Salaries %>% 
  ggvis(x=~salary, fill=~rank) %>% 
  group_by(rank) %>% 
  layer_densities() %>% 
  add_legend("fill", title= "Academic Ranks") %>% 
  add_axis("x", title= "Salary in Dollars")

## third plot 
# an interactive plot for the second plot above
# using adjust argument to control the degree of smoothness of the kernel estimate.

#adjust degree slider button

adjust_degree<- input_slider(0.2,2, label = "Smoothness")

#plot

Salaries %>% 
  ggvis(x=~salary, fill= ~rank) %>% 
  group_by(rank) %>% 
  layer_densities(adjust = adjust_degree) %>% 
  add_legend("fill", title="Academic Ranks") %>% 
  add_axis("x", title = "Salary in Dollars")

## fourth plot

#load the MASS package
library(MASS)

# consider the UScereal data frame
data("UScereal")

# recreate the UScereal data into cereals by factoring mfr variable into three levels
# namely "General Mills", "Kelloggs", "Other"
# also convert the shelf variable into a factor data type

cereal <- UScereal
levels(cereal$mfr)<- c('General Mills', "Kelloggs", rep("Other", 4))
cereal$shelf<- as.factor(cereal$shelf)


# set up a radio buttons to choose from manufacturer(mfr), shelf and vitamin variables.
# name the variable clearly
# set a label for this button
# name the object filler

filler <- input_radiobuttons(
  choices = c(
    "Manufacturer"= "mfr",
    "Shelf"= "shelf",
    "Vitamin Variables"= "vitamins"
  ),
  map = as.name,
  label = "Color the Points using the following..." 
)

# slider button for size and opacity
sizer <- input_slider(10, 300, label= "Point Sizes:")
opacityer<- input_slider(0.1,1, label= "Opacity:")
# plot A
# an interactive scatter plot of calories on protein

cereal %>% 
  ggvis(x= ~protein, y= ~calories, fill= filler, size:= sizer, opacity:= opacityer) %>% 
  layer_points() %>% 
  add_legend("fill", title= "") %>% 
  add_axis("x", title = "Grams of protein in One Portion") %>% 
  add_axis("y", title = "Number of calories in one portion")

# radio button for shape using the same variables as the one used in the radio button above
# name this variable shaper

shaper <- input_radiobuttons(
  choices = c(
    "Manufacturer" = "mfr",
    "Shelf" = "shelf",
    "Vitamin Variables" = "vitamins"
  ),
  map = as.name,
  label = "Shape the points with: "
)

# plot B
#recreate plot A above 
# add different shape using shaper radio button

cereal %>% 
  ggvis(
    x= ~protein, y= ~calories, fill= filler, size:= sizer, opacity:= opacityer, shape = shaper
    ) %>% 
  layer_points() %>% 
  add_legend("fill", title= "") %>% 
  add_legend("shape", title="", properties = legend_props(legend = list(y=100))) %>% 
  set_options(duration = 0) %>% 
  add_axis("x", title = "Grams of protein in One Portion") %>% 
  add_axis("y", title = "Number of calories in one portion")
