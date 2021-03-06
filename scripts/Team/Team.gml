// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function Team(horses, generation) constructor{
  self.horses = horses
  self.generation = generation;
}

function createTeamWithGroups(short, mile, mid, long, dirt) {
  return new Team([short, mile, mid, long, dirt], 1);
}

function createTeamWithHorses(short1, short2, short3, mile1, mile2, mile3, mid1, mid2, mid3, long1, long2, long3, dirt1, dirt2, dirt3) {
  return new Team([[short1, short2, short3], [mile1, mile2, mile3], [mid1, mid2, mid3], [long1, long2, long3], [dirt1, dirt2, dirt3]], 1); 
}

function setHorse(controller, type_ind, horse_ind, horse) {
  var lastResults = noone;
  var racesRun = array_length(oUmaTeamTracker.data.results);
  if (racesRun > 0) {
    lastResults = oUmaTeamTracker.data.results[racesRun - 1];
  }
  
  if (controller.using_old_horse) {
    oUmaTeamTracker.team_in_memory[type_ind][horse_ind] = controller.horse_reference;
    oUmaTeamTracker.data.team.horses[type_ind][horse_ind] = controller.horse_reference.uuid; 
  } else {
    oUmaTeamTracker.team_in_memory[type_ind][horse_ind] = horse;
    oUmaTeamTracker.data.team.horses[type_ind][horse_ind] = horse.uuid; 
  }
  
  
  //
  if (lastResults != noone && lastResults.team_generation == oUmaTeamTracker.data.team.generation) {
    oUmaTeamTracker.data.team.generation += 1; 
  }
  
  if (!controller.using_old_horse) {
    array_push(oUmaTeamTracker.data.all_horses, horse);
  }
}

function teamIncludesHorse(team, horse) {
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      if (team.horses[i][j] == horse.uuid) return true; 
    }
  }
  
  return false;
}

function getHorse(team, type_ind, horse_ind) {
  return team[type_ind][horse_ind]; 
}

function createTeamBlank() {
  return new Team([[noone, noone, noone], [noone, noone, noone], [noone, noone, noone], [noone, noone, noone], [noone, noone, noone]], 1); 
}

function createTeamRandom() {
  return new Team([[createHorseRandom(), createHorseRandom(), createHorseRandom()], [createHorseRandom(), createHorseRandom(), createHorseRandom()], [createHorseRandom(), createHorseRandom(), createHorseRandom()], [createHorseRandom(), createHorseRandom(), createHorseRandom()], [createHorseRandom(), createHorseRandom(), createHorseRandom()]], 1); 
}

function addGenerationToTeam() {
  clearRemovedHorses();
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      var currentHorse = oUmaTeamTracker.team_in_memory[i][j];
      var currentHorseGenerations = getHorseGenerations(currentHorse);
      if (currentHorse != noone && !array_contains(currentHorseGenerations, oUmaTeamTracker.data.team.generation)) {
        array_push(currentHorse.team_generations, new TeamPositions(oUmaTeamTracker.data.team.generation, i, j));
      }
    }
  }
}

function clearRemovedHorses() {
  var horse_size = array_length(oUmaTeamTracker.data.all_horses);
  for (var i = 0; i < horse_size; i++) {
    var currHorse = oUmaTeamTracker.data.all_horses[i];
    var genSize = array_length(currHorse.team_generations);
    
    for (var j = 0; j < genSize; j++) {
      var currGen = currHorse.team_generations[j];
      
      if (currGen.generation == oUmaTeamTracker.data.team.generation && !teamIncludesHorse(oUmaTeamTracker.data.team, currHorse)) {
        //horse was originally in the generation, but never ran a race, should be removed
        array_delete(currHorse.team_generations, j, 1);
      }
    }
  }
}

function loadTeamIntoMemory() {
  var horse_uuids = oUmaTeamTracker.data.team.horses;
  
  var team = createTeamBlank().horses;
  
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      var horse = getHorseByUuid(horse_uuids[i][j]);
      team[i][j] = horse;
    }
  }
  
  return team;
}

function loadTeamByGeneration(generation) {
  var team = createTeamBlank(); 
  team.generation = generation;
  
  horsesFound = 0;
  
  for (var i = 0; i < array_length(oUmaTeamTracker.data.all_horses); i++) {
    var currHorse = oUmaTeamTracker.data.all_horses[i];
    
    var generations = currHorse.team_generations;
    
    for (var j = 0; j < array_length(generations); j++) {
      var currGen = generations[j];
      
      if (currGen.generation == generation) {
        team.horses[currGen.race_type][currGen.position] = currHorse;
        horsesFound++;
        
        if (horsesFound >= 15) {
          return team; 
        }
      }
    }
  }
  
  return team;
}