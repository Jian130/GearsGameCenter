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
function MarkUserDeadById(cid){
	var list=getPlayerList();
	for (var i = list.length - 1; i >= 0; i--) {
		if(list[i].id==cid){
			list[i].status=0;
		}
	};
	if(cid==clientId){
		setDead();
	}
		
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
	/*
	if(object.type=="startGame"){
		//everyone start the game
		if(state!=GAME_READY){
			return;
		}

		whoIsOn();
		setTimeout(function(){setGameOn()},1000);*/
	if(object.type == "peace" && inGame){
		setGameProcessing();
	}
	if(object.type == "killed" && inGame){
		MarkUserDeadById(object.value);
		if(object.value == clientId){
			setDead();
//			connect.close();
		}else{
			setGameProcessing();
		}
		
	}
	if(object.type == "vote"){
		voteList.push(object.value);
		var slist= getSurvivorList();
		if (voteList.length>=slist.length) {
			var counts=new Object();
			var maxIndex=null;
			var hasEqualMax=false;
			for (var i = voteList.length - 1; i >= 0; i--) {
				var count=0
				if(counts[voteList[i].votes]==undefined){
					counts[voteList[i].votes]=1;
					if(maxIndex==null){
						maxIndex=voteList[i].votes;
					}
					count = 1;

				}else{
					count = ++counts[voteList[i].votes];
				}
					if(voteList[i].votes==maxIndex){
						//if (hasEqualMax) {
							hasEqualMax = false;
						//};
					}else{
						if(count>counts[maxIndex]){
							maxIndex = voteList[i].votes;
							hasEqualMax = false;
						}else if(count==counts[maxIndex]){
							hasEqualMax = true;
						}
					}
				
			};
			if (!hasEqualMax&&maxIndex!=null) {

				MarkUserDeadById(maxIndex);
				processTurn();
				setGameProcessing();
				
			}else{
				processTurn();
				setGameProcessing();
			}

		};
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
				console.log("ingame");
				inGame=true;



			}
			
			
		};
		nextStage();
		processGame();
		
	}
	//greg added
	
}
