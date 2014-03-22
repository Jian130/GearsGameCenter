var fps = 25;

var mazeWidth=31;
var mazeHeight=31;

var viewWidth=15;
var viewHeight=15;

var mazedata;

var blockSize=15;

var speed=5; //moving 5 px per frame.

var gameState = "gameIsReady";

/*
	1.gameIsReady 
	2.gameDidStart 
	3.gameDidEnd 
*/

var block1Texture=PIXI.Texture.fromImage("block1.png");
var block2Texture=PIXI.Texture.fromImage("block2.png");
var empty3Texture=PIXI.Texture.fromImage("block3.png");
var empty4Texture=PIXI.Texture.fromImage("block4.png");
var empty5Texture=PIXI.Texture.fromImage("block5.png");
var empty6Texture=PIXI.Texture.fromImage("block6.png");
var charTexture=PIXI.Texture.fromImage("character1.png");

function GridBlock(x,y) //grid(wall) object
{
    this.Disp = new PIXI.Sprite(empty6Texture); //texture , will be reset during maze setup
    this.Disp.anchor.x = 0;
    this.Disp.anchor.y = 0;
    this.Disp.position.x = x*blockSize+LocationShift.shiftx; 
    this.Disp.position.y = y*blockSize+LocationShift.shifty;

}
function CharBlock(x,y) //charcotor object
{
    this.Disp = new PIXI.Sprite(charTexture); //texture
    this.Disp.anchor.x = 0;
    this.Disp.anchor.y = 0;
    this.Disp.position.x = Math.floor(viewWidth/2)*blockSize; //initial position
    this.Disp.position.y = Math.floor(viewHeight/2)*blockSize; // initial position

}