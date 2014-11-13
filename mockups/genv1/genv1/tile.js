
//==  VARS  ==================================================================//

var grid,gridWidth,gridHeight;
var puzzleLs = [];
var doorLs   = [];
var exitLs   = [];
var roomLs   = [];
var CAPuzzleLs = [];
var CADoorLs   = [];
var cellSize = 9;
var padding  = 0;

var accessCtr = 0;
var playerX = 3;
var playerY = 3;

var mouseX = 0;
var mouseY = 0;

//==  ACCESS-RELATED  ========================================================//

function updateAccessableToPlayer(doorDepth){
	doorDepth = doorDepth || Infinity;
	CADoorLs = [];
	CAPuzzleLs = [];
	++accessCtr;
	function recurse(x,y,doorCtr){
		if(!grid[x][y].isTraversable || grid[x][y].lastAccess == accessCtr)
			return;

		var d = doorCtr + ((grid[x][y].type == 'd') ? 1 : 0);
		if(grid[x][y].type == 'd')
			CADoorLs.push(grid[x][y]);
		if(grid[x][y].type == 'p' && grid[x][y].doorLs.length < 5)
			CAPuzzleLs.push(grid[x][y]);
		grid[x][y].lastAccess = accessCtr;
		grid[x][y].doorsAway = d;
		if(d >= doorDepth)
			return;

		recurse(x,y-1,d);
		recurse(x,y+1,d);
		recurse(x-1,y,d);
		recurse(x+1,y,d);
	}
	recurse(playerX,playerY,0);
}

//==  CONNECT PUZZLES TO DOORS AND DETERMINE START STATE  ====================//

function generateConnections(){
	var roomtracker = [];
	var maxbacktracking = 0;
	var depth = 0;

	function helper(door, depth){
			playerX = door.x;
			playerY = door.y;
			var mydepth = depth;
			//choose a random accessible puzzle
			var puzz = CAPuzzleLs[rint(CAPuzzleLs.length)];
			if(!puzz)
				return depth;
			playerX = puzz.x;
			playerY = puzz.y;
			puzz.doorLs.push(door);
			door.puzzleLs.push(puzz);
			door.isTraversable = false;
			//puzz.onAction();
			if(!roomtracker[puzz.room.uuid])
				roomtracker[puzz.room.uuid] = 0;
			roomtracker[puzz.room.uuid]++;

			updateAccessableToPlayer();
			if(CADoorLs.length == 0)
				return depth;


			for(var d in puzz.room.doorLs){
				var newdoor = puzz.room.doorLs[d];
				console.log("depth " + depth + " " + newdoor);
				if(newdoor.isTraversable){
					mydepth = Math.max(helper(newdoor, depth+1), mydepth);
				}
			}
			// helper(CADoorLs[rint(CADoorLs.length)]);
			return mydepth;

		}

	while(depth < 30 && maxbacktracking < 2){

		// cleanup any previous attempts
		for(var p in puzzleLs)puzzleLs[p].doorLs = [];
		for(var d in doorLs){
			doorLs[d].isTraversable = true;
			doorLs[d].puzzleLs = [];
		}
		roomtracker = [];


		// // randomly assign connections and initial states
		// for(var p in puzzleLs){
		// 	playerX = puzzleLs[p].x;
		// 	playerY = puzzleLs[p].y;
		// 	updateAccessableToPlayer(2);
		// 	for(var d in doorLs)if(doorLs[d].lastAccess == accessCtr && !rInt(2)){
		// 		puzzleLs[p].doorLs.push(doorLs[d]);
		// 		doorLs[d].puzzleLs.push(puzzleLs[p]);
		// 	}if(rInt(2))puzzleLs[p].onAction();
		// }for(var d in doorLs)if(rInt(2))doorLs[d].toggle();

		// Start at exits

		for(var d in exitLs){
			playerX = exitLs[d].x;
			playerY = exitLs[d].y;
			updateAccessableToPlayer();
			depth = Math.max(helper(exitLs[d], 0), depth);
		}

		for(var u in roomtracker){
			if(roomtracker[u] > maxbacktracking)
				maxbacktracking = u;
		}
	}

}

function createPath(){
	// have player traverse from exit to initial position

	// newPuzzles
	// unvisitedPuzzles
	updateAccessableToPlayer();
}

//==  INITIALIZATION  ========================================================//

function init(){
	var map = m1;
	gridHeight = map.length;
	gridWidth = map[0].length;

	grid = [];
	for(var i=0;i<gridWidth;++i){
		grid[i] = [];
		for(var j=0;j<gridHeight;++j)grid[i][j] = new tile(i,j,map[j][i]);
	}

	findRooms();

	generateConnections();
	createPath();

	canvas.width  = gridWidth*(cellSize+padding)-padding;
	canvas.height = gridHeight*(cellSize+padding)-padding;
}


// TILE & ROOM

function findRooms(){
	//get a temporary grid
	var tempGrid = [];
	for(var i=0;i<gridWidth;++i){
		tempGrid[i] = [];
		for(var j=0;j<gridHeight;++j)tempGrid[i][j] = false;
	}

	for(var i=0;i<gridWidth;++i){
		for(var j=0;j<gridHeight;++j){
			if(tempGrid[i][j])
				continue;
			var room = new Room();
			var realRoom = false;
			var todo = [{x:i, y:j}];
			while(todo.length > 0){
				var current = todo.pop();
				var x = current.x;
				var y = current.y;
				var type = grid[x][y].type;
				if(tempGrid[x][y] && type !== 'd')
						continue;
				if(type == 'd'){
					room.doorLs.push(grid[x][y]);

					continue;
				}
				tempGrid[x][y] = true;
				if(type == 'w' || type == '-'){
					continue;
				}
				realRoom = true;

				//console.log(x + ", " + y);
				if(type == 'f' || type == 'x'){
					grid[x][y].room = room;
					room.tileLs.push(grid[x][y]);
				}
				if(type == 'x'){
					exitRoom = room; //assumes only one exit...!
				}
				if(type == 'p'){
					grid[x][y].room = room;
					room.puzzleLs.push(grid[x][y]);
				}
				if(x > 0 && !tempGrid[x-1][y]) todo.push({x:x-1,y:y});
				if(x < gridWidth-1 && !tempGrid[x+1][y]) todo.push({x:x+1,y:y});
				if(y > 0 && !tempGrid[x][y-1]) todo.push({x:x,y:y-1});
				if(y < gridHeight-1 && !tempGrid[x][y+1]) todo.push({x:x,y:y+1});

			}
			if(realRoom){
				roomLs.push(room);
				for(var d in room.doorLs){
					room.doorLs[d].roomLs.push(room);
				}
			}
		}
	}
	exitLs = exitRoom.doorLs;
}

var rid = 0;
var Room = function(){
	this.uuid = rid++;
	this.doorLs   = [];
	this.tileLs   = [];
	this.puzzleLs = [];
}


var tile = function(x,y,typeChar){

	this.x             = x;
	this.y             = y;
	this.type          = typeChar;
	this.isTraversable = false;

	this.lastAccess = 0;
	this.doorsAway  = 0; // valid when lastAccess == accessCtr

	this.onEnter  = function(){/* by default do nothing */};
	this.onAction = function(){/* by default do nothing */};
	this.onExit   = function(){/* by default do nothing */};
	this.setColor = function(){rgb(0,0,0);};

	switch(typeChar){

	case 'f': // --------------------------------------------- FLOOR

		this.room = null; //unknown yet
		this.isTraversable = true;
		this.setColor = function(){
			if(this.lastAccess == accessCtr)rgb(0.5,0.5,0.5);
			else rgb(0.1,0.1,0.1);
		};
		break;

	case 'x': // ---------------------------------------------- EXIT

		this.isTraversable = true;
		this.onEnter = function(){console.log("YOU WIN");};
		this.setColor = function(){
			if(this.lastAccess == accessCtr)rgb(0.5,0.5,0.5);
			else rgb(0.1,0.1,0.1);
		};
		break;

	case 'w': // ---------------------------------------------- WALL

		this.setColor = function(){rgb(0.3,0.3,0.3);};
		break;

	case 'p': // -------------------------------------------- PUZZLE

		this.room = null; //unknown yet
		puzzleLs.push(this);
		this.isTraversable = true;
		this.toggleState = false;
		this.doorLs = [];
		this.onAction = function(){
			this.toggleState=!this.toggleState;
			for(var d in this.doorLs)this.doorLs[d].toggle();
			updateAccessableToPlayer();
		};
		this.setColor = function(){
			if(this.toggleState)rgb(0,1,0);
			else rgb(1,0,0);
		};
		break;

	case 'd': // ---------------------------------------------- DOOR

		doorLs.push(this);
		this.roomLs = [];
		this.puzzleLs = [];
		this.isTraversable = true;
		this.toggle = function(){this.isTraversable=!this.isTraversable;}
		this.setColor = function(){
			if(this.isTraversable)rgb(0.5,0.5,0.5);
			else rgb(0.1,0.1,0.1);
		};
		break;

	}
}
