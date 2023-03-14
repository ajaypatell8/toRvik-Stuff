#install
if (!requireNamespace('devtools', quietly = TRUE)){
  install.packages('devtools')
}
devtools::install_github("andreweatherman/toRvik") 

#libraries
library(toRvik)
library(gt)
library(tidyverse)
library(gtExtras)

#single game prediction
toRvik::bart_game_prediction(team = "Indiana",
                             opp = "Miami FL")

#checking docs
?bart_game_prediction
?bart_tournament_prediction
?bart_tourney_odds

#full tourney odds
bart_tourney_odds(year = current_season()) %>% 
  arrange(desc(champ)) %>% 
  filter(seed <= 8) %>% 
  gt_preview(top_n =10, bottom_n = 10) %>% 
  gt_hulk_col_numeric(columns = c("champ")) %>% 
  tab_header(title = "Torvik's Title Favorites", subtitle = "8 Seeds and Above | Data: toRvik") %>% 
  gt_theme_538()
  
#see team names
toRvik::bart_teams() %>% View()

#run pod sims
bart_tournament_prediction(teams=c("Miami FL", "Kent St.", "Indiana", "Drake"), 
                            sims=100, seed=2) %>% 
  mutate(r32 = finals / 100,
         r16 = champ / 100) %>% 
  gt() %>% 
  gt_hulk_col_numeric(columns = c("r16")) %>%
  fmt_percent(columns = c("r32", "r16"), decimals = 0) %>% 
  tab_header("Pod Simulations", subtitle = "Data: toRvik | @ajaypatell8") %>% 
  gt_theme_538() 

