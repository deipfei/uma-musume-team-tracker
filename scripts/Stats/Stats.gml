// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function setOverallAverages(team_generation){
  oStatsController.overall_average_short = calculateOverallAverage(SHORT_IND, team_generation);
  oStatsController.overall_average_mile = calculateOverallAverage(MILE_IND, team_generation);
  oStatsController.overall_average_mid = calculateOverallAverage(MID_IND, team_generation);
  oStatsController.overall_average_long = calculateOverallAverage(LONG_IND, team_generation);
  oStatsController.overall_average_dirt = calculateOverallAverage(DIRT_IND, team_generation);
  if (oStatsController.textShort != noone) {
    oStatsController.textShort.text = "Overall Avg: " + string(oStatsController.overall_average_short);
    oStatsController.textMile.text = "Overall Avg: " + string(oStatsController.overall_average_mile);
    oStatsController.textMid.text = "Overall Avg: " + string(oStatsController.overall_average_mid);
    oStatsController.textLong.text = "Overall Avg: " + string(oStatsController.overall_average_long);
    oStatsController.textDirt.text = "Overall Avg: " + string(oStatsController.overall_average_dirt);
  } else {
    oStatsController.textShort = new EmuText(120, 165, 284, 32, "Overall Avg: " + string(oStatsController.overall_average_short));
    oStatsController.textMile = new EmuText(352, 165, 284, 32, "Overall Avg: " + string(oStatsController.overall_average_mile));
    oStatsController.textMid = new EmuText(584, 165, 284, 32, "Overall Avg: " + string(oStatsController.overall_average_mid));
    oStatsController.textLong = new EmuText(816, 165, 284, 32, "Overall Avg: " + string(oStatsController.overall_average_long));
    oStatsController.textDirt = new EmuText(1078, 165, 284, 32, "Overall Avg: " + string(oStatsController.overall_average_dirt));
  }
}

function calculateHorseAverage(horseUuid, team_generations) {
  var numRaces = 0;
  var totalPlacement = 0;
  
  for (var i = 0; i < array_length(oUmaTeamTracker.data.results); i++) {
    var currentResult = oUmaTeamTracker.data.results[i];
    
    if ((team_generations == noone || array_length(team_generations) == 0) || array_contains(team_generations, currentResult.team_generation)) {
      for (var j = 0; j < 15; j++) {
         var currentRaceResult = currentResult.results[j];
         
         if (currentRaceResult.horse_uuid == horseUuid) {
           numRaces += 1;
           totalPlacement += currentRaceResult.position;
         }
      }
    }
  }
  
  if (numRaces == 0) return 0;
  
  return totalPlacement / numRaces;
}

function calculateOverallAverage(type, team_generation) {
  var numRaces = 0;
  var totalPlacement = 0;
  
  for (var i = 0; i < array_length(oUmaTeamTracker.data.results); i++) {
    var currentResult = oUmaTeamTracker.data.results[i];
    
    if (team_generation == -1 || currentResult.team_generation == team_generation) {    
      for (var j = 0; j < 15; j++) {
        var currentRaceResult = currentResult.results[j];
        
        if (currentRaceResult.race_type == type) {
          numRaces += 1;
          totalPlacement += currentRaceResult.position;
        }
      } 
    }
  }
  
  if (numRaces == 0) return 0;
  
  return totalPlacement / numRaces;
}

function setStatsTeam() {
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      oStatsController.horseButtons[i][j].horse = oStatsController.current_team_viewing.horses[i][j];
    }
  }
}

function HorseStats() constructor {
  self.overall_races = 0;
  self.overall_average = 0;
  self.overall_wins = 0;
  self.overall_win_rate = 0;
  self.overall_potential_wins = 0;
  self.overall_potential_rate = 0;
  
  self.generation_races = 0;
  self.generation_average = 0;
  self.generation_wins = 0;
  self.generation_win_rate = 0;
  self.generation_potential_wins = 0;
  self.generation_potential_rate = 0;
  
  toString = function() {
    return "Overall Races: " + string(overall_races) + "\n" + 
           "Overall Average: " + string(overall_average) + "\n" + 
           "Overall Wins: " + string(overall_wins) + "\n" + 
           "Overall Win %: " + string(overall_win_rate) + "\n" + 
           "Overall Potential Wins: " + string(overall_potential_wins) + "\n" + 
           "Overall Potential Win %: " + string(overall_potential_rate) + "\n" + 
           "\n" + 
           "Generation Races: " + string(generation_races) + "\n" + 
           "Generation Average: " + string(generation_average) + "\n" + 
           "Generation Wins: " + string(generation_wins) + "\n" + 
           "Generation Win %: " + string(generation_win_rate) + "\n" + 
           "Generation Potential Wins: " + string(generation_potential_wins) + "\n" + 
           "Generation Potential Win %: " + string(generation_potential_rate) + "\n";
  }
}

function getHorseStats(i, j) {
  return oStatsController.current_team_stats[i][j]; 
}

function generateAllStats(generation) {
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      var currentHorse = oStatsController.current_team_viewing.horses[i][j];
      generateStats(currentHorse, generation, i, j);
    }
  }
}

function generateStats(horseObj, generation, i, j) {
  
  generateOverallStats(horseObj, i, j);
  
  generateGenerationStats(horseObj, generation, i, j);
}

function generateOverallStats(horseObj, i, j) {
  var currStats = oStatsController.current_team_stats[i][j];
  var generations = getHorseGenerations(horseObj);
  RESULTS.reset().filterByTeamGeneration(generations).saveBackup().filterByHorseObj(horseObj);
  //build calculateAverage function on resultsSearch that can optionally take a horse uuid. If it exists, will only average those wins. If not, will average all)
  currStats.overall_races = RESULTS.length();
  currStats.overall_average = RESULTS.calculateAverage();
  
  RESULTS.filterByWin();
  
  currStats.overall_wins = RESULTS.length();
  currStats.overall_win_rate = (currStats.overall_wins / currStats.overall_races) * 100;
  
  RESULTS.restoreBackup().filterByPotentialWin(horseObj.uuid);
  currStats.overall_potential_wins = RESULTS.length();
  currStats.overall_potential_rate = currStats.overall_win_rate + ((currStats.overall_potential_wins / currStats.overall_races) * 100);
}

function generateGenerationStats(horseObj, generations, i, j) {
  if (!is_array(generations)) {
    generations = [generations]; 
  }
  
  var currStats = oStatsController.current_team_stats[i][j];
  
  RESULTS.reset().filterByTeamGeneration(generations).saveBackup().filterByHorseObj(horseObj);
  currStats.generation_races = RESULTS.length();
  currStats.generation_average = RESULTS.calculateAverage();
  
  RESULTS.filterByWin();
  
  currStats.generation_wins = RESULTS.length();
  currStats.generation_win_rate = (currStats.generation_wins / currStats.generation_races) * 100;
  
  RESULTS.restoreBackup().filterByPotentialWin(horseObj.uuid);
  currStats.generation_potential_wins = RESULTS.length();
  currStats.generation_potential_rate = currStats.generation_win_rate + ((currStats.generation_potential_wins / currStats.generation_races) * 100);
}