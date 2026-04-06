pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function _init()

game_state="play"

-- player attributes
px=60
py=120
pspd=2

--bullet attributes
bullets={}

--invader attributes
invaders = {}
inv_dir = 1
inv_speed = 0.1

for y=0,3 do
 for x=0,7 do
  add(invaders,{
   x=20+x*12,
   y=10+y*10,
   alive=true
  })
	 end
	end
end

function _update()

--game reset
if game_state != "play" then
	if btnp(❎) then
	_init()
	end
	return
	end
--game state logic update
if game_state != "play" then
		return
	end

--win condition
if #invaders == 0 then
	game_state = "win"
end

--lose condition 
for i in all(invaders) do 
	if i.y > 120 then
		game_state = "lose"
		end
end

--move player
	if btn(⬅️) then
	px-=pspd
	end
	if btn(➡️) then
	px+=pspd
	end
	--shoot
	if btnp(❎) then
	add(bullets,{x=px,y=py-4})
	end
	--update bullets
	for b in all(bullets) do
	b.y-=4
		if b.y<0 then
		del(bullets,b)
		end
	end
	
	-- bullet collisions
	for b in all(bullets) do
		for i in all(invaders) do
			if abs(b.x-i.x)<5 and abs(b.y-i.y)<5 then
				del(bullets,b)
				del(invaders,i)
				break
				end
			end
	end
	
	-- move invaders
	local edge = false

	for i in all(invaders) do
 	i.x += inv_dir * inv_speed
 		if i.x < 5 or i.x > 115 then
  	edge = true
 		end
	end

	if edge then
 inv_dir *= -1
 	for i in all(invaders) do
  	i.y += 6
 	end
	end			
end


function _draw()
cls()

--different game screens
if game_state == "play" then
	draw_game()
	
elseif game_state == "win" then
	print("you saved the day",50,50,11)
	print("press ❎ to restart")
elseif game_state =="lose" then
	print("game over",44,60,8)
	print("print ❎ to restart")
end
end

-- drawing gameplay
function draw_game()
--draw player
 spr(1,px,py)
--bullets
	for b in all(bullets) do
  spr(3,b.x,b.y)
		end
--invaders
	for i in all(invaders) do
	spr(2,i.x,i.y)
	end			
end


__gfx__
00000000000000000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003300003300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000003030030300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000220003000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000220003303303300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700022222200333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000222222220030030000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000222002220300003000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
