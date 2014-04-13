function generateClientId(){
	clientId = guid();
	return clientId;
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
	myUser.username=name;
	connect.setUser(myUser.id, JSON.stringify(myUser));
	nextStage();
}
function startButtonClick(){
	if(isHost){
		broadcastUsersIdentity();
	}
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
function broadcastUsersIdentity(){
	var killerIndex=Math.floor(Math.random()* UserList.length);
	var killerId;
	for (var i = UserList.length - 1; i >= 0; i--) {
		var id=UserList[i].clientId;
		//var userProp=JSON.parse(UserList[i].property);
		if(killerIndex==i){
			killerId=id;
		}
	};
	var message={type:"setKiller",value:killerId}
	connect.broadcasting(message);
}