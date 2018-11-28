-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local name
local logo
local scrollSpeed = 3
local swordSound = audio.loadSound("Sounds/sword.mp3")
local swordSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the logo across the screen
local function moveLogo()
     -- add the scroll speed to the x-value of the logo
     logo.x = logo.x + scrollSpeed
     -- change the transparency of the logo every time it moves so that it fades in
     logo.alpha = logo.alpha + 0.01
end  

local function NameFadeIn()
    -- add to the alpha
    name.alpha = name.alpha + 0.006

end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 20/255, 20/255, 20/255)

    -- Insert the logo image
    logo = display.newImageRect("Images/CompanyLogoFinn.png", 600, 400)

    -- set the initial x and y position of the logo
    logo.x = 100
    logo.y = display.contentHeight/2

    --set the alpha of logo to 0
    logo.alpha = 0

    --diplsay company name
     name = display.newText("Dark Excalibur" ,  400, 100, nil,  75)
        --set the alpha of name to 0
        name.alpha = 0


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( name )
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        swordSoundChannel = audio.play(swordSound )

        -- Call the movelogo function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveLogo)

         -- Call the movelogo function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", NameFadeIn)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 5000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the sword channel for this screen
        audio.stop(swordSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
