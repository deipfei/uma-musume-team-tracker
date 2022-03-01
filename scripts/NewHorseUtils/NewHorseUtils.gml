// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function resetHorseInProgress(){
  oNewHorseController.horse_in_progress = createHorseFromBase(_AGNES_TACHYON, 0);
}

function setSRank(horse, index, value) {
  var newRanks = "";
  for (var i = 1; i <= string_length(horse.s_ranks); i++) {
    if (i == index) {
      newRanks += (value ? "1" : "0"); 
    } else {
      newRanks += string_char_at(horse.s_ranks, i);
    }
  }
  
  horse.s_ranks = newRanks;
  save();
}

function setCurrentSRank(index, value) {
  setSRank(oNewHorseController.horse_in_progress, index, value);
}

function getSRank(horse, index) {
  return (string_char_at(horse.s_ranks, index) == "1") ? true : false;
}

function getCurrentSRank(index) {
  return getSRank(oNewHorseController.horse_in_progress, index); 
}

function addExistingHorses(base) {
  var horseList = ds_list_create();
  
  for (var i = 0; i < array_length(oUmaTeamTracker.data.all_horses); i++) {
    var currHorse = oUmaTeamTracker.data.all_horses[i];
    if (currHorse.base.name == base.name) {
      ds_list_add(horseList, currHorse);
    }
  }
  
  oNewHorseController.existing_horses.SetList(horseList); 
}

function setNewHorseStats(horse) {
  with oNewHorseController {
    horse_in_progress = json_parse(json_stringify(horse)); //do not overwrite original if you edit stats
    turfS.value = getCurrentSRank(S_RANK_INDEXES.TURF);
    dirtS.value = getCurrentSRank(S_RANK_INDEXES.DIRT);
    shortS.value = getCurrentSRank(S_RANK_INDEXES.SHORT);
    mileS.value = getCurrentSRank(S_RANK_INDEXES.MILE);
    midS.value = getCurrentSRank(S_RANK_INDEXES.MID);
    longS.value = getCurrentSRank(S_RANK_INDEXES.LONG);
    runnerS.value = getCurrentSRank(S_RANK_INDEXES.RUNNER);
    leaderS.value = getCurrentSRank(S_RANK_INDEXES.LEADER);
    betweenerS.value = getCurrentSRank(S_RANK_INDEXES.BETWEENER);
    chaserS.value = getCurrentSRank(S_RANK_INDEXES.CHASER);
    
    overall_input.value = real(horse_in_progress.total);
    speed_input.value = real(horse_in_progress.spd);
    stamina_input.value = real(horse_in_progress.stam);
    power_input.value = real(horse_in_progress.pow);
    guts_input.value = real(horse_in_progress.guts);
    knowledge_input.value = real(horse_in_progress.know);
    
    using_old_horse = true;
    horse_reference = horse; //save original so it can be added to future team
  }
}

function resetUsingOldHorse() {
  if (oNewHorseController.using_old_horse) {
    oNewHorseController.using_old_horse = false;
    oNewHorseController.horse_reference = noone;
    oNewHorseController.horse_in_progress.uuid = uuid_generate();
    oNewHorseController.team_generations = [];
  }
}