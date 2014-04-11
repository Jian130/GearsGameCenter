function generateClientId(){
	clientId = guid();
	return clientId;
}
function CountDownTimer(timeout, callbackFunPerSec, callbackFunWhenStop){
	//callback function for per second need to allow a parameter to be passed in
	var time=timeout;
	this.startTimer=function(){
		setInterval(function(){
			time--;
			callbackFunPerSec(time);
			if(time<=0){
				clearInterval();
				callbackFunWhenStop();
			}

		},1000);
		
	}

}
function nextStage(){
	gameStage++;
	if(gameStage==6){
		gameStage=0;
	}
	renderStage();
}
function readyButtonClick(){
	hideItemsByName("readyButton");
	showItemsByName("startButton");

	var name=document.getElementById("usernameText").value;
	myName=name;
	nextStage();
}
function startButtonClick(){
	
	nextStage();
}