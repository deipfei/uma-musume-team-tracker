// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function saveString(_string, _filename) {
  var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
  buffer_write(_buffer, buffer_string, _string);
  buffer_save(_buffer, _filename);
  buffer_delete(_buffer);
}

function loadString(_filename) {
  var _buffer = buffer_load(_filename);
  var _string = buffer_read(_buffer, buffer_string);
  
  buffer_delete(_buffer);
  return _string;
}

function save() {
  saveString(json_stringify(oUmaTeamTracker.data), "save.json");
}

function load() {
  if (!file_exists("save.json")) return;
  
  var _json = loadString("save.json");
  oUmaTeamTracker.data = json_parse(_json);
}

function string_split(msg, delim) {
	var slot = 0;
	var splits = []; //array to hold all splits
	var str2 = ""; //var to hold the current split we're working on

	for (var i = 1; i < (string_length(msg) + 1); i++) {
	  var currStr = string_copy(msg, i, 1);
	  if (currStr == delim) {
	    splits[slot] = str2; //add this split to the array of all splits
	    slot++;
	    str2 = "";
	  } else {
	    str2 = str2 + currStr;
	    splits[slot] = str2; //for the final section
	  }
	}

	return splits;
}

function array_contains(array, value) {

	for (var i = 0; i < array_length(array); i++) {
	  if (array[i] == value) return true;	
	}

	return false;
}