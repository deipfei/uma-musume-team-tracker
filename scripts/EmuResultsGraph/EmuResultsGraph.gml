// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EmuResultsGraph(x, y, w, h, horse): EmuCore(x, y, w, h) constructor {
  self.horse = horse;
  
  //this should be moved into the oStatsController Stats object, but just trying my refactoring of the awful graph code
  //this should also be based on win% in each category, not wins.
  //filter out 0s
  //maybe write out race type on graph too?
  self.results = new ResultsSearch();
  results.filterByHorseObj(horse).saveBackup();
  
  self.short_wins = results.restoreBackup().filterByRaceType(SHORT_IND).filterByWin().length();
  self.mile_wins = results.restoreBackup().filterByRaceType(MILE_IND).filterByWin().length();
  self.mid_wins = results.restoreBackup().filterByRaceType(MID_IND).filterByWin().length();
  self.long_wins = results.restoreBackup().filterByRaceType(LONG_IND).filterByWin().length();
  self.dirt_wins = results.restoreBackup().filterByRaceType(DIRT_IND).filterByWin().length();
  
  
  Render = function(base_x, base_y) {
    processAdvancement();
    var x1 = x + base_x;
    var y1 = y + base_y;
        
    draw_graph_text(x1, y1, width, height, [short_wins, mile_wins, mid_wins, long_wins, dirt_wins]);
  }
}