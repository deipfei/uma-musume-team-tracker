// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum CHART_TYPE {
  WIN_PERCENTAGE,
  POTENTIAL_WIN_PERCENTAGE,
  TOP_THREES
}
function EmuResultsGraph(x, y, w, h, horse, type): EmuCore(x, y, w, h) constructor {
  self.horse = horse;
  self.chartType = type;
  
  //this should be moved into the oStatsController Stats object, but just trying my refactoring of the awful graph code
  //this should also be based on win% in each category, not wins.
  //filter out 0s
  //maybe write out race type on graph too?
  self.results = new ResultsSearch();
  self.racesRun = results.filterByHorseObj(horse).length();
  
  self.data = [];
  
  if (chartType == CHART_TYPE.WIN_PERCENTAGE) {
    results.filterByHorseObj(horse).saveBackup();
    array_push(data, (results.restoreBackup().filterByRaceType(SHORT_IND).filterByWin().length() / racesRun) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(MILE_IND).filterByWin().length() / racesRun ) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(MID_IND).filterByWin().length() / racesRun  ) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(LONG_IND).filterByWin().length() / racesRun ) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(DIRT_IND).filterByWin().length() / racesRun ) * 100);
  } else if (chartType == CHART_TYPE.POTENTIAL_WIN_PERCENTAGE) {
    results.reset().filterByWinAndPotential(self.horse.uuid).saveBackup();
    array_push(data, (results.restoreBackup().filterByRaceType(SHORT_IND).filterByHorseObj(self.horse).length() / racesRun) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(MILE_IND).filterByHorseObj(self.horse).length() / racesRun ) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(MID_IND).filterByHorseObj(self.horse).length() / racesRun  ) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(LONG_IND).filterByHorseObj(self.horse).length() / racesRun ) * 100);
    array_push(data, (results.restoreBackup().filterByRaceType(DIRT_IND).filterByHorseObj(self.horse).length() / racesRun ) * 100);
  } else if (chartType == CHART_TYPE.TOP_THREES) {
    results.filterByHorseObj(horse).saveBackup();
    array_push(data, results.restoreBackup().filterByFinishingPosition(1).length());
    array_push(data, results.restoreBackup().filterByFinishingPosition(2).length());
    array_push(data, results.restoreBackup().filterByFinishingPosition(3).length());
    array_push(data, results.restoreBackup().filterByFinishingPosition(4).length());
    array_push(data, results.restoreBackup().filterByFinishingPosition(5).length());
  }
  
  
  Render = function(base_x, base_y) {
    processAdvancement();
    var x1 = x + base_x;
    var y1 = y + base_y;
        
    draw_graph_text(x1, y1, width, height, data);
  }
}