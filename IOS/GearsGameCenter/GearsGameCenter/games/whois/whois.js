// Config

var GAME_ENTER = 0;
var GAME_READY = 1;
var GAME_ON = 2;
var GAME_WAIT = 3;
var GAME_OVER = 4;
var NUMBER_OF_STATES = 4;

var IS_READY = 1;
var NOT_READY = 0;

var UNDEFINED = -1;

// on opening page, set state to GAME_ENTER
var state = GAME_ENTER;
// only host can start game
var isHost = 0;

var UserList;
var GameUserList;

var numGameUser;
var numGameAnswer;

//function Center(){
//	this.broadcasting=function(msg){
//		sendOut(msg);
//	}
//}
var connect = new GameCenter();


// to move State forward
// 0 - 1 - 2 - 3 - 4 - 1
function nextState(){
	state = state + 1;
	if(state>NUMBER_OF_STATES){
		state = state % NUMBER_OF_STATES;
	}
	
	//
	if(state == GAME_ON)
		DisplayQuestion();
	if(state == GAME_OVER){
		caculateRank();
		DisplayResults();
	}
	
	return state;
	
	function caculateRank(){
		for(var i=0; i<GameUserList.length; i++){
			maxIndex = -1;
			maxVote = -1;
			for(var j=0; j<GameUserList.length; j++){
				if(GameUserList[j].Rank == UNDEFINED){
					if(GameUserList[j].Count>maxVote){
						maxVote = GameUserList[j].Count;
						maxIndex = j;
					}
				}
			}
			console.log(maxIndex);
			GameUserList[maxIndex].Rank = i+1;
		}
	}
}

/*
function GetGameUsersList(){
	return GameUserList;
}
*/

function startGame(){
	// start the game
	var dataobject={type:"startGame", value:null};
    connect.broadcasting(dataobject);
}

function answerQuestion(name){
	//answer question and send it out
	console.log("name: "+name);
	var dataobject={type:"answer", value:name};
	connect.broadcasting(dataobject);
	
	nextState();
}

myName = "";

function UserIsReady(name){
	//send the name to the server
	setUser(name, IS_READY);
	myName= name;
	GetGameUsersList();
	//move state forward
	nextState();
	return state;
}

//mock up
mocked_UserList = new Object();

/*
function setUser(name, state){
	mocked_UserList_tmp = new Object();
	mocked_UserList_tmp[0] = name;
	mocked_UserList_tmp[1] = state;
	console.log(mocked_UserList_tmp);
	var dataobject={type:"mocked", value:mocked_UserList_tmp};
	connect.broadcasting(dataobject);
}
*/

function receivedSharedMemory(name, body){

}

function receivedUserlist(list){
	UserList = list;
	//the first user is host
	//if(Object.keys(UserList).length == 1){
		if(Object.keys(UserList)[0]==myName){
			isHost = 1;
			EnableStartButton();
		}
		else{
			isHost = 0;
			DisableStartButton();
		}
		
	//}
}

mocked_Rank = 0;

// receive msg
function recievedCallBack(object){
	console.log(object);
		//var dataobject={type:"updateLocation",userid:myid,location:Mylocation,time:null,actions:realTimeActions(CurrentPath)};
		
		if(object.type=="startGame"){
			//everyone start the game
			if(state!=GAME_READY){
				return;
			}
			//initiate GameUserList
			//object {Userame:"", Rank:1, Count:1}
			GameUserList = [];
			mocked_Rank+=1;
			for (var key in UserList){
				if(UserList[key]==IS_READY){
					var obj = {"Username":key, "Rank":UNDEFINED, "Count":0};
					GameUserList.push(obj);
				}
			}
			numGameUser = GameUserList.length;
			numGameAnswer = 0;
			
			nextState();
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

function GetQuestion(){
	return "Who is the most 'gregry' guy among us?";
}
