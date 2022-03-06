overall_average_short = 0;
overall_average_mile = 0;
overall_average_mid = 0;
overall_average_long = 0;
overall_average_dirt = 0;

current_team_generation = -1;
current_team_viewing = createTeamBlank();

horseButtons = [[], [], [], [], []];

textShort = noone;
textMile = noone;
textMid = noone;
textLong = noone;
textDirt = noone;

resultsSearch = new ResultsSearch();

current_team_stats = [[], [], [], [], []];

most_races_run = 0;

for (var i = 0; i < 5; i++) {
  for (var j = 0; j < 3; j++) {
    current_team_stats[i][j] = new HorseStats();
  }
}

getMostRacesWon();