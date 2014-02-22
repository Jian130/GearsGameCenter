// width and height must be ODD!!
function generateMaze(width, height){
	var cells = height*width;
	var maze = new Array();
	for(var i=0; i<cells; i++){
	    maze[i] = 1;
	}
	
	//functions
	function addAdjacent(index){
	    var shifts = [-width, width, -1, 1];
	    for(var i=0; i<shifts.length; i++){
	        if(isInMaze(index+shifts[i])==0){
	            walls.push(index+shifts[i]);
	        }
	    }
	}
	
	function isInMaze(index){
	    return (1 - maze[(index)]);
	}
	
	function returnOtherSide(index){
	    if(index%width%2!=0){
	        if(maze[index-1]!=0)
	            return (index-1);
	        else if(maze[index+1]!=0)
	            return (index+1);
	        else
	            return 0;
	    }
	    if(maze[index-width]!=0)
	        return (index-width);
	    else if(maze[index+width]!=0)
	        return (index+width);
	    else
	        return 0;
	
	    return -1;
	}
	
	var walls = new Array();
	//start
	maze[0] = 0;
	addAdjacent(0);
	
	while(walls.length>0){
	    var randomIndex = Math.floor(Math.random() * walls.length);
	    var randomWall = walls[randomIndex];
	    //check if the other side is in the maze
	    var otherSide = returnOtherSide(randomWall);
	    if(otherSide != 0){
	        // mark it as a part of the maze
	        maze[otherSide] = 0;
	        // also mark the wall to be part of the maze
	        maze[randomWall] = 0;
	        // add all adjacent cells to the wall list
	        addAdjacent(otherSide);
	    }
	    walls.splice(randomIndex, 1);
	}
	
	return maze;
}


function returnFrame(index, width, height, maze){
	var centerX = index%width;
	var centerY = index/width;
	return returnFrame2(centerX, centerY, width, height, maze);
	
}

function isOutBound(indexX, indexY, width, height){
	if(indexX < 0 || indexX >= width)
		return 1;
	if(indexY < 0 || indexY >= height)
		return 1;
	return 0;
}

function returnFrame2(centerX, centerY, width, height, maze){
	var frameSize = 11;
	var frame = new Array();
	for(var i=0; i<frameSize; i++){
		frame[i] = new Array();
	}
	var windowSize = (frameSize-1)/2;
	var leftCornerX = centerX - windowSize;
	var leftCornerY = centerY - windowSize;

	for(var i=leftCornerX; i<leftCornerX+frameSize; i++){
		for(var j=leftCornerY; j<leftCornerY+frameSize; j++){
			if(isOutBound(i, j, width, height)>0)
				frame[j-leftCornerY][i-leftCornerX] = 1;
			else
				frame[j-leftCornerY][i-leftCornerX] = maze[j*width+i];
		}
	}
	return frame;
}

function pathFinder(sourceX, sourceY, targetX, targetY, frame){
	var frameSize = 11;
	var path = new Array();
	for(var i=0; i<frameSize; i++){
		path[i] = new Array();
		for(var j=0; j<frameSize; j++){
			path[i][j] = 0;
		}
	}
	
	//functions
	function addAdjacent(X, Y, number){
		if(X>0 && frame[X-1][Y]===0 && path[X-1][Y]===0){
			path[X-1][Y] = number+1;
		}
		if(X<frameSize-1 && frame[X+1][Y]===0 && path[X+1][Y]===0){
			path[X+1][Y] = number+1;
		}
		if(Y<frameSize-1 && frame[X][Y+1]===0 && path[X][Y+1]===0){
			path[X][Y+1] = number+1;
		}
		if(Y>0 && frame[X][Y-1]===0 && path[X][Y-1]===0){
			path[X][Y-1] = number+1;
		}
	}
	
	//add adjacent
	
	var iterations = 1;
	path[sourceX][sourceY] = iterations;
	addAdjacent(sourceX, sourceY, iterations);
	
	
	while(path[targetX][targetY]==0){
		iterations += 1;
		for(var i=0; i<frameSize; i++){
			for(var j=0; j<frameSize; j++){
				if(path[i][j]==iterations){
					addAdjacent(i, j, iterations);
				}
			}
		}
	}
	
	var actions = new Array();
	currentX = targetX;
	currentY = targetY;
	for(var step = path[targetX][targetY]-1; step>0; step--){
		console.log(currentX);
		if(currentX>0 && path[currentX-1][currentY]==step){
			currentX = currentX - 1;
			actions.unshift([0,1]);
		}
		else if(currentX<frameSize-1 && path[currentX+1][currentY]==step){
			currentX = currentX + 1;
			actions.unshift([0,-1]);
		}
		else if(currentY>0 && path[currentX][currentY-1]==step){
			currentY = currentY - 1;
			actions.unshift([1,0]);
		}
		else if(currentY<frameSize-1 && path[currentX][currentY+1]==step){
			currentY = currentY + 1;
			actions.unshift([-1,0]);
		}
	}
	
	return actions;
}

//test
/*
var height = 11;
var width = 11;

var maze = generateMaze(width, height);

var mazeOutput = "Results:</br>";
for(var i = 0; i<maze.length; i++){
    mazeOutput += maze[i];
    if(i%width==(width-1)){
        mazeOutput += "</br>"
    }
}
document.write(mazeOutput);

var frame = returnFrame2(5,5, width, height, maze);
mazeOutput = "</br>Results2:</br>";
for(var i = 0; i<frame.length; i++){
	for(var j=0; j<frame[i].length; j++){
		mazeOutput += frame[i][j];
	}
    mazeOutput += "</br>"
}
document.write(mazeOutput);

var actions = pathFinder(0,0,10,10, frame);
mazeOutput = "</br>Results3:</br>";
for(var i = 0; i<actions.length; i++){
	for(var j=0; j<actions[i].length; j++){
		mazeOutput += actions[i][j];
	}
    mazeOutput += "</br>"
}
document.write(mazeOutput);
*/