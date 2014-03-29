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
var isHost = 0;

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
    broadcasting(dataobject);
}

function answerQuestion(name){
	//answer question and send it out
	var dataobject={type:"answer", value:name};
	broadcasting(dataobject);
	
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
	console.log(mocked_UserList)
	mocked_UserList[name] = state;
	console.log(mocked_UserList);
	var dataobject={type:"mocked", value:mocked_UserList};
	broadcasting(dataobject);
}

function receivedSharedMemory(name, body){

}

function receivedUserlist(list){
	UserList = list;
	//the first user is host
	if(Object.keys(UserList).length == 1){
		isHost = 1;
		EnableStartButton();
	}
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
					var obj = {"Username":key, "Rank":mocked_Rank, "Count":0};
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
			mocked_UserList = object.value;
			receivedUserlist(object.value)
		}
}

function GetQuestion(){
	return "Who is the most 'gregry' guy among us?";
}
