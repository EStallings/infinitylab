function rint(n){ return Math.floor(Math.random()*n); }

//==  RENDER CURRENT STATE  ==================================================//

function render(){
	rgb(0,0,0);
	rect(0,0,canvas.width,canvas.height);

	var cs = cellSize;
	var csp = cs+padding;
	for(var i=0;i<gridWidth;++i)for(var j=0;j<gridHeight;++j){
		grid[i][j].setColor();
		rect(i*csp,j*csp,i*csp+cs,j*csp+cs);
	}

	function tileToList(x,y,ls){
		for(var i in ls){
			line(x*csp+cs/2,y*csp+cs/2,ls[i].x*csp+cs/2,ls[i].y*csp+cs/2);
			circle(ls[i].x*csp+cs/2,ls[i].y*csp+cs/2,cs/3);
		}
	}

	gfx.lineWidth = 3;
	rgba(0,0,1,0.5);
	if(grid[playerX][playerY].type == 'p')tileToList(playerX,playerY,grid[playerX][playerY].doorLs);
	if(grid[playerX][playerY].type == 'd')tileToList(playerX,playerY,grid[playerX][playerY].puzzleLs);
	rgba(1,1,0,0.5);
	if(grid[mouseX][mouseY].type == 'p')tileToList(mouseX,mouseY,grid[mouseX][mouseY].doorLs);
	if(grid[mouseX][mouseY].type == 'd')tileToList(mouseX,mouseY,grid[mouseX][mouseY].puzzleLs);

	rgb(1,1,1);
	circle(playerX*csp+cs/2,playerY*csp+cs/2,cs*0.7);
}

//==  CONTROLS  ==============================================================//

canvas.addEventListener("mouseup",function(e){
	var rect = canvas.getBoundingClientRect();
	mouseX = Math.floor((e.clientX-rect.left)/(cellSize+padding));
	mouseY = Math.floor((e.clientY-rect.top)/(cellSize+padding));
	render();
});

document.addEventListener("keyup",function(e){
	function movePlayerTo(dx,dy){
		if(!grid[playerX+dx][playerY+dy].isTraversable)return;
		grid[playerX][playerY].onExit();
		grid[playerX+dx][playerY+dy].onEnter();
		playerX += dx;
		playerY += dy;
	};

	switch(e.keyCode){
		case 87 /*     w */ : movePlayerTo( 0,-1);break;
		case 83 /*     s */ : movePlayerTo( 0,+1);break;
		case 65 /*     a */ : movePlayerTo(-1, 0);break;
		case 68 /*     d */ : movePlayerTo(+1, 0);break;
		case 32 /* space */ : grid[playerX][playerY].onAction();break;
	}render();
});
