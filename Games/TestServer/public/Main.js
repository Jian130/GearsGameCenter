function MazeLocation(inx,iny){
		this.x=inx;
		this.y=iny;
};
function to2DArray(array,width,height)
{
	var first=new Array(height);
	for(var i=0;i<height;i++){
		first[i]=new Array(width);
		for(var j=0;j<width;j++){
			first[i][j]=array[width*j+i];
		}
	}
	return first;
}
function ParseMazeData(mazeData)
{
	var mazeGrids=new Array(mazeWidth);
	for(var i=0;i<mazeWidth;i++){
		mazeGrids[i]=new Array(mazeHeight);
	}
	//console.log(mazeGrids);

	for(var i=0;i<mazeData.length;i++){
		for(var j=0;j<mazeData[i].length;j++){
			var g= new GridBlock(i,j);
			

			if(mazeData[i][j]==0){
				// setup grid texture for all wall grids.
				var up = 0;
				if(j>0)
					up = mazeData[i][j-1];
				var right = 0;
				if(i<mazeData[i].length-1)
					right = mazeData[i+1][j];
				
				if(up == 0 && right ==1)
					g.Disp.setTexture(empty3Texture);
				else if(up == 1 && right == 1)
					g.Disp.setTexture(empty4Texture);
				else if(up == 1 && right == 0)
					g.Disp.setTexture(empty5Texture);
			}else{
				if(j<mazeData.length-1 && mazeData[i][j+1]==1)
					g.Disp.setTexture(block1Texture);
				else
					g.Disp.setTexture(block2Texture);
			}
		
			mazeGrids[i][j]=g;
		}
	}
	return mazeGrids;
}

function MazeSetup(mazegrid,mazeWidth,mazeHeight){

	for(var i=0;i<mazeWidth;i++){
		for(var j=0;j<mazeHeight;j++){
			container.addChild(mazegrid[i][j].Disp);
		}
	}
}

function MazeUpdate(direction,data){
	if(diffx==0 && diffy==0 &&CurrentPath!=undefined){
		if (CurrentPath.length>0) {
			diffx=blockSize;
			diffy=blockSize;
			Mylocation.x=Mylocation.x+ CurrentPath[0][0];
			Mylocation.y=Mylocation.y + CurrentPath[0][1];
			CurrentPath.shift();

			var dataobject={type:"updateLocation",location:Mylocation ,userid:ID};
    		sendOut(dataobject);
			
		}else{
			OnPath=false;
		}
		return;
	}
	if(diffx!=0){
		for (var i = data.length - 1; i >= 0; i--) {
			for (var j = data[i].length - 1; j >= 0; j--) {
				data[i][j].Disp.position.x=data[i][j].Disp.position.x-direction[0]*speed;
			}
		}
		for(var i=0;i<otherUser.length;i++){
			otherUser[i].Disp.position.x=data[otherUser[i].location.x][otherUser[i].location.y].Disp.position.x;
		}
		diffx=diffx-speed;
	}
	if(diffy!=0){
		for (var i = data.length - 1; i >= 0; i--) {
			for (var j = data[i].length - 1; j >= 0; j--) {
				data[i][j].Disp.position.y=data[i][j].Disp.position.y-direction[1]*speed;
			}
		}
		for(var i=0;i<otherUser.length;i++){
			otherUser[i].Disp.position.y=data[otherUser[i].location.x][otherUser[i].location.y].Disp.position.y;
				console.log(otherUser[i].Disp.position.y);
		}
		diffy=diffy-speed;
	}
}


