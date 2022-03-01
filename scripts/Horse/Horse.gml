// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function HorseBase(name, sprInd) constructor {
  self.name = name;
  self.sprInd = sprInd;
}

function Horse(horseBase, totalSkill, speedStat, staminaStat, powerStat, gutsStat, knowledgeStat, team_generations) constructor {
  self.uuid = uuid_generate();
  self.base = horseBase;
  self.total = totalSkill;
  self.spd = speedStat;
  self.stam = staminaStat;
  self.pow = powerStat;
  self.guts = gutsStat;
  self.know = knowledgeStat;
  self.s_ranks = "0000000000";
  self.team_generations = team_generations;
}

function createHorseFromBase(base, total) {
  return new Horse(base, total, -1, -1, -1, -1, -1, []);
}

function createHorse(base, total, spd, stam, pow, guts, know, team_generations) {
  return new Horse(base, total, spd, stam, pow, guts, know, team_generations);
}

function createHorseRandom() {
  return createHorseFromBase(HORSES[irandom(array_length(HORSES) - 1)], 1000);
}

function findBaseByName(name) {
  for (var i = 0; i < array_length(HORSES); i++) {
    if (HORSES[i].name == name) return HORSES[i]; 
  }
  
  return noone;
}

function getHorseByIndex(ind) {
  if (ind < 0 || ind >= array_length(HORSES)) return noone;
  return HORSES[ind]; 
}

function horsesEqual(horse1, horse2) {
  return horse1.base.name == horse2.base.name && horse1.s_ranks == horse2.s_ranks && horse1.total == horse2.total && horse1.spd == horse2.spd && horse1.stam == horse2.stam && horse1.pow == horse2.pow && horse1.guts == horse2.guts && horse1.know == horse2.know;
}

function getHorseByUuid(uuid) {
  for (var i = 0; i < array_length(oUmaTeamTracker.data.all_horses); i++) {
    var currentHorse = oUmaTeamTracker.data.all_horses[i];
    
    if (currentHorse.uuid == uuid) {
      return currentHorse; 
    }
  }
  
  return noone;
}

function getHorseGenerations(horseObj) {
  var generations = [];
  
  if (horseObj == noone) return generations;
  
  for (var i = 0; i < array_length(horseObj.team_generations); i++) {
    array_push(generations, horseObj.team_generations[i].generation); 
  }
  
  return generations;
}