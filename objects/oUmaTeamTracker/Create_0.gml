randomize();

enum HORSE_INDEX {
  ADMIRE_VEGA,
  AGNES_DIGITAL,
  AGNES_TACHYON,
  AIR_GROOVE,
  BIWA_HAYAHIDE,
  CURREN_CHAN,
  DAIWA_SCARLET,
  EISHIN_FLASH,
  EL_CONDOR_PASA,
  FINE_MOTION,
  FUJI_KISEKI,
  GOLD_CITY,
  GOLD_SHIP,
  GRASS_WONDER,
  HARU_URARA,
  HISHI_AKEBONO,
  HISHI_AMAZON,
  KAWAKAMI_PRINCESS,
  KING_HALO,
  KITASAN_BLACK,
  MANHATTAN_CAFE,
  MARUZENSKY,
  MATIKANE_FUKUKITARU,
  MATIKANE_TANNHAUSER,
  MAYANO_TOP_GUN,
  MEISHO_DOTO,
  MEJIRO_ARDAN,
  MEJIRO_DOBER,
  MEJIRO_MCQUEEN,
  MEJIRO_RYAN,
  MIHONO_BOURBON,
  NARITA_BRIAN,
  NARITA_TAISHIN,
  NICE_NATURE,
  OGURI_CAP,
  RICE_SHOWER,
  SAKURA_BAKUSHIN_O,
  SAKURA_CHIYONO_O,
  SEIUN_SKY,
  SILENCE_SUZUKA,
  SMART_FALCON,
  SPECIAL_WEEK,
  SUPER_CREEK,
  SYMBOLI_RUDOLF,
  TAIKI_SHUTTLE,
  TAMAMO_CROSS,
  TM_OPERA_O,
  TOKAI_TEIO,
  TOSEN_JORDAN,
  VODKA,
  WINNING_TICKET
}
  
enum S_RANK_INDEXES {
  ZERO,
  TURF,
  DIRT,
  SHORT,
  MILE,
  MID,
  LONG,
  RUNNER,
  LEADER,
  BETWEENER,
  CHASER
}

#region ALL HORSES
ALL_HORSES = [
  new HorseBase("Admire Vega", HORSE_INDEX.ADMIRE_VEGA),
  new HorseBase("Agnes Digital", HORSE_INDEX.AGNES_DIGITAL),
  new HorseBase("Agnes Tachyon", HORSE_INDEX.AGNES_TACHYON),
  new HorseBase("Air Groove", HORSE_INDEX.AIR_GROOVE),
  new HorseBase("Biwa Hayahide", HORSE_INDEX.BIWA_HAYAHIDE),
  new HorseBase("Curren-chan", HORSE_INDEX.CURREN_CHAN),
  new HorseBase("Daiwa Scarlet", HORSE_INDEX.DAIWA_SCARLET),
  new HorseBase("Eishin Flash", HORSE_INDEX.EISHIN_FLASH),
  new HorseBase("El Condor Pasa", HORSE_INDEX.EL_CONDOR_PASA),
  new HorseBase("Fine Motion", HORSE_INDEX.FINE_MOTION),
  new HorseBase("Fuji Kiseki", HORSE_INDEX.FUJI_KISEKI),
  new HorseBase("Gold City", HORSE_INDEX.GOLD_CITY),
  new HorseBase("Gold Ship", HORSE_INDEX.GOLD_SHIP),
  new HorseBase("Grass Wonder", HORSE_INDEX.GRASS_WONDER),
  new HorseBase("Haru Urara", HORSE_INDEX.HARU_URARA),
  new HorseBase("Hishi Akebono", HORSE_INDEX.HISHI_AKEBONO),
  new HorseBase("Hishi Amazon", HORSE_INDEX.HISHI_AMAZON),
  new HorseBase("Kawakami Princess", HORSE_INDEX.KAWAKAMI_PRINCESS),
  new HorseBase("King Halo", HORSE_INDEX.KING_HALO),
  new HorseBase("Kitasan Black", HORSE_INDEX.KITASAN_BLACK),
  new HorseBase("Manhattan Cafe", HORSE_INDEX.MANHATTAN_CAFE),
  new HorseBase("Maruzensky", HORSE_INDEX.MARUZENSKY),
  new HorseBase("Matikane Fukukitaru", HORSE_INDEX.MATIKANE_FUKUKITARU),
  new HorseBase("Matikane Tannhauser", HORSE_INDEX.MATIKANE_TANNHAUSER),
  new HorseBase("Mayano Top Gun", HORSE_INDEX.MAYANO_TOP_GUN),
  new HorseBase("Meisho Doto", HORSE_INDEX.MEISHO_DOTO),
  new HorseBase("Mejiro Ardan", HORSE_INDEX.MEJIRO_ARDAN),
  new HorseBase("Mejiro Dober", HORSE_INDEX.MEJIRO_DOBER),
  new HorseBase("Mejiro McQueen", HORSE_INDEX.MEJIRO_MCQUEEN),
  new HorseBase("Mejiro Ryan", HORSE_INDEX.MEJIRO_RYAN),
  new HorseBase("Mihono Bourbon", HORSE_INDEX.MIHONO_BOURBON),
  new HorseBase("Narita Brian", HORSE_INDEX.NARITA_BRIAN),
  new HorseBase("Narita Taishin", HORSE_INDEX.NARITA_TAISHIN),
  new HorseBase("Nice Nature", HORSE_INDEX.NICE_NATURE),
  new HorseBase("Oguri Cap", HORSE_INDEX.OGURI_CAP),
  new HorseBase("Rice Shower", HORSE_INDEX.RICE_SHOWER),
  new HorseBase("Sakura Bakushin O", HORSE_INDEX.SAKURA_BAKUSHIN_O),
  new HorseBase("Sakura Chiyono O", HORSE_INDEX.SAKURA_CHIYONO_O),
  new HorseBase("Seiun Sky", HORSE_INDEX.SEIUN_SKY),
  new HorseBase("Silence Suzuka", HORSE_INDEX.SILENCE_SUZUKA),
  new HorseBase("Smart Falcon", HORSE_INDEX.SMART_FALCON),
  new HorseBase("Special Week", HORSE_INDEX.SPECIAL_WEEK),
  new HorseBase("Super Creek", HORSE_INDEX.SUPER_CREEK),
  new HorseBase("Symboli Rudolf", HORSE_INDEX.SYMBOLI_RUDOLF),
  new HorseBase("Taiki Shuttle", HORSE_INDEX.TAIKI_SHUTTLE),
  new HorseBase("Tamamo Cross", HORSE_INDEX.TAMAMO_CROSS),
  new HorseBase("TM Opera O", HORSE_INDEX.TM_OPERA_O),
  new HorseBase("Tokai Teio", HORSE_INDEX.TOKAI_TEIO),
  new HorseBase("Tosen Jordan", HORSE_INDEX.TOSEN_JORDAN),
  new HorseBase("Vodka", HORSE_INDEX.VODKA),
  new HorseBase("Winning Ticket", HORSE_INDEX.WINNING_TICKET)
];
#endregion

data = {
    team: createTeamBlank(),
    results: [],
    all_horses: []
};

load();

if (array_length(data.all_horses) > 0) {
  checkSaveIssues();
}

team_in_memory = loadTeamIntoMemory();

instance_create_depth(0, 0, 0, oNewHorseController);
instance_create_depth(0, 0, 0, oNewResultController);
instance_create_depth(0, 0, 0, oPreviousResultsController);
instance_create_depth(0, 0, 0, oUmaTeamEditController);
instance_create_depth(0, 0, 0, oStatsController);

setOverallAverages(-1);
oNewResultController.class = data.results[array_length(data.results) - 1].class;

container = new EmuCore(0, 0, room_width, room_height);

var tab_group = new EmuTabGroup(0, 0, room_width, room_height, 1, 32);
var tab_team = new EmuTab("Team");
var tab_results = new EmuTab("Results");
var tab_stats = new EmuTab("Stats");
var tab_chart = new EmuTab("Chart");
var tab_horses = new EmuTab("Horses");

tab_group.AddTabs(0, [tab_team, tab_results, tab_stats, tab_chart, tab_horses]);

container.AddContent(tab_group);
#region team
tab_team.AddContent([
  new EmuButton((room_width / 2) - 200, 32, 400, 64, "Edit Team", function() {
    oUmaTeamEditController.editing = !oUmaTeamEditController.editing;
    
    if (oUmaTeamEditController.editing) {
      self.text = "Save Changes";
    } else {
      self.text = "Edit Team";
      addGenerationToTeam();
      save();
    }
  }),
  new EmuText(162, 125, 200, 32, "Short"),
  new EmuText(394, 125, 200, 32, "Mile"),
  new EmuText(626, 125, 200, 32, "Mid"),
  new EmuText(858, 125, 200, 32, "Long"),
  new EmuText(1110, 125, 200, 32, "Dirt"),
])

for (var i = 0; i < 5; i++) {
  for (var j = 0; j < 3; j++) {
    tab_team.AddContent([
      new EmuButtonImageHorse(140 + (232 * i), 175 + (180 * j), 128, 128, i, j, c_white, 1, true, function () {
        
        
        if (oUmaTeamEditController.editing) {
          #region edit mode
          var dialog = new EmuDialog(950, 640, "New Girl");
          oNewHorseController.race_type = self.race_type;
          oNewHorseController.horse_position = horse_position;
          oNewHorseController.existing_horses = new EmuList_ExistingHorses(32, EMU_AUTO, 256, 32, "Existing:", 32, 8, function() {
            var selection = GetSelection();
            
            if (selection != -1) {
              setNewHorseStats(self._entries[| selection]); 
            }
          });
        
          #region list of names
          var list_sprites = new EmuList(32, EMU_AUTO, 256, 32, "Horse:", 32, 8, function() {
            var selection = GetSelection();
            if (selection != -1) {
              var base = getHorseByIndex(selection);
              oNewHorseController.horse_spr_obj._index = selection;
              oNewHorseController.horse_in_progress.base = base;
              addExistingHorses(base);
            }
          });
          for (var i = 0; i < array_length(HORSES); i++) {
            list_sprites.AddEntries([HORSES[i].name]);
          }
          #endregion
        
          #region S ranks
          //short, mile, mid, long
          //turf dirt
          //chaser, betweener, leader, runner
          oNewHorseController.turfS = new EmuCheckbox(332, 32, 100, 32, "Turf", false, function() {
            setCurrentSRank(S_RANK_INDEXES.TURF, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.dirtS = new EmuCheckbox(472, 32, 100, 32, "Dirt", false, function() {
            setCurrentSRank(S_RANK_INDEXES.DIRT, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.dirtS.SetPrevious(oNewHorseController.turfS);
        
          oNewHorseController.shortS = new EmuCheckbox(332, 80, 100, 32, "Short", false, function() {
            setCurrentSRank(S_RANK_INDEXES.SHORT, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.shortS.SetPrevious(oNewHorseController.dirtS);
          oNewHorseController.mileS = new EmuCheckbox(472, 80, 100, 32, "Mile", false, function() {
            setCurrentSRank(S_RANK_INDEXES.MILE, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.mileS.SetPrevious(oNewHorseController.shortS);
          oNewHorseController.midS = new EmuCheckbox(332, 128, 100, 32, "Mid", false, function() {
            setCurrentSRank(S_RANK_INDEXES.MID, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.midS.SetPrevious(oNewHorseController.mileS);
          oNewHorseController.longS = new EmuCheckbox(472, 128, 100, 32, "Long", false, function() {
            setCurrentSRank(S_RANK_INDEXES.LONG, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.longS.SetPrevious(oNewHorseController.midS);
        
          oNewHorseController.runnerS = new EmuCheckbox(332, 176, 100, 32, "Runner", false, function() {
            setCurrentSRank(S_RANK_INDEXES.RUNNER, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.runnerS.SetPrevious(oNewHorseController.longS);
          oNewHorseController.leaderS = new EmuCheckbox(472, 176, 100, 32, "Leader", false, function() {
            setCurrentSRank(S_RANK_INDEXES.LEADER, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.leaderS.SetPrevious(oNewHorseController.runnerS);
          oNewHorseController.betweenerS = new EmuCheckbox(332, 224, 100, 32, "Betweener", false, function() {
            setCurrentSRank(S_RANK_INDEXES.BETWEENER, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.betweenerS.SetPrevious(oNewHorseController.leaderS);
          oNewHorseController.chaserS = new EmuCheckbox(472, 224, 100, 32, "Chaser", false, function() {
            setCurrentSRank(S_RANK_INDEXES.CHASER, value ? "1" : "0");
            resetUsingOldHorse();
          });
          oNewHorseController.chaserS.SetPrevious(oNewHorseController.betweenerS);
          #endregion
        
          #region skills
          oNewHorseController.overall_input = new EmuInput(332, EMU_AUTO, 300, 32, "Overall", "", "", 5, E_InputTypes.STRING, function() {
            if (value != "") {
              oNewHorseController.horse_in_progress.total = real(value);
              resetUsingOldHorse();
            }
          });
          oNewHorseController.overall_input.SetRealNumberBounds(0, 100000);
          oNewHorseController.overall_input.SetPrevious(oNewHorseController.chaserS);
        
          oNewHorseController.speed_input = new EmuInput(332, EMU_AUTO, 300, 32, "Speed", "", "", 4, E_InputTypes.INT, function() {
            if (value != "") {
              oNewHorseController.horse_in_progress.spd = real(value);
              resetUsingOldHorse();
            }
          });
          oNewHorseController.speed_input.SetRealNumberBounds(0, 1200);
          oNewHorseController.speed_input.SetPrevious(oNewHorseController.overall_input);
        
          oNewHorseController.stamina_input = new EmuInput(332, EMU_AUTO, 300, 32, "Stamina", "", "", 4, E_InputTypes.STRING, function() {
            if (value != "") {
              oNewHorseController.horse_in_progress.stam = real(value);
              resetUsingOldHorse();
            }
          });
          oNewHorseController.stamina_input.SetRealNumberBounds(0, 1200);
          oNewHorseController.stamina_input.SetPrevious(oNewHorseController.speed_input);
        
          oNewHorseController.power_input = new EmuInput(332, EMU_AUTO, 300, 32, "Power", "", "", 4, E_InputTypes.STRING, function() {
             if (value != "") {
              oNewHorseController.horse_in_progress.pow = real(value);
              resetUsingOldHorse();
             }
          });
          oNewHorseController.power_input.SetRealNumberBounds(0, 1200);
          oNewHorseController.power_input.SetPrevious(oNewHorseController.stamina_input);
        
          oNewHorseController.guts_input = new EmuInput(332, EMU_AUTO, 300, 32, "Guts", "", "", 4, E_InputTypes.STRING, function() {
            if (value != "") {
              oNewHorseController.horse_in_progress.guts = real(value);
              resetUsingOldHorse();
            }
          });
          oNewHorseController.guts_input.SetRealNumberBounds(0, 1200);
          oNewHorseController.guts_input.SetPrevious(oNewHorseController.power_input);
        
          oNewHorseController.knowledge_input = new EmuInput(332, EMU_AUTO, 300, 32, "Intelligence", "", "", 4, E_InputTypes.STRING, function() {
            if (value != "") {
              oNewHorseController.horse_in_progress.know = real(value);
              resetUsingOldHorse();
            }
          });
          oNewHorseController.knowledge_input.SetRealNumberBounds(0, 1200);
          oNewHorseController.knowledge_input.SetPrevious(oNewHorseController.guts_input);
          #endregion
        
          #region selected girl sprite
          var selectedGirlSprite = new EmuImage(675, 20, 256, 419, umafullbody, 0, c_white, 1, true);
          selectedGirlSprite.image_obj = oNewHorseController.horse_spr_obj;
          oNewHorseController.horse_spr_obj._index = 0;
          #endregion
        
          #region submit cancel
          var submitButton = new EmuButton(600, 600, 100, 32, "Submit", function() {
            setHorse(oNewHorseController.race_type, oNewHorseController.horse_position, oNewHorseController.horse_in_progress);
            resetHorseInProgress();
            emu_dialog_close_auto();
            save();
          });
          submitButton.SetPrevious(oNewHorseController.knowledge_input);
          submitButton.SetNext(oNewHorseController.turfS);
        
          var cancelButton = new EmuButton(480, 600, 100, 32, "Cancel", function() {
           resetHorseInProgress();
           emu_dialog_close_auto();
          });
          #endregion

        
          dialog.AddContent([list_sprites,
            oNewHorseController.existing_horses,
            oNewHorseController.turfS,
            oNewHorseController.dirtS,
            oNewHorseController.shortS,
            oNewHorseController.mileS,
            oNewHorseController.midS,
            oNewHorseController.longS,
            oNewHorseController.runnerS,
            oNewHorseController.leaderS,
            oNewHorseController.betweenerS,
            oNewHorseController.chaserS,
            oNewHorseController.overall_input,
            oNewHorseController.speed_input,
            oNewHorseController.stamina_input,
            oNewHorseController.power_input,
            oNewHorseController.guts_input,
            oNewHorseController.knowledge_input,
            selectedGirlSprite,
            cancelButton,
            submitButton
          ]);
          #endregion
        } else {
          #region view mode
          var selectedHorse = getHorse(oUmaTeamTracker.team_in_memory, self.race_type, self.horse_position);
          if (selectedHorse != noone) {
            var dialog = new EmuDialog(950, 640, selectedHorse.base.name);
          }
          #endregion
        }
      })
    ])
  }
}

#endregion

#region results
#region new results
var newResultsButton = new EmuButton((room_width / 2) - 200, 32, 400, 64, "New Race Results", function() {
  var dialog = new EmuDialog(400, 640, "New Results");
  
  var firstInput = noone;
  var prevInput = noone;
  
  for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 3; j++) {
      var horse = getHorse(oUmaTeamTracker.team_in_memory, i, j);
      var name = "";
      if (horse != noone) {
        name = horse.base.name;
      }
      var resultsInput = new EmuInput_Result(16, 32 + (36 * ((3 * i) + j)), 368, 30, name, "", "", 2, E_InputTypes.STRING, i, j, function() {
        if (value != "")
          oNewResultController.results_in_progress[race_type][horse_position] = real(value);
      });
      
      if (firstInput == noone) {
        firstInput = resultsInput;
        prevInput = resultsInput;
      } else {
        resultsInput.SetPrevious(prevInput);
        prevInput = resultsInput;
      }
      
      dialog.AddContent(resultsInput);
    }
    
    
        
    var cancelButton = new EmuButton(90, 600, 100, 32, "Cancel", function() {
      emu_dialog_close_auto();
    });
      
    var submitButton = new EmuButton(210, 600, 100, 32, "Submit", function() {
        if (verifyCurrentResults()) {
          addResults();
          emu_dialog_close_auto();
          save();
        }
      });
      submitButton.SetPrevious(prevInput);
      submitButton.SetNext(firstInput);
      
      dialog.AddContent([cancelButton, submitButton]);
  }
});
var classInput = new EmuInput(900, 48, 150, 32, "Class", string(oNewResultController.class), "", 1, E_InputTypes.STRING, function() {
  try {
    var newClass = real(value);
    oNewResultController.class = newClass;
  } catch (e) {
  }
});

tab_results.AddContent([newResultsButton, classInput]);
#endregion

#region previous 10 results
var prevResultsHeader = new EmuText(32, 100, 1216, 64, "Previous Results");
tab_results.AddContent(prevResultsHeader);
var maxResultsIndex = array_length(data.results) - 1;
for (var i = 0; i < 10; i++) {
  var text = "";
  
  var currentIndex = maxResultsIndex - i;
  if (currentIndex >= 0) {
    text = getResultsText(data.results[currentIndex].results, currentIndex + 1);
  }
  
  var results = new EmuText(32, 180 + (i * 32), 1216, 32, text);
  array_push(oPreviousResultsController.previousResults, results);
  tab_results.AddContent(results);
}
#endregion
#endregion

#region stats
var genWidth = 600;
var genPicker = new EmuInput((room_width / 2) - (genWidth / 2), 32, genWidth, 32, "Current Team Generation: " + string(oUmaTeamTracker.data.team.generation), "", "", 100, E_InputTypes.INT, function() {
  if (value != "") {
    var newGen = real(value);
    oStatsController.current_team_generation = newGen;
    oStatsController.current_team_viewing = json_parse(json_stringify(loadTeamByGeneration(real(value)))); //get new instance so I can add stats without affecting anything
    setStatsTeam();
    setOverallAverages(newGen);
    generateAllStats(newGen);
  }
});

for (var i = 0; i < 5; i++) {
  for (var j = 0; j < 3; j++) {
    var currButton = new EmuButtonImageHorse(140 + (232 * i), 200 + (180 * j), 128, 128, i, j, c_white, 1, true, function () {
      if (self.horse != noone) {
        //show_debug_message(calculateHorseAverage(self.horse.uuid, [32]));
        var stats = getHorseStats(self.race_type, self.horse_position);
        var dialog = new EmuDialog(950, 640, self.horse.base.name);
        
        var statsText = new EmuText(16, 16, 240, 300, stats.toString());
        
        var winsChart = new EmuResultsGraph(300, 25, 300, 150, self.horse, CHART_TYPE.WIN_PERCENTAGE);
        var potWinsChart = new EmuResultsGraph(300, 225, 300, 150, self.horse, CHART_TYPE.POTENTIAL_WIN_PERCENTAGE);
        var topThreesChart = new EmuResultsGraph(300, 425, 300, 150, self.horse, CHART_TYPE.TOP_THREES);
        
        dialog.AddContent([statsText, winsChart, potWinsChart, topThreesChart]);
      }
    });
    currButton.horse = oStatsController.current_team_viewing.horses[i][j];
    currButton.statsButton = true;
    oStatsController.horseButtons[i][j] = currButton;
    tab_stats.AddContent([currButton])
  }
}

tab_stats.AddContent([
  genPicker,
  new EmuText(162, 125, 200, 32, "Short"),
  new EmuText(394, 125, 200, 32, "Mile"),
  new EmuText(626, 125, 200, 32, "Mid"),
  new EmuText(858, 125, 200, 32, "Long"),
  new EmuText(1110, 125, 200, 32, "Dirt"),
  oStatsController.textShort,
  oStatsController.textMile,
  oStatsController.textMid,
  oStatsController.textLong,
  oStatsController.textDirt
]);
#endregion

#region chart

tab_chart.AddContent([
  new HorseChart(30, 30, 1220, 660, 0, 100, "Win %", 0, oStatsController.most_races_run, "Races Run")
]);
#endregion