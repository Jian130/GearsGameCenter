function generateClientId(){
	clientId = guid();
	return clientId;
}

function nextStage(){
	gameStage++;
	if(gameStage==6){
		gameStage=0;
		//renderStage();
	}
	if(gameStage==GAME_LOAD){
		//renderStage();
	}
	if(gameStage==GAME_IDENTITY){
		
		//renderStage();
	}
	if(gameStage == GAME_ON){
		
		//renderStage();
	}
	//processGame();
}
function nextTurn(){

	if(gameTurn == GAME_NIGHT){
		if(isKiller){
			//get killed person and then submit
			var item=getSelectedListItem("survivorList");
			if(item==null){
				var message = {type:"peace"};
				
			}else{
				var message = {type:"killed",value:item.value};
				console.log(item.value);
			}
			connect.broadcasting(message);
			setGameWaiting();
			//console.log(item.value);
		}
		gameTurn = GAME_DAY;

		//renderStage();

	}
	else if(gameTurn == GAME_DAY){
		gameTurn = GAME_NIGHT;
		//renderStage();
	}
	//processGame();
}
function readyButtonClick(){
	hideItemsByName("readyButton");
	

	var name=document.getElementById("usernameText").value;
	myUser.username=name;
	connect.setUser(myUser.id, JSON.stringify(myUser));
	nextStage();
	processGame();
}
function startButtonClick(){
	if(isHost){
		setPlayerlist();
		broadcastPlayerList();
		//broadcastUsersIdentity();
	}
	//nextStage();
}
function voteButtonClick(){
	var item = getSelectedListItem("voteList");

}

function listItemClick(elem){
	
	var ulid= elem.parentNode.id;
	removeSelectListItem(ulid);
	elem.className="selected";

}
function setPlayerlist(){
	var killerIndex=Math.floor(Math.random()* UserList.length);
	for (var i = UserList.length - 1; i >= 0; i--) {
		var userProp=JSON.parse(UserList[i].property);
		playerList.push(userProp);
	};
	playerList[killerIndex].identity=1;
	//return playerList();
}
function broadcastPlayerList(){
	var message = {type:"gameStart",value:playerList};
	connect.broadcasting(message);
}

/*
function broadcastUsersIdentity(){
	
	var killerId;
	for (var i = playerList.length - 1; i >= 0; i--) {
		//var id=UserList[i].clientId;
		var userProp=playerList[i];
		var id=userProp.id;
		
	};
	var message={type:"setKiller",value:killerId};
	//console.log(message);
	connect.broadcasting(message);
}*/
function updatePlayerList(list){
	playerList = list;
}
function processGame(){
	if(GAME_WAITING){


	}else{
		if (gameStage == GAME_ENTER) {
			renderStage();
		}else if(gameStage == GAME_LOAD){
			renderStage();
		}else if(gameStage == GAME_IDENTITY){
			renderStage();
		}else if(gameStage == GAME_ON){
			if(gameTurn == GAME_DAY){
				renderStage();
			}else if (gameTurn == GAME_NIGHT){
				renderStage();
			}
		}
	}
}

function setGameWaiting(){
	GAME_WAITING = true;
}
function setGameProcessing(){
	GAME_WAITING = false;
	processGame();
}
