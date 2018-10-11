-----------------------------------------------------------------------------------------
--Title: Animating Images
--Name: Finn
--Course: ICS20
--This program will move PNG images in different directions with different effects on the screen 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variable
scrollSpeed = 2.5

--local variable for my text
local signature



-- background image with width and height 
local backgroundImage = display.newImageRect("Images/space.jpg" , 2048, 1536)

-- display my text
signature = display.newText("From: Finn" ,  900, 100, nil,  35)

signature:setTextColor(150/255, 200/255, 150/255)

-- meteor image with width and height
local meteor = display.newImageRect("Images/Comet.png" , 200, 200)

-- planet image with width and height
local planet = display.newImageRect("Images/planet.png" , 400,400)

-- set the x and y position of planet
planet.x = display.contentWidth/1.5
planet.y = display.contentHeight/1.5

local spacerock = display.newImageRect("Images/SpaceRock.png" , 100,100) 

-- set the x and y position of the spacerock
spacerock.x = display.contentWidth/2
spacerock.y = display.contentHeight/3

-- explosion image with width and height
local explosion = display.newImageRect("Images/explosion.png" , 200, 200)

-- set the x and y position of the explosion
explosion.x = display.contentWidth/2
explosion.y = display.contentHeight/1.5

-- create the variable for my sound
local explosionSound = audio.loadSound("Sounds/Explosion.wav")
local explosionSoundChannel
-- Function: MoveMeteor
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the X-value of the ship
-- This function also grows
local function MoveMeteor(event)
	 -- add the scroll speed to the x-value of the ship
	 meteor.x = meteor.x + scrollSpeed
	 meteor.y = meteor.y + scrollSpeed
	 -- change the alpha of the ship every time it moves so that it fades out
	 meteor.alpha = meteor.alpha - 0.001 
	 --load the sound
	explosionSoundChannel = audio.play(explosionSound)
end

-- MoveShip will be called over and over again
Runtime:addEventListener("enterFrame" , MoveMeteor)