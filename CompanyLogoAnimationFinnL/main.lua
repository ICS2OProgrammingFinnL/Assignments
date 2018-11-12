-----------------------------------------------------------------------------------------
--Name:
-- Title: Company Logo Animation
-- course:ICS20
-- this will display the company lgog before playing the game 
-----------------------------------------------------------------------------------------
-- set the background colour of myscreen. Remember that colours are between 0 and 1.
display.setDefault("background" , 20/255, 20/255, 20/255)


-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set the spped that the company logo is moving
scrollSpeed = 3


--diplsay company name
local name = display.newText("Dark Excalibur" ,  400, 100, nil,  75)

name.alpha = 0

-- logo image with width and height
local logo = display.newImageRect("Images/CompanyLogoFinn.png" , 200, 200)

-- set the image to be transparent
logo.alpha = 0


--load and play the music
local sword = audio.loadSound("Sounds/sword.mp3")
local swordChannel

-- set the initial x and y position of beetleship
logo.x = 200
logo.y = display.contentHeight/3

--this function makes the comapny name fade in
local function NameFadeIn()
	-- add to the alpha
	name.alpha = name.alpha + 0.006

end


--this function makes the logo invisible
local function invisible()
	logo.isVisible = false
end	


--this function displays the company name



-- Function: MoveLogo
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the X-value of the ship
local function MoveLogo(event)
	 -- add the scroll speed to the x-value of the ship
	 logo.x = logo.x + scrollSpeed
	 -- change the transparency of the ship every time it moves so that it fades in
	 logo.alpha = logo.alpha + 0.01
	 logo:scale(1.005,1.005)
end	 



-- Movelogo and NameFadeIn will be called over and over again
Runtime:addEventListener("enterFrame" , MoveLogo)
Runtime:addEventListener("enterFrame" , NameFadeIn)

timer.performWithDelay(5000, invisible)



swordChannel = audio.play(sword)