
var connect; // websocekt connection

var GAME_ENTER = 0;
var GAME_LOAD = 1;
var GAME_IDENTITY = 2;
var GAME_ON = 3;
var GAME_RESULT = 4;
var GAME_OVER = 5;


var GAME_NIGHT = 31;
var GAME_DAY = 32;
var GAME_VOTE_RESULT = 33;

var GAME_WAITING = false;//wait for broadcast

var USER_STATS_DEAD=0;
var USER_STATS_ALIVE=1;

var IDENTITY_TIME = 5;
var NIGHT_TIME = 10;

//var NUMBER_OF_STATES = 4;

var gameStage = 0;
var gameTurn = GAME_NIGHT ;
var clientId;
var isKiller=false;
var isHost=false;
var connect=null;
var isReady=false;
var inGame=false;
var myname;

//will let host broadcast userlist;



function S4() {
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
}
function guid() {
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}
var myUser={username:null,id:null,status:1,identity:0};
var UserList; //global Userlist
var playerList=new Array(); //gameplayer list
var voteList=new Array();