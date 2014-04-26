
var connect; // websocekt connection

var GAME_ENTER = 0;
var GAME_LOAD = 1;
var GAME_IDENTITY = 2;
var GAME_ON = 3;
var GAME_WAIT = 4;
var GAME_OVER = 5;
var GAME_NIGHT = 31;
var GAME_DAY = 32;
//var NUMBER_OF_STATES = 4;

var gameStage = 0;
var gameTurn = GAME_NIGHT ;
var clientId;
var isKiller=true;
var connect=null;

function S4() {
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
}
function guid() {
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}