
function displayIdentityTimer(time){
	var t=document.getElementsByName("identityTimer");
	t[0].innerHTML=time;
}
function displayNightTimer(time){
	var t=document.getElementById("nightTimer");
	t.innerHTML=time;
}

function renderStage(){
	if(gameStage==GAME_ENTER){	
		hideAllStageExcpet("stageGameEnter");	
		//hideItemsByName("startButton");
		//showItemsByName("readyButton");
	}
	if(gameStage == GAME_LOAD){
		hideAllStageExcpet("stageGameLoad");
	}
	if(gameStage == GAME_IDENTITY){
		hideAllStageExcpet("stageGameIdentity");
	}
	if(gameStage == GAME_ON){
		if(gameTurn == GAME_NIGHT){
			hideAllStageExcpet("stageGameNight");
			var docSlist=document.getElementById("survivorList");
			docSlist.innerHTML="";
			var slist = getSurvivorList();
			for (var i = slist.length - 1; i >= 0; i--) {
				docSlist.innerHTML+='<li onclick="listItemClick(this)" value="'+slist[i].id+'"">'+slist[i].name+"</li>"
			};
		}
		else if(gameTurn == GAME_DAY){
			hideAllStageExcpet("stageGameDay");
			var docDlist=document.getElementById("deathList");
			docDlist.innerHTML="";
			var docVlist=document.getElementById("voteList");
			docVlist.innerHTML="";

			var dList=getDeathList();
			var vList=getSurvivorList();
			for(var i in dList){
				docDlist.innerHTML+='<li>'+dList[i].name+'</li>';
			}
			for(var i in vList){
				docVlist.innerHTML+='<li onclick="listItemClick(this)">'+vList[i].name+'</li>'
			}

		}
	}	
}
