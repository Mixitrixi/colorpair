active = 0
start = null
stopp = 0
level = 0
radie = 50
counter = 0
col = [255,0,0]
d = [-1,1,0]

class Ball
	constructor : (@x, @y, @dx, @dy, @r, @g, @b) ->
		@active = true
	rita : ->
		if not @active then return 
		if @x > width-radie then @dx = -@dx
		if @x < radie then @dx = -@dx
		@x += @dx

		if @y > height-radie then @dy = -@dy else @dy+=0.1

		@y += @dy
		fc @r,@g,@b
		circle @x,@y,radie
	inside : (mx,my) -> dist(@x,@y,mx,my) < radie

balls = []

setup = ->
	createCanvas windowWidth,windowHeight
	radie = (windowWidth+windowHeight)/30
	reset()

reset =->
	level++
	radie *= 0.95
	start = new Date()
	for i in range level
		createBall()

draw = ->
	background col[0],col[1],col[2]
	for ball in balls
		ball.rita()
	if active==0
		sc 0
		sw 3
		fc 1
		textSize 50
		textAlign CENTER,CENTER
		text (stopp-start)/1000,width/2,height/2

	if frameCount%2 == 0
		counter++
		if counter % 257 == 256
			for i in range 3
				d[i] = if col[i] > 128 then _.random -1,0 else _.random 0,1
		else col[i] += d[i] for i in range 3



mousePressed = ->
	if active == 0
		reset()
	else
		for i in range balls.length-1,-1,-1
			ball=balls[i]
			if ball.active and ball.inside mouseX,mouseY 
				ball.active = false
				active--
				if active == 0
					stopp = new Date() 
				break

createBall = ->
	active++
	x = random 50,width
	y = random 50,100
	dx = random -2,2
	dy = random -0.3,0.3

	
	r = random 1
	g = random 1
	b = random 1
	balls.push new Ball x,y,dx,dy,r,g,b
