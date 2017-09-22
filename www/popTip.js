	var exec = require('cordova/exec');

	var PopTip = function(){};

	PopTip.prototype.base_toast = function(jsParameter)
	 {
		// body...
		var content = jsParameter.content;
      var showTime = jsParameter.time;
		var resultCallback = jsParameter.success;
   	exec(resultCallback, null, "PopTip", "showToast", []);
   };

	PopTip.prototype.base_showNativeActionSheet = function(jsParameter) {
		// body...
		var options = jsParameter.options;
      var cancelButtonIndex = jsParameter.cancelButtonIndex;
      var destructiveButtonIndex = jsParameter.destructiveButtonIndex;
      var title = jsParameter.title;
      var resultCallback = jsParameter.success;
      exec(resultCallback, null, "PopTip", "showActionSheet", [options,cancelButtonIndex,destructiveButtonIndex,title])
	};

   module.exports = new PopTip();
   
   exec.addFunction(['base_toast','base_showNativeActionSheet'], [PopTip.prototype.base_toast,PopTip.prototype.base_showNativeActionSheet]);