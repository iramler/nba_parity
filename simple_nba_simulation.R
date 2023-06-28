nteams <- 30 # can pull this from the data
ngames <- 82 # can also pull this from the data


nsim = 1000
sim_season_winperc_sd <- rep(NA, nsim)

for(b in 1:nsim){
  
  # suffle all the wins around
  win_shuffle <- sample(x = rep(c(1,0), nteams*ngames/2))
  
  # place into each of the nteams (each row is a team)
  win_matrix <- matrix(win_shuffle, nr = nteams)
  
  # get win percentage for each row
  win_percentages <- apply(win_matrix, MARGIN = 1, FUN = mean)
  sim_season_winperc_sd[b] <- sd(win_percentages)
  
}

hist(sim_season_winperc_sd)
quantile(sim_season_winperc_sd, probs = c(0.025,0.5,0.975))
