// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Result(horse_uuid, position, race_type, horse_position) constructor {
  self.horse_uuid = horse_uuid;
  self.position = position;
  self.race_type = race_type;
  self.horse_position = horse_position;
}

function Results(results, teamGeneration) constructor {
  self.results = results;
  self.team_generation = teamGeneration;
  self.uuid = uuid_generate();
  self.class = 0;
}

function ResultsSearch() constructor {
  self.results = oUmaTeamTracker.data.results;
  self.single_results = false;
  self.backup_results = noone;
  self.backup_single_results = false;
  
  saveBackup = function() {
    self.backup_results = self.results;
    self.backup_single_results = self.single_results;
    
    return self;
  }
  
  restoreBackup = function() {
    if (self.backup_results != noone) {
      self.results = self.backup_results; 
      self.single_results = self.backup_single_results;
    }
    
    return self;
  }
  
  length = function() {
    return array_length(results); 
  }
  
  calculateAverage = function(horseUuid) {
    var numRaces = 0;
    var finishingPositionTotal = 0;
    if (single_results) {
      numRaces = array_length(results);
      for (var i = 0; i < numRaces; i++) {
        finishingPositionTotal += results[i].position;
      }
    } else {
      for (var i = 0; i < array_length(results); i++) {
        var currentResult = results[i].results;
        
        for (var j = 0; j < array_length(currentResult); j++) {
          var currentSingleResult = currentResult[j];
          numRaces += 1;
          finishingPositionTotal += currentSingleResult.position;
        }
      }
    }
    
    if (numRaces == 0) return 0;
    
    return finishingPositionTotal / numRaces;
  }
  
  filterByHorseUuid = function(horseUuid) {
    return self.filterByHorseObj(getHorseByUuid(horseUuid));
  }
  
  filterByFinishingPosition = function(position) {
    var filteredResults = [];
    
    if (!self.single_results) {
      for (var i = 0; i < array_length(self.results); i++) {
        var currentResultsArray = self.results[i].results;
        
        for (var j = 0; j < array_length(currentResultsArray); j++) {
          var currentSingleResult = currentResultsArray[j];
          
          if (currentSingleResult.position == position) {
            array_push(filteredResults, currentSingleResult); 
          }
        }
      }
    } else {
      for (var i = 0; i < array_length(self.results); i++) {
        var currentSingleResult = self.results[i];
          
        if (currentSingleResult.position == position) {
          array_push(filteredResults, currentSingleResult); 
        }
      }
    }
    
    self.single_results = true;
    self.results = filteredResults;
    
    return self;
  }
  
  filterByPotentialWin = function(horseUuid) {
    if (self.single_results) {
      results = [];
      return self;
    } //cannot determine if you only have single race results
    var filteredResults = [];
    
    for (var i = 0; i < array_length(self.results); i++) {
      var currentResultsArray = self.results[i].results;
        
      /*just writing this down somewhere
      results are structured badly and have redundant info
      should not be
      { results: [ {uuid: x, position: x, ...} ... ], team_generation: x }
      that's redundant information (race_type, horse_position) which can be looked up by horse uuid and team generations
      should just be
      { results: [[{horseUuid: x, position: x}]] (in the same 5x3 structure as teams, sorted by dirt, mile, etc) }
      overall object should have the uuid for the race, not the single position
      MAYBE I can keep horse_position and race_type in case array becomes unsorted, but idk if that'll happen
      each position should not have its own uuid though, that's unnecessary
      */
      
      var sortedResults = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
      var desiredRaceTypeIndex = -1;
      var desiredHorseResult = -1;
      for (var j = 0; j < array_length(currentResultsArray); j++) {
        var currentSingleResult = currentResultsArray[j];
          
        sortedResults[currentSingleResult.race_type][currentSingleResult.horse_position] = currentSingleResult.position;
        if (currentSingleResult.horse_uuid == horseUuid) {
          desiredRaceTypeIndex = currentSingleResult.race_type;
          desiredHorseResult = currentSingleResult.position;
        }
        
        if (desiredRaceTypeIndex != -1 && !array_contains(sortedResults[desiredRaceTypeIndex], 0)) {
          break; //can leave early because we have all the race results we need 
        }
      }
      
      if ((desiredHorseResult == 2 && array_contains(sortedResults[desiredRaceTypeIndex], 1))
       || (desiredHorseResult == 3 && array_contains(sortedResults[desiredRaceTypeIndex], 1) && array_contains(sortedResults[desiredRaceTypeIndex], 2))) {
         array_push(filteredResults, self.results[i]);
      }
    }
    
    self.results = filteredResults;
    
    return self;
  }
  
  filterByWin = function() {
    return filterByFinishingPosition(1);
  }
  
  filterByRaceType = function(race_type) {
    var filteredResults = [];
    
    if (!self.single_results) {
      for (var i = 0; i < array_length(self.results); i++) {
        var currentResultsArray = self.results[i].results;
        
        for (var j = 0; j < array_length(currentResultsArray); j++) {
          var currentSingleResult = currentResultsArray[j];
          
          if (currentSingleResult.race_type == race_type) {
            array_push(filteredResults, currentSingleResult); 
          }
        }
      }
    } else {
      for (var i = 0; i < array_length(self.results); i++) {
        var currentSingleResult = self.results[i];
          
        if (currentSingleResult.race_type == race_type) {
          array_push(filteredResults, currentSingleResult); 
        }
      }
    }
    
    
    self.single_results = true;
    self.results = filteredResults;
    return self;
  }
  
  filterByHorseObj = function(horseObj) {
    
    var filteredResults = [];
    
    if (!self.single_results) {
      var generations_in = [];
    
      for (var i = 0; i < array_length(horseObj.team_generations); i++) {
        var currentGen = horseObj.team_generations[i];
      
        array_push(generations_in, currentGen.generation);
      }
      
      for (var i = 0; i < array_length(self.results); i++) {
        var currResult = self.results[i];
        
        if (array_contains(generations_in, currResult.team_generation)) {
          array_push(filteredResults, currResult.results);
        }
      }
      
      self.single_results = true; //we won't have { team_generation: 1.0, results: [ResultObjs] } for example, just [ResultObjs]
    } else {
      filteredResults = self.results; 
    }
    
    var secondPass = [];
    
    for (var i = 0; i < array_length(filteredResults); i++) {
      var currentResultArray = filteredResults[i];
      
      for (var j = 0; j < array_length(currentResultArray); j++) {
        var currentSingleResult = currentResultArray[j];
        if (currentSingleResult.horse_uuid == horseObj.uuid) {
          array_push(secondPass, currentSingleResult); 
        }
      }
    }
    
    self.results = secondPass;
    
    return self;
  }
  
  filterByTeamGeneration = function(team_generations) {
    if (self.single_results) {
      self.results = [];
      return self;
    }
    
    if (!is_array(team_generations)) {
      if (!is_real(team_generations)) {
        self.results = [];
        return self;
      }
      
      team_generations = [team_generations]; 
    }
    
    var filteredResults = [];
    
    for (var i = 0; i < array_length(self.results); i++) {
      var currentResults = self.results[i];
      
      if (array_contains(team_generations, currentResults.team_generation)) {
        array_push(filteredResults, currentResults); 
      }
    }
    
    self.results = filteredResults;
    return self;
  }
  
  filterByClass = function(classes) {
    if (self.single_results) {
      self.results = [];
      return self;
    }
    
    if (!is_array(classes)) {
      if (!is_real(classes)) {
        self.results = [];
        return self;
      }
      
      classes = [classes]; 
    }
    
    var filteredResults = [];
    
    for (var i = 0; i < array_length(self.results); i++) {
      var currentResults = self.results[i];
      
      if (array_contains(classes, currentResults.class)) {
        array_push(filteredResults, currentResults); 
      }
    }
    
    self.results = filteredResults;
    return self;
  }
  
  reset = function() {
    self.results = oUmaTeamTracker.data.results;
    self.single_results = false;
    self.backup_results = noone;
    
    return self;
  }
}

function createResult(horse, position, race_type, horse_position) {
  if (horse == noone) return new Result(-4, position, race_type, horse_position);
  return new Result(horse.uuid, position, race_type, horse_position); 
}

function verifyCurrentResults() {
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      if (oNewResultController.results_in_progress[i][j] == 0) return false; 
    }
  }
  
  return true;
}

function addResults() {
  var results = [];
  
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      var horse = getHorse(oUmaTeamTracker.team_in_memory, i, j);
      array_push(results, createResult(horse, oNewResultController.results_in_progress[i][j], i, j));
      oNewResultController.results_in_progress[i][j] = 0;
    }
  }
  
  var resultsObj = new Results(results, oUmaTeamTracker.data.team.generation);
  resultsObj.class = oNewResultController.class;
  array_push(oUmaTeamTracker.data.results, resultsObj);
  
  updatePreviousResults(resultsObj.results, array_length(oUmaTeamTracker.data.results));
}

function addPastedResults(resultsArray) {
  var finalResults = [];
  var resultsCounter = 0;
   for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      var horse = getHorse(oUmaTeamTracker.team_in_memory, i, j);
      array_push(finalResults, createResult(horse, resultsArray[resultsCounter], i, j));
      resultsCounter++;
    }
  }
  
  var resultsObj = new Results(finalResults, oUmaTeamTracker.data.team.generation);
  
  array_push(oUmaTeamTracker.data.results, resultsObj);
  
  updatePreviousResults(resultsObj.results, array_length(oUmaTeamTracker.data.results));
  save();
}

function getResultsText(result, index) {
  var text = string(index) + ")    ";
  for (var i = 0; i < array_length(result); i++) {
    text += string(result[i].position);
    if (i % 3 == 2 && i != 14) {
       text += "        ";
    }
    text += " ";
  }
  
  return text;
}

function updatePreviousResults(result, newIndex) {
  var maxIndex = array_length(oPreviousResultsController.previousResults) - 1;
  for (var i = maxIndex; i > 0; i--) {
    var curr =  oPreviousResultsController.previousResults[i];
    curr.text = oPreviousResultsController.previousResults[i - 1].text;
  }
  
  oPreviousResultsController.previousResults[0].text = getResultsText(result, newIndex);
}