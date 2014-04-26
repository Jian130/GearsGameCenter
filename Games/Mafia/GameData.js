var mocklist=[{name:"Greg",id:"1",status:1,identity:1},
{name:"Luna",id:"2",status:0,identity:0},
{name:"Effie",id:"3",status:0,identity:0}];
function getPlayerList(){
	return mocklist;
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