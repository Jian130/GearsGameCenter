// Config

var GAME_ENTER = 0;
var GAME_READY = 1;
var GAME_ON = 2;
var GAME_WAIT = 3;
var GAME_OVER = 4;
var NUMBER_OF_STATES = 4;

var IS_READY = 1;
var NOT_READY = 0;

// on opening page, set state to GAME_ENTER
var state = GAME_ENTER;
// only host can start game
var isHost = false;

var UserList;
var GameUserList;

var numGameUser;
var numGameAnswer;

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
	if(state == GAME_OVER)
		DisplayResults();
	
	return state;
}

function GetGameUsersList(){
	return GameUserList;
}

function startGame(){
	// start the game
	var dataobject={type:"startGame", value:null};
    sendOut(dataobject);
}

function answerQuestion(name){
	//answer question and send it out
	var dataobject={type:"answer", value:name};
	sendOut(dataobject);
	
	nextState();
}

function UserIsReady(name){
	//send the name to the server
	setUser(name, IS_READY);
	
	//move state forward
	nextState();
	return state;
}

//mock up
mocked_UserList = new Object();

function setUser(name, state){
	mocked_UserList[name] = state;
	console.log("set");
	var dataobject={type:"mocked", value:mocked_UserList};
	sendOut(dataobject);
}

function receivedSharedMemory(name, body){

}

function receivedUserlist(list){
	UserList = list;
	//the first user is host
	if(UserList.length == 1){
		isHost = true;
	}
}

// receive msg
function recievedCallBack(object){
		//var dataobject={type:"updateLocation",userid:myid,location:Mylocation,time:null,actions:realTimeActions(CurrentPath)};
		if(object.type=="startGame"){
			//everyone start the game
			if(state!=GAME_READY){
				return;
			}
			//initiate GameUserList
			//object {Userame:"", Rank:1, Count:1}
			GameUserList = [];
			for (var key in UserList){
				if(UserList[key]==IS_READY){
					var obj = {"Username":key, "Rank":undefined, "Count":0};
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
			receivedUserlist(object.value)
		}
}

