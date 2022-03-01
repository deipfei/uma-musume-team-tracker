if (keyboard_check(vk_control)) {
  var clipboard = string_split(clipboard_get_text(), "\n");
  var results = [];
  for (var i = 0; i < array_length(clipboard); i++) {
    try {
      var res = real(clipboard[i]);
      array_push(results, res);
    } catch (e) {
      
    }
  }
  
  if (array_length(results) == 15) {
    addPastedResults(results);
  }
}