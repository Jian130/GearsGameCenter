var mocklist=[{name:"Greg",id:"1",status:1,identity:1},
{name:"Luna",id:"2",status:0,identity:0},
{name:"Effie",id:"3",status:0,identity:0}];
function getPlayerList(){
	return mocklist;
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
		}
	};
	
}
function recievedCallBack(object){
	console.log(object);
	if(object.type=="startGame"){
		//everyone start the game
		if(state!=GAME_READY){
			return;
		}

		whoIsOn();
		setTimeout(function(){setGameOn()},1000);
	}
	if(object.type=="setKiller"){
		if(clientId == object.value){
			isKiller=true;
			updateUserIdentityText("Killer");
		}else{
			updateUserIdentityText("Civilian");
		}
	}
	if(object.type == "whoIsOn"){
		sendWelcome();
	}
	//greg added
	if(object.type == "welcome"){
		var exist=0;
		for(var i in Ulist)
		{
			if(Ulist[i]==object.value){
				exist=1;
			}
		}
		if(exist=0){
			Ulist.push(object.value);
		}

	}
	if(object.type=="answer"){
		numGameAnswer = numGameAnswer+1;
		for(var i=0; i<GameUserList.length; i++){
			if(GameUserList[i]["Username"]==object.value){
				GameUserList[i]["Count"] += 1;
			}
		}
		if(numGameAnswer==numGameUser){
			//everyone finish the question
			nextState();
		}
	}
	//mock up
	if(object.type == "mocked"){
		mocked_UserList[object.value[0]] = object.value[1];
		receivedUserlist(object.value);
	}
}
