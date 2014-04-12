function generateClientId(){
	clientId = guid();
	return clientId;
}
function CountDownTimer(timeout, callbackFunPerSec, callbackFunWhenStop){
	//callback function for per second need to allow a parameter to be passed in
	var time=timeout;
	this.intervalid =0;

	this.startTimer=function(){
		 this.intervalid=setInterval(function(){
			time--;
			callbackFunPerSec(time);
			console.log(time);
			if(time<=0){
				clearInterval(this.intervalid);
				callbackFunWhenStop();
			}

		},1000);
		
	}
	return this;

}
function nextStage(){
	gameStage++;
	if(gameStage==6){
		gameStage=0;
		renderStage();
	}
	if(gameStage==GAME_LOAD){
		renderStage();
	}
	if(gameStage==GAME_IDENTITY){
		var timer=CountDownTimer(5,displayIdentityTimer,nextStage);
		timer.startTimer();
		renderStage();
	}
	if(gameStage == GAME_ON){
		var timer=CountDownTimer(5, displayNightTimer, nextTurn);
		timer.startTimer();
		renderStage();
	}
}
function nextTurn(){

	if(gameTurn == GAME_NIGHT){
		if(isKiller){
			//get killed person and then submit
			var item=getSelectedListItem("survivorList");
			console.log(item.value);
		}
		gameTurn = GAME_DAY;

		renderStage();

	}
	else if(gameTurn == GAME_DAY){
		gameTurn = GAME_NIGHT;
		renderStage();
	}
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
function voteButtonClick(){
	var item = getSelectedListItem("voteList");

}

function listItemClick(elem){
	
	var ulid= elem.parentNode.id;
	removeSelectListItem(ulid);
	elem.className="selected";

}