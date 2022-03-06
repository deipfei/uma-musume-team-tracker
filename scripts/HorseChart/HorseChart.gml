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
  for (var i = 0; i < len; i++) {
    var currentHorse = oUmaTeamTracker.data.all_horses[i];
      
    var racesRun = resultsSearch.reset().filterByHorseObj(currentHorse).length();
    var wins = resultsSearch.filterByWin().length();
    var winP = (wins / racesRun) * 100;
      
    var xDiff = xAxisMax - xAxisMin;
    var yDiff = yAxisMax - yAxisMin;
      
    var xData = (winP - xAxisMin) / xDiff;
    var yData = (racesRun - yAxisMin) / yDiff;
    
    var dataPoint = {
      _x: (xData * width),
      _y: (yData * height),
      tooltip: currentHorse.base.name + " - " + string(currentHorse.total)
    };
    
    ds_list_add(data, dataPoint);
  }
  
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
      
      var _x = xAxisX + currentData._x;
      var _y = yAxisY - currentData._y;
      
      draw_circle_color(_x, _y, 3, c_blue, c_blue, false);
      draw_text(_x + 5, _y, currentData.tooltip);
    }
    
    draw_set_halign(oldHalign);
    draw_set_valign(oldValign);
  }
  
  Destroy = function() {
      destroyContent();
      if (data != noone) {
        ds_list_destroy(data); 
      }
  }
}
