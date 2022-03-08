// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function HorseChart(x, y, w, h, xMin, xMax, xLabel, yMin, yMax, yLabel): EmuCore(x, y, w, h) constructor {
  
  self.xAxisTitle = xLabel;
  self.xAxisMin = xMin;
  self.xAxisMax = xMax;
  
  self.yAxisTitle = yLabel;
  self.yAxisMin = yMin;
  self.yAxisMax = yMax;
  self.resultsSearch = new ResultsSearch();
  
  self.data = ds_list_create();
  
  var len = array_length(oUmaTeamTracker.data.all_horses);
  xAxisMax = 0;
  yAxisMax = 0;
  for (var i = 0; i < len; i++) {
    var currentHorse = oUmaTeamTracker.data.all_horses[i];
      
    var racesRun = resultsSearch.reset().filterByHorseObj(currentHorse).length();
    if (racesRun > yAxisMax) {
      yAxisMax = racesRun; 
    }
    //var wins = resultsSearch.reset().filterByPotentialWin(currentHorse.uuid).length(); //potential
    var wins = resultsSearch.filterByWin().length();
    var winP = (wins / racesRun) * 100;
    
    if (winP > xAxisMax) {
      xAxisMax = winP;
    }
      
    var xData = (winP - xAxisMin);
    var yData = (racesRun - yAxisMin);
    
    var dataPoint = {
      _x: xData,
      _y: yData,
      tooltip: currentHorse.base.name + " - " + string(currentHorse.total),
      in_team: teamIncludesHorse(oUmaTeamTracker.data.team, currentHorse)
    };
    
    ds_list_add(data, dataPoint);
  }
  
  xAxisMax += 5;
  yAxisMax += 5;
  
  self.dataLength = ds_list_size(data);

  Render = function(base_x, base_y) {
    processAdvancement();
    var x1 = x + base_x;
    var y1 = y + base_y;
    
    var x2 = x1 + width;
    var y2 = y1 + height;
    
    var xAxisX = x1 + 20;
    var yAxisY = y2 - 20;
    var oldHalign = draw_get_halign();
    var oldValign = draw_get_valign();
    var xDiff = xAxisMax - xAxisMin;
    var yDiff = yAxisMax - yAxisMin;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed_color(x1, (yAxisY - y1) / 2, yAxisTitle, 1, 1, 90, c_black, c_black, c_black, c_black, 1);
    draw_text_color((x2 - xAxisX) / 2, y2, xAxisTitle, c_black, c_black, c_black, c_black, 1);
    draw_line_width_color(xAxisX, y1, xAxisX, yAxisY, 3, c_black, c_black);
    draw_line_width_color(xAxisX, yAxisY, x2, yAxisY, 3, c_black, c_black);
    
    draw_set_halign(fa_left);
    draw_set_color(c_black);
    for (var i = 0; i < dataLength; i++) {
      var currentData = data[| i];
      
      var _x = xAxisX + ((currentData._x / xDiff) * width);
      var _y = yAxisY - ((currentData._y / yDiff) * height);
      
      draw_circle_color(_x, _y, 3, c_blue, c_blue, false);
      var colToUse = currentData.in_team ? c_red : c_black;
      
      if (draw_get_color() != colToUse) {
        draw_set_color(colToUse); 
      }
      draw_text(_x + 5, _y, currentData.tooltip);
    }
    
    draw_set_halign(oldHalign);
    draw_set_valign(oldValign);
    draw_set_color(c_black);
  }
  
  Destroy = function() {
      destroyContent();
      if (data != noone) {
        ds_list_destroy(data); 
      }
  }
}
