
var connect; // websocekt connection

var gameStage = 0;
var GAME_ENTER = 0;
var GAME_LOAD = 1;
var GAME_ON = 2;
var GAME_WAIT = 3;
var GAME_OVER = 4;
var NUMBER_OF_STATES = 4;
var clientId;

function S4() {
   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
}
function guid() {
   return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}