
function displayIdentityTimer(time){
	var t=document.getElementsByName("identityTimer");
	t[0].innerHTML=time;
}
function displayNightTimer(time){
	var t=document.getElementById("nightTimer");
	t.innerHTML=time;
}
function displayVoteResultTimer(time){
	var t=document.getElementById("voteResultTimer");
	t.innerHTML=time;
}

function updateUserIdentityText(text){
	console.log("Iam"+text);
	console.log(text);
	var doc=document.getElementById("userIdentityLabel");

	doc.innerHTML=text;
}

function renderStage(){
	


	

	if(gameStage==GAME_ENTER){	
	hideAllStageExcpet("stageGameEnter");	
	//hideItemsByName("startButton");
	//showItemsByName("readyButton");
	}
	if(gameStage == GAME_LOAD){
		hideAllStageExcpet("stageGameLoad");
		if(isHost){
			if(isHost){
				showItemsByName("startButton");
			}
		}
	}

	if(inGame){
		if(gameStage == GAME_IDENTITY){
			var timer=CountDownTimer(IDENTITY_TIME,displayIdentityTimer,nextStage);
			timer.startTimer();
			hideAllStageExcpet("stageGameIdentity");
		}
		if(gameStage == GAME_ON){
			if(gameTurn == GAME_NIGHT){
				var timer=CountDownTimer(NIGHT_TIME, displayNightTimer, processTurn);
				timer.startTimer();
				hideAllStageExcpet("stageGameNight");
				var docSlist=document.getElementById("survivorList");
				docSlist.innerHTML="";
				var slist = getSurvivorList();
				for (var i = slist.length - 1; i >= 0; i--) {

					docSlist.innerHTML+='<li onclick="listItemClick(this)" name="'+slist[i].id+'">'+slist[i].username+"</li>"
				};
			}
			else if(gameTurn == GAME_DAY){
				hideAllStageExcpet("stageGameDay");
				showItemsByName("voteButton");
				
				var docDlist=document.getElementById("deathList");
				docDlist.innerHTML="";
				var docVlist=document.getElementById("voteList");
				docVlist.innerHTML="";

				var dList=getDeathList();
				var vList=getSurvivorList();
				for(var i in dList){
					docDlist.innerHTML+='<li>'+dList[i].username+'</li>';
				}
				for(var i in vList){
					docVlist.innerHTML+='<li onclick="listItemClick(this)" name="'+vList[i].id+'">'+vList[i].username+'</li>'
				}

			}else if(gameTurn == GAME_VOTE_RESULT){
				hideAllStageExcpet("stageVoteResult");

				var docVboard=document.getElementById("voteBoard");
				docVboard.innerHTML="";
				for (var i = voteList.length - 1; i >= 0; i--) {
					var vname;
					for (var j = playerList.length - 1; j >= 0; j--) {
						if(playerList[j].id==voteList[i].votes){
							vname = playerList[j].username;
						}
					};
					docVboard.innerHTML+='<p>'+voteList[i].voter+' votes '+vname+'</p>';
					
				};
				
				var timer = CountDownTimer(5,displayVoteResultTimer,processTurn);
				timer.startTimer();
			}
		}	
	}
}
function renderDeath(){
	//connect.close();
	hideAllStageExcpet("YouAreDead");
}
function displayWatitingIcon(){

}
