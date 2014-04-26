var mocklist=[{name:"Greg",id:"1",status:1,identity:1},
{name:"Luna",id:"2",status:0,identity:0},
{name:"Effie",id:"3",status:0,identity:0}];
function getPlayerList(){
	return playerList;
}
function getDeathList(){
	var list=getPlayerList();
	var deadList = new Array();
	for(var index in list){
		if(list[index].status==0){
			deadList.push(list[index]);
		}
	}
	return deadList;
}
function getCivilianList(){
	var list=getPlayerList();
	var cList = new Array();
	for(var index in list){
		if(list[index].status==3){
			cList.push(list[index]);
		}
	}
	return cList;
}
function getKillerCount(){
	var list=getPlayerList();
	var cList = new Array();
	for(var index in list){
		if(list[index].identity==1){
			return list[index];
		}
	}
	
}
function getSurvivorList(){
	var list = getPlayerList();
	var sList= new Array();
	for(var index in list){
		if(list[index].status == 1){
			sList.push(list[index]);
		}		
	}
	return sList;
}
function receivedUserlist(list){

	UserList = list;
	console.log("receivedUserlist:"+JSON.stringify(list));
	//setHost
	for (var i = UserList.length - 1; i >= 0; i--) {
		var id=UserList[i].name;
		if(UserList[i].isHost=="1" && id==clientId){
			isHost=true;
			showItemsByName("startButton");
		}
	};
	
}
function recievedCallBack(object){
	//console.log(object);
	if(object.type=="startGame"){
		//everyone start the game
		if(state!=GAME_READY){
			return;
		}

		whoIsOn();
		setTimeout(function(){setGameOn()},1000);
	}if(object.type == "peace"){
		setGameProcessing();
	}
	if(object.type == "killed"){
		setGameProcessing();
	}

	if(object.type == "gameStart"){
		console.log("Game start");

		if(!isHost){
			

			updatePlayerList(object.value);

		}
		for (var i = playerList.length - 1; i >= 0; i--) {
			if(playerList[i].id==clientId)
			{
				if( playerList[i].identity == 1){
					isKiller = true;
					updateUserIdentityText("Killer");
				}	
				else{
					updateUserIdentityText("Civilian");
				}


			}
			inGame=false;
			nextStage();
			processGame();
		};
		
	}
	//greg added
	
}
