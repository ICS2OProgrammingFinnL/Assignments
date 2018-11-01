-----------------------------------------------------------------------------------------
--Title: Math Quiz
--Name: Finn
--Course: ICS20
--This program asks different math questions
-----------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background" , 200/255, 50/255, 255/255)


--------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------------------

--load and play the music
local CorrectSound = audio.loadSound("Sounds/correctSound.mp3")
local CorrectChannel
--load and play the music
local WrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local WrongChannel

-- create my local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local temp

local pefectSquare
local userAnswer
local correctAnswer
local incorrectAnswer
local randomOperator
local startingPoints = 0
local points
local gameOverImage
local trophy
local youWinImage
local exponent


--variables for the  timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countdownTimer

--variables for the lives
local lives = 3
local heart1
local heart2
local heart3
----------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------




local function UpdateLives()


	if (lives == 2 ) then
		heart1.isVisible = false
	elseif ( lives == 1) then
		heart2.isVisible = false
	elseif ( lives == 0) then 
		heart3.isVisible = false
		gameOverImage.isVisible = true
		numericField.isVisible = false
		questionObject.isVisible = false
		clockText.isVisible = false
		points.isVisible = false
	end
end		

local function UpdateTime() 

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object
	clockText.text = secondsLeft .. " Seconds Left!"

		if (secondsLeft == 0 ) then
			-- reset the number of seconds left
			secondsLeft = totalSeconds
			lives = lives - 1
			--call the function to makea life go away
			UpdateLives()
			-- call the function to reset timer
			UpdateTime()
	end
end			


--functions that calls the timer
local function StartTimer()
	-- Create a countdown timer that loops infinitely
	countdownTimer = timer.performWithDelay( 1500, UpdateTime, 0)
end





local function AskQuestion() 
	-- generate 3 random numbers between a max. and a min. number
	randomOperator = math.random(4,4)

	--addition
	if (randomOperator == 1) then
		
		randomNumber1 = math.random(0, 20)
		randomNumber2 = math.random(0, 20)

		correctAnswer = randomNumber1 + randomNumber2

		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
		--subtraction
	elseif (randomOperator == 2) then

		randomNumber1 = math.random(0, 20)
		randomNumber2 = math.random(0, 20)

			if(randomNumber2 > randomNumber1) then
				--if the first number is less than the second, swith the order they come in
				correctAnswer = randomNumber2 - randomNumber1
				--create question in text object
				questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
			else
				correctAnswer = randomNumber1 - randomNumber2
				--create question in text object
				questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
			end
	--multiplacation
	elseif (randomOperator == 3) then

		randomNumber1 = math.random(0, 10)
		randomNumber2 = math.random(0, 10)

		correctAnswer = randomNumber1 * randomNumber2

		--create question in text object
		questionObject.text = randomNumber1 .. " x " .. randomNumber2 .. " = "


	elseif (randomOperator == 4) then


		randomNumber1 = math.random(0, 10)
		randomNumber2 = math.random(0, 10)

		
		temp = randomNumber1 * randomNumber2
		--division
		correctAnswer = temp / randomNumber2




		--create question in text object
		questionObject.text = temp .. " / " .. randomNumber2 .. " = "



	
	-- 
	elseif (randomOperator == 5) then

		randomNumber1 = math.random(1,5)
		randomNumber2 = math.random(1,4)
		--make the exponent
		exponent = math.pow(randomNumber1, randomNumber2)
		--exponent
		correctAnswer = exponent

		--create question in text object
		questionObject.text = randomNumber1 .. " ^ " .. randomNumber2 .. " = "

	elseif(randomOperator == 6)	then
		randomNumber1 = math.random(1, 10)

		-- square the number
		temp = randomNumber1 * randomNumber1

		--square root
		correctAnswer = math.sqrt(temp)

		--create question in text object
		questionObject.text = temp .. " sqrt = "



	end
end





local function YouWin()
	if (startingPoints == 5 ) then
		trophy.isVisible = true
		youWinImage.isVisible = true
		numericField.isVisible = false
		questionObject.isVisible = false
		clockText.isVisible = false
		points.isVisible = false
		heart1.isVisible = false
		heart2.isVisible = false
		heart3.isVisible = false
	end
end




	

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener(event)

	-- user begins editing "numeric field"
	if ( event.phase == "began") then
		---clear text field
		event.target.text = ""

		elseif event.phase == "submitted" then 
			-- when the answer is (enter key is pressed) set user input to user's answer
			userAnswer = tonumber(event.target.text)

			-- if the users answer and the correct answer are the same:
			if (userAnswer == correctAnswer) then 
				correctObject.isVisible = true
				CorrectChannel = audio.play(CorrectSound)
				startingPoints = startingPoints + 1
				timer.performWithDelay(1000, HideCorrect)
				YouWin()
				secondsLeft = totalSeconds


				--display the points going up
				points.text = " Number Correct = " .. startingPoints
			else
				--if they aren't the same
				incorrectObject.isVisible = true
				WrongChannel = audio.play(WrongSound)
				timer.performWithDelay(2500, HideIncorrect)
				--get rid of 1 life
				lives = lives - 1
				UpdateLives()
				--reset timer
				secondsLeft = totalSeconds
				incorrectObject.text = " Incorrect, the correct answer was  " .. correctAnswer
			end

			event.target.text = ""
		end
    end




---------------------------------------------------------------------------------------------
--OBJECT CREATION
--------------------------------------------------------------------------------------------
-- game over image with width and height 
gameOverImage = display.newImageRect("Images/gameOver.png" , 1100, 900)
gameOverImage.isVisible = false
gameOverImage.x = 515
gameOverImage.y = 400
--displays a  question and sets the colour
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(0/255, 255/255, 100/255)

points = display.newText("Number Correct = " .. startingPoints , display.contentWidth/1.4, display.contentHeight/2, nil, 50 )
points:setTextColor(155/255, 100/255, 100/255)
points.y = display.contentHeight/6

--create the correct text object and make it visible
correctObject = display.newText ("Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(255/255, 10/255, 50/255)
correctObject.isVisible = false


incorrectObject = display.newText ("Incorrect" , display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(255/255, 10/255, 50/255)
incorrectObject.isVisible = false


--create numeric field 
numericField = native .newTextField( display.contentWidth/1.8, display.contentHeight/2, 150, 80)
numericField.inputType = "display"

numericField:addEventListener( "userInput", NumericFieldListener )
--add thier event listener for the numeric field

--dislay heart shapes
heart1 = display.newImageRect("Images/heart.png" , 100,100)
heart2 = display.newImageRect("Images/heart.png" , 100,100)
heart3 = display.newImageRect("Images/heart.png" ,  100,100)



-- set the initial x and y position of the hearts
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 3.5/4

heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 3.5/4

heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 3.5/4

--display the timer
clockText = display.newText (secondsLeft .. " Seconds left!" , 150,100, nil, 35)

--trophy
trophy = display.newImageRect("Images/Trophy.png" , 200,200)
trophy.isVisible = false
trophy.x = display.contentWidth/2
trophy.y = display.contentHeight/5

youWinImage = display.newImageRect("Images/YouWin.png" , 900, 300)
youWinImage.isVisible = false
youWinImage.x = 515
youWinImage.y = 400
----------------------------------------------------------------------------------------------
--FUNCTION CALLS
---------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()

--start the timer
StartTimer()