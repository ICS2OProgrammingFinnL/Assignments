-----------------------------------------------------------------------------------------
--Name:Finn Leduc
--Course: ICS20
-- This program will make shapes with colour. The background will also be covered
-----------------------------------------------------------------------------------------
--create my local variables for the triangle
local halfWTri = display.contentWidth * 0.2
local halfHTri= display.contentHeight * 0.2
local vertices = {50,-100, 150,-250, 250,-250}
local triangle 

local o = display.newPolygon( halfWTri, halfHTri, vertices )
o.fill = { type="JPEG", filename="NorthernLights.JPEG" }
o.strokeWidth = 10
o:setStrokeColor( 1, 1, 0 )

triangle = display.newText("This is a scalene triangle" , 200, 50, nil, 35 )

-- to remove status bar
display.setStatusBar(display.HiddenStatusBar)


-- set the background colour of myscreen. Remember that colours are between 0 and 1.
display.setDefault("background" , 100/255, 20/255, 60/255) 
