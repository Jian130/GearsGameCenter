function hideAllStageExcpet(stageid){
	hideItemsByClassName("stageContainer");
	showItemsById(stageid);
}
function hideItemsByName(name){
	var items = document.getElementsByName(name);
	for (var i = items.length - 1; i >= 0; i--) {
		items[i].setAttribute("hidden",true);

	};
}
function showItemsByName(name){
	var items = document.getElementsByName(name);
	for (var i = items.length - 1; i >= 0; i--) {
		items[i].removeAttribute("hidden");
	};
}
function hideItemsByClassName(classname){
	var items = document.getElementsByClassName(classname);
	for (var i = items.length - 1; i >= 0; i--) {
		items[i].setAttribute("hidden",true);

	};
}
function showItemsByClassName(classname){
	var items = document.getElementsByClassName(classname);
	for (var i = items.length - 1; i >= 0; i--) {
		items[i].removeAttribute("hidden");
	};
}
function hideItemsById(id){
	var item= document.getElementById(id);
	item.setAttribute("hidden",true);
}
function showItemsById(id){
	var item = document.getElementById(id);
	item.removeAttribute("hidden");	
}
function removeSelectListItem(ulid){
	var item=getSelectedListItem(ulid);
	if(item!=null)item.className = "";
}
function getSelectedListItem(ulid){
	var ul=document.getElementById(ulid);
	var items = ul.childNodes;
	for(var i in items){
		if(items[i].className == "selected"){
			return items[i];
		}
	}
}