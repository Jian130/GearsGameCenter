// width and height must be ODD!!

function generateWholeMaze(width, height, seed){
	Math.seedrandom(seed);
	wholeMaze = new Array();
	wholeMaze.push(generateMaze(width, height, seed));
	wholeMaze.push([0,0]);
	wholeMaze.push([40,40]);
	return wholeMaze;
}

function generateMaze(width, height, seed){
	var cells = height*width;
	var maze = new Array();
	for(var i=0; i<cells; i++){
	    maze[i] = 1;
	}
	
	//functions
	function addAdjacent(index){
		var X = index%width;
		var Y = index/width;
		var shifts = new Array();
		if(X>0)
			shifts.push(-1);
		if(Y>0)
			shifts.push(-width);
		if(X<width-1)
			shifts.push(1);
		if(Y<height-1)
			shifts.push(width);
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
	        if(index>0 && maze[index-1]!=0)
	            return (index-1);
	        else if(index<maze.length-1 && maze[index+1]!=0)
	            return (index+1);
	        else
	            return 0;
	    }
	    if(index>=width && maze[index-width]!=0)
	        return (index-width);
	    else if(index+width<maze.length && maze[index+width]!=0)
	        return (index+width);
	    else
	        return 0;
	
	    return -1;
	}
	
	var walls = new Array();
	//start
	maze[0] = 0;
	addAdjacent(0);
	
	Math.seedrandom(seed);
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


function returnFrame(index, width, height, maze, frameWidth, frameHeight){
	var centerX = index%width;
	var centerY = index/width;
	return returnFrame2(centerX, centerY, width, height, maze, frameWidth, frameHeight);
}

function isOutBound(indexX, indexY, width, height){
	if(indexX < 0 || indexX >= width)
		return 1;
	if(indexY < 0 || indexY >= height)
		return 1;
	return 0;
}

function returnFrame2(centerX, centerY, width, height, maze, frameWidth, frameHeight){
	//var frameSize = 11;
	var frame = new Array();
	for(var i=0; i<frameHeight; i++){
		frame[i] = new Array();
	}
	var leftCornerX = centerX - (frameHeight-1)/2;
	var leftCornerY = centerY - (frameWidth-1)/2;

	for(var i=leftCornerX; i<leftCornerX+frameHeight; i++){
		for(var j=leftCornerY; j<leftCornerY+frameWidth; j++){
			if(isOutBound(i, j, width, height)>0)
				frame[i-leftCornerX][j-leftCornerY] = 1;
			else
				frame[i-leftCornerX][j-leftCornerY] = maze[j*width+i];
		}
	}
	return frame;
}

function pathFinder(sourceX, sourceY, targetX, targetY, frame, frameWidth, frameHeight){
	if(frame[targetX][targetY]==1)
		return new Array();
	
	//var frameSize = 11;
	var path = new Array();
	for(var i=0; i<frameHeight; i++){
		path[i] = new Array();
		for(var j=0; j<frameWidth; j++){
			path[i][j] = 0;
		}
	}
	
	//functions
	function addAdjacent(X, Y, number){
		if(X>0 && frame[X-1][Y]===0 && path[X-1][Y]===0){
			path[X-1][Y] = number+1;
		}
		if(X<frameHeight-1 && frame[X+1][Y]===0 && path[X+1][Y]===0){
			path[X+1][Y] = number+1;
		}
		if(Y<frameWidth-1 && frame[X][Y+1]===0 && path[X][Y+1]===0){
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
	
	var active = 0;
	while(path[targetX][targetY]==0){
		iterations += 1;
		active = 0;
		for(var i=0; i<frameHeight; i++){
			for(var j=0; j<frameWidth; j++){
				if(path[i][j]==iterations){
					addAdjacent(i, j, iterations);
					active = 1;
				}
			}
		}
		if(active==0 && path[targetX][targetY]==0)
			return new Array();
	}
	
	var actions = new Array();
	currentX = targetX;
	currentY = targetY;
	for(var step = path[targetX][targetY]-1; step>0; step--){
		console.log(currentX);
		if(currentX>0 && path[currentX-1][currentY]==step){
			currentX = currentX - 1;
			actions.unshift([1,0]);
		}
		else if(currentX<frameHeight-1 && path[currentX+1][currentY]==step){
			currentX = currentX + 1;
			actions.unshift([-1,0]);
		}
		else if(currentY>0 && path[currentX][currentY-1]==step){
			currentY = currentY - 1;
			actions.unshift([0,1]);
		}
		else if(currentY<frameWidth-1 && path[currentX][currentY+1]==step){
			currentY = currentY + 1;
			actions.unshift([0,-1]);
		}
	}
	
	return actions;
}

function realTimeActions(actions){
	var actions1 = new Array();
	actions1.push(actions[0]);
	for(var i=1; i<actions.length; i++){
		actions1.push(actions[i]);
		actions1[i][0] += actions[i-1][0];
		actions1[i][1] += actions[i-1][1];
	}
	return actions1;
}

//test
/*
var height = 31;
var width = 31;

var maze = generateMaze(width, height, "myURL");

var mazeOutput = "Results:</br>";
for(var i = 0; i<maze.length; i++){
    mazeOutput += maze[i];
    if(i%width==(width-1)){
        mazeOutput += "</br>"
    }
}
document.write(mazeOutput);

var frame = returnFrame2(0,5, width, height, maze);
mazeOutput = "</br>Results2:</br>";
for(var i = 0; i<frame.length; i++){
	for(var j=0; j<frame[i].length; j++){
		mazeOutput += frame[i][j];
	}
    mazeOutput += "</br>"
}
document.write(mazeOutput);

var actions = pathFinder(5,5,5,4, frame);
actions = realTimeActions(actions);
mazeOutput = "</br>Results3:</br>";
for(var i = 0; i<actions.length; i++){
	for(var j=0; j<actions[i].length; j++){
		mazeOutput += actions[i][j];
	}
    mazeOutput += "</br>"
}
document.write(mazeOutput);
*/