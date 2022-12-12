if (!require("pacman")) install.packages("pacman")

p_load(tidyverse)

gss_cat %>%
  select(relig,tvhours) %>%
  group_by(relig) %>%
  drop_na() %>%
  summarise(tvhours=mean(tvhours)) %>% 
  ggplot(aes(tvhours,fct_reorder(relig,tvhours))) + 
  geom_point()

gss_cat %>%
  select(marital,tvhours) %>%
  group_by(marital) %>%
  drop_na() %>%
  summarise(tvhours=mean(tvhours)) %>%
  ggplot(aes(tvhours,fct_reorder(marital,tvhours))) +
  geom_point()

gss_cat %>%
  ggplot(aes(fct_infreq(marital))) +
  geom_bar()

gss_cat %>%
  ggplot(aes(fct_rev(marital))) +
  geom_bar()

gss_cat %>%
  ggplot(aes(fct_infreq(partyid))) +
  geom_bar()

# --------------------------- Melhorar daqui p baixo ------------------------- #

gss_cat %>%
  fct_recode(partyid,
             'Republican, strong' = 'Strong republican',
             'Republican, weak'='Not str republican',
             'Independent,near republican'='Ind,near rep',
             'Independent,near democrat'='Ind,near dem',
             'Democrat, weak'='Not str democrat',
             'Democrat, strong'='Strong Democrat'
             )

fct_collapse(f,Liberal = c())