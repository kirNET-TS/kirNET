@echo off
setlocal enabledelayedexpansion
title TEXT ADVENTURE

:: ===== HANDLE COMMAND LINE PARAMETERS =====
if "%~1"==":video" goto :video
if "%~1"==":menu" goto :menu
if "%~1"==":game" goto :game
if "%~1"==":warn" goto :warn

:: ===== CONFIG LOAD =====
if exist config.sys (
    set "lineCount=0"
    for /f "tokens=* delims=" %%A in (config.sys) do (
        set /a lineCount+=1
        if !lineCount! EQU 1 set "SCREEN_MODE=%%A"
        if !lineCount! EQU 2 set "SCREEN_RATIO=%%A"
        if !lineCount! EQU 3 set "SCREEN_SIZE=%%A"
        if !lineCount! EQU 4 set "COLOR=%%A"
        if !lineCount! EQU 5 set "SOUND=%%A"
        if !lineCount! EQU 6 set "DEVMODE=%%A"
        if !lineCount! EQU 7 set "DEVCOMM=%%A"
    )
) else (
    set "SCREEN_MODE=WINDOWED"
    set "SCREEN_RATIO=16:9"
    set "SCREEN_SIZE=MEDIUM"
    set "COLOR=1"
    set "SOUND=1"
    set "DEVMODE=0"
    set "DEVCOMM=0"
)

:: ===== APPLY VIDEO SETTINGS =====
call :apply_video
call :apply_color
if "!SCREEN_MODE!"=="FULLSCREEN" (
    start /max "" "%~f0" :warn
    exit
) else if "!SCREEN_MODE!"=="WINDOWED" (
	start "" "%~f0" :warn
	exit
)
call :apply_color

:: ===== GO TO EPILEPSY WARNING =====
goto :warn

:warn
call :apply_color
cls
echo.
echo                                                [ EPILEPSY WARNING ]
echo.
echo                                         This game has flashing lights, colors
echo                                      and quick transitions. If you have epilepsy,
echo.
echo                                             EXIT THE GAME IMMEDIATELY^^!
echo.
echo                             To proceed, type "I really want to proceed", then choose "YES".
echo                                           or type "EXIT" to exit the game.
echo.
set /p input="> "
if /I "!input!"=="I really want to proceed" (
	echo Are you SURE you want to proceed?
	choice /c YN /m "Y/N> "
	if ERRORLEVEL 2 exit
	if ERRORLEVEL 1 cls &goto start
) else if /I "!input!"==" I really want to proceed" (
	echo Are you SURE you want to proceed?
	choice /c YN /m "Y/N> "
	if ERRORLEVEL 2 exit
	if ERRORLEVEL 1 cls &goto start
) else if /I "!input!"=="Exit" (
	exit
) else cls &goto warn

:start
title kirill5756 presents. . .
echo.
echo.
echo.
echo.        Presented by:
echo.
echo.         kirill5756
echo.
echo.
echo.
::echo.     (C) Copilot All rights reserved.
echo.     (C) kirill5756 All rights reserved.
echo.     (C) DeepSeek All rights reserved.
timeout 5 > nul

:title_start
title 
cls
color 1F
timeout /t 0 >nul
color 2F
timeout /t 0 >nul
color 4F
timeout /t 0 >nul
:title
title 
color 0F
timeout /t 1 >nul
echo.
timeout /t 0 >nul
echo.
timeout /t 0 >nul
echo.
timeout /t 0 >nul
echo.                     TTTTT  EEEEE  X   X  TTTTT
timeout /t 0 >nul
echo.                      T    E       X X     T  
timeout /t 0 >nul
echo.                     T    EEEE     X      T  
timeout /t 0 >nul
echo.                    T    E       X X     T  
timeout /t 0 >nul
echo.                   T    EEEEE  X   X    T  
timeout /t 0 >nul
echo.
timeout /t 0 >nul
echo.
timeout /t 0 >nul
echo.   ###   ###    #   #  #####  ##    #  #####  #   #  ###   #####  ##
timeout /t 0 >nul
echo.  #   #  #  #   #   #  #      # #   #    #    #   #  #  #  #      ##
timeout /t 0 >nul
echo.  #####  #   #   # #   ####   #  #  #    #    #   #  ###   ####   #
timeout /t 0 >nul
echo.  #   #  #  #    # #   #      #   # #    #    #   #  # #   #      
timeout /t 0 >nul
echo.  #   #  ###      #    #####  #    ##    #     ###   #  #  #####  #
timeout /t 0 >nul
echo.
timeout /t 0 >nul
echo.
timeout /t 0 >nul
echo.
title === TEXT ADVENTURE^^! ===
pause

:menu
title === TEXT ADVENTURE^^! - MENU ===
echo. ==== MAIN MENU ====
echo.
echo.     1. NEW GAME
echo.     2. LOAD
echo.     3. SETTINGS
echo.     4. EXIT
echo.
echo. Press a number to choose
echo. a menu option (1-4).
echo.
choice /c 12349 /m "Option: " /n
if ERRORLEVEL 5 goto devmode
if ERRORLEVEL 4 exit
if ERRORLEVEL 3 goto settings
if ERRORLEVEL 2 goto load
if ERRORLEVEL 1 goto new

:devmode
title That's none of your business.
cls
if "!DEVMODE!"=="1" (
	echo. ==== DEVELOPER MODE ====
	echo.
	echo. 1. DISABLE DEV MODE
) else (
	echo. ==== DEVELOPER MENU ====
	echo.
	echo. 1. ENABLE DEV MODE
)
if "!DEVCOMM!"=="1" (
	echo. 2. DISABLE DEBUG COMMANDS
) else (
	echo. 2. ENABLE DEBUG COMMANDS
) 
if "!ToggleDebugLog!"=="1" (
	echo. 3. DISABLE DEBUG LOG
) else (
	echo. 3. ENABLE DEBUG LOG
)
echo. 4. EXIT TO TITLE
echo.
echo. Press a number to choose 
echo. a menu option (1-4).
echo.
choice /c 1234 /m "Option: " /n
if ERRORLEVEL 4 cls &goto title
if ERRORLEVEL 3 call :toggledebuglog &goto devmode
if ERRORLEVEL 2 call :devcomm &goto devmode
if ERRORLEVEL 1 (
	if "!DEVMODE!"=="1" (
		set DEVMODE=0
	) else set DEVMODE=1
	cls
	goto devmode
)

:settings
title === TEXT ADVENTURE^^! - SETTINGS ===
cls
echo. ===== SETTINGS =====
echo.
echo.   X. SOUND
echo.   2. VIDEO
echo.   X. GAMEPLAY
echo.   4. BACK TO MENU
echo.
echo. Press a number to choose
echo. a menu option (1-4).
echo.
choice /c 24 /m "Option: " /n
if ERRORLEVEL 2 cls &goto title
if ERRORLEVEL 1 goto video

:video
cls
echo. ===== VIDEO SETTINGS =====
echo.
echo. 1. MODE : !SCREEN_MODE!
echo. 2. RATIO: !SCREEN_RATIO!
echo. 3. SIZE : !SCREEN_SIZE!
echo. 4. COLOR: !COLOR!
echo. 5. BACK
echo.
echo. Press a number to choose
echo. a menu option (1-5).
echo.
choice /c 12345 /m "Option: " /n
if ERRORLEVEL 5 goto settings
if ERRORLEVEL 4 call :toggle_color &call :save_config &call :apply_color &goto video
if ERRORLEVEL 3 call :toggle_size &call :save_config &call :apply_video &goto video
if ERRORLEVEL 2 call :toggle_ratio &call :save_config &call :apply_video &goto video
if ERRORLEVEL 1 call :toggle_mode &call :save_config &call :apply_video &call :apply_fullscreen &call :apply_color &goto video

:load
:: Check if the file exists
if exist save.txt (
	:: Initialize line count
	set "lineCount=0"
	for /f "tokens=* delims=" %%A in (save.txt) do (
		set /a lineCount+=1
		if !lineCount! EQU 1 set "Name=%%A"
		if !lineCount! EQU 2 set "Room=%%A"
		if !lineCount! EQU 3 set "Inventory=%%A"
		if !lineCount! EQU 4 set "HasDoorKey=%%A"
		if !lineCount! EQU 5 set "HasReadStory=%%A"
	)
	goto game-start
) else (
	echo. . . . but there was nothing to LOAD.
	pause
	goto title
)

:new
cls
:: Assign default values
echo.
echo.
set /p Name="NAME YOUR CHARACTER: "
set "Inventory=Torch, Stick"
set "Room=1"
set "HasDoorKey=0"
set "HasReadStory=0"

:game-start
cls
if "!HasReadStory!"=="1" (
	goto game
)
echo.
echo [ Press any key to advance through dialogue. . . ]
echo.
echo Long ago, when the Grass was shining bright and the Sun was green, there was a human, called "%Name%".
pause >nul
echo One day, they went on a walk to a Forest nearby, but they didn't know, that an incredible Adventure is
echo waiting for them there.
pause >nul
echo Walking around, they tripped on a stick and fell into a weird cave, where the only exit was blocked
echo off.
pause >nul
echo Further in, they found a gigantic door, a torch and a stick.
pause >nul
echo And this is your wonderful adventure.
pause >nul
set "HasReadStory=1"
cls

:game
title GAME?
echo Actions:
echo ==========================================================================#
echo "Look around" - Look around and try to find something useful.             #
echo "Inventory"   - Shows the Contents of your INVENTORY.                     #
echo "Check" (item)- Prints the information about an Item from your INVENTORY. #
echo "Toss (item)" - Tosses an Item from your INVENTORY.                       #
echo "Use (item)"  - Uses an Item from your INVENTORY.                         #
echo "Save"        - Saves your progress.                                      #
echo "Exit"        - Exits the game to menu.                                   #
echo ==========================================================================#
set "Action="
set /p Action="GAME> "
goto Logic

:Logic
for /f "tokens=* delims= " %%A in ("%Action%") do set Action=%%A

:: 1. SAVE
if /I "!Action!"=="Save" (
	call :SaveGame
	timeout 3 > nul
	cls
	goto game
)

:: 2. LOOK AROUND
if /I "!Action!"=="Look around" (
	if "!Room!"=="1" (
		echo You looked around... behind you is a Way, which you followed earlier to come here.
		echo In front of you stands a gigantic door with a sign on it.
		echo It reads:
		echo "If you are reading this, you are stuck. Here, have this Key to open this door!"

		if /I "!HasDoorKey!"=="1" (
			echo . . .but the key was already in your INVENTORY.
			echo You decided to open the door.
			pause
			set "Room=2"
			cls
			goto game
		) else (
			echo Underneath it lies a key.
			choice /c YN /m "Take the key? "	
			if ERRORLEVEL 2 (
				echo You left the key be.
				pause 
				cls
				goto game
			)
			if ERRORLEVEL 1 (
				echo You picked up the Key.
				echo DoorKey was added to your INVENTORY.
				set "NewItem=DoorKey"
				set "HasDoorKey=1"
				call :ItemGot
				pause
				cls
				goto game
			)
		)
	) else if "!Room!"=="2" (
		echo The Hall of Echoes.
		echo You hear whispers. One says: "The key is not enough."
		echo You find a rusty old key on the floor.
		set "NewItem=RustyKey"
		call :ItemGot
		set "Room=3"
		pause
		cls
		goto game
	
	) else if "!Room!"=="3" (
		echo The Garden of Stone Flowers.
		echo Beautiful statues everywhere. One has a golden petal.
		echo You pick it up.
		set "NewItem=GoldenPetal"
		call :ItemGot
		set "Room=4"
		pause
		cls
		goto game
	
	) else if "!Room!"=="4" (
		echo The Forgotten Library.
		echo A book glows on the pedestal.
		echo You read: "The door opens when all keys are gathered."
		set "NewItem=GlowingBook"
		call :ItemGot
		set "Room=5"
		pause
		cls
		goto game
	
	) else if "!Room!"=="5" (
		echo The Chamber of Whispers.
		echo A ghost appears: "Give me something precious."
		echo %Inventory% | findstr /i /c:"GoldenPetal" >nul
		if not errorlevel 1 (
			echo You give the Golden Petal. The ghost thanks you.
			echo "Take this Magic Coin."
			set "NewItem=MagicCoin"
			call :ItemGot
			set "Room=6"
		) else (
			echo You have nothing precious. The ghost fades.
			set "Room=6"
		)
		pause
		cls
		goto game
	
	) else if "!Room!"=="6" (
		echo The Clockwork Corridor.
		echo Gears ticking. You find a note: "3:00 is the answer."
		set "Room=7"
		pause
		cls
		goto game
	
	) else if "!Room!"=="7" (
		echo The Mirror Maze.
		echo You see yourself in many mirrors.
		echo One mirror shows you holding a key.
		echo You reach in and grab it!
		set "NewItem=SilverKey"
		call :ItemGot
		set "Room=8"
		pause
		cls
		goto game
	
	) else if "!Room!"=="8" (
		echo The Throne Room.
		echo A king sits on the throne, made of shadows.
		echo "Prove your worth. Show me your rarest item."
		echo %Inventory% | findstr /i /c:"MagicCoin" >nul
		if not errorlevel 1 (
			echo The king accepts the Magic Coin.
			echo "You may pass."
			set "Room=9"
		) else (
			echo The king laughs. "You have nothing rare."
			echo "I'll let you pass anyway... for now."
			set "Room=9"
		)
		pause
		cls
		goto game
	
	) else if "!Room!"=="9" (
		echo The Bridge of Whispers.
		echo A voice says: "To cross, you must answer:"
		echo "What has cities, but no houses; mountains, but no trees?"
		choice /c 123 /m "1. Map  2. Dream  3. Sky"
		if errorlevel 3 (
			echo Correct! You cross safely.
			set "Room=10"
		) else (
			echo Wrong! You fall into the abyss...
			goto ending_bad
		)
		pause
		cls
		goto game
	
	) else if "!Room!"=="10" (
		echo The Final Corridor.
		echo You see a door with 4 keyholes.
		echo You have: !Inventory!
		pause
		echo The door glows. It recognizes your keys.
		set "Room=12"
		pause
		cls
		goto game

	) else if "!Room!"=="12" (
		cls
		echo You reach the final chamber.
		timeout /t 3 >nul
		echo A door stands in front of you. It looks familiar...
		timeout /t 3 >nul

		if "!HasDoorKey!"=="1" (
			echo You reach into your pocket... the key is still there.
			timeout /t 3 >nul
			echo You insert it. The door opens.
			timeout /t 3 >nul
			echo A breeze hits your face. You are free.
			pause
			goto :ending_good
		) else (
			echo You reach into your pocket... but it's empty.
			timeout /t 3 >nul
			echo The door remains shut.
			timeout /t 3 >nul
			echo You remember the key... long gone.
			pause
		    goto :ending_bad
		)
	)
	pause
	cls
	goto game
)

:: 3. EXIT
if /I "!Action!"=="Exit" (
	echo. Exit? All unsaved progress will be lost!
	timeout /t 3
	echo.
	choice /c YN /m "Really exit to Menu? "
	if ERRORLEVEL 2 cls &goto game
	if ERRORLEVEL 1 cls &goto Title_start
)

:: 4. TOSS
for /f "tokens=1,* delims= " %%a in ("!Action!") do (
	if /I "%%a"=="Toss" (
		set "TossItem=%%b"
		if defined TossItem (
			call :RemoveItem "!TossItem!"
			echo !TossItem! was thrown away.
			if /I "!TossItem!"=="DoorKey" (
				set "HasDoorKey=0"
				echo.
				echo For some reason, for a brief moment. . .
				echo you felt like you lost something important.
			)
			pause
			cls
			goto game
		) else (
			echo Toss what?
			pause
			cls
			goto game
		)
	)
)

:: 5. CHECK
for /f "tokens=1,* delims= " %%a in ("!Action!") do (
	if /I "%%a"=="Check" (
		set "CheckItem=%%b"
		if defined CheckItem (
			call :InspectItem "!CheckItem!"
			pause
			cls
			goto game
		) else (
			echo Check what?
			pause
			cls
			goto game
		)
	)
)

:: 6. USE
for /f "tokens=1,* delims= " %%a in ("!Action!") do (
	if /I "%%a"=="Use" (
		set "UseItem=%%b"
		if defined UseItem (
			call :UseItem "!UseItem!"
			pause
			cls
			goto game
		) else (
			echo Use what?
			pause
			cls
			goto game
		)
	)
)

:: 8. DEV
if /I "!Action!"=="Dev"(
	title That's none of your business.
	cls
	if "!DEVMODE!"=="1" (
		echo. ==== DEVELOPER MODE ====
		echo.
		echo. 1. DISABLE DEV MODE
	) else (
		echo. ==== DEVELOPER MENU ====
		echo.
		echo. 1. ENABLE DEV MODE
	)
	if "!DEVCOMM!"=="1" (
		echo. 2. DISABLE DEBUG COMMANDS
	) else (
		echo. 2. ENABLE DEBUG COMMANDS
	) 
	if "!ToggleDebugLog!"=="1" (
		echo. 3. DISABLE DEBUG LOG
	) else (
		echo. 3. ENABLE DEBUG LOG
	)
	echo. 4. EXIT TO TITLE
	echo.
	echo. Press a number to choose 
	echo. a menu option (1-4).
	echo.
	choice /c 1234 /m "Option: " /n
	if ERRORLEVEL 4 cls &goto game
	if ERRORLEVEL 3 call :toggledebuglog &goto devmode
	if ERRORLEVEL 2 call :devcomm &goto devmode
	if ERRORLEVEL 1 (
		if "!DEVMODE!"=="1" (
			set DEVMODE=0
		) else set DEVMODE=1
		cls
		goto devmode
	)
)

:: 7. INVENTORY
if /I "!Action!"=="Inventory" (
	cls
	echo ========== INVENTORY ==========
	set "count=0"
	for %%i in (%Inventory%) do (
		set /a count+=1
		echo !count!. %%i
	)
	if !count!==0 echo (empty)
	echo ================================
	echo Total items: !count!/10
	pause
	cls
	goto game
)

:: 9. NOPE!
echo Nope!
timeout 3 > nul
cls
goto game

if /I "!Aсtiоn!"=="Break out" (
	set /p Code="ENTER SECRET CODE: "
	if /I "!Code!"=="UP,DOWN,LEFT,RIGHT,A,START" (
		echo Correct code!
		echo You got the ChaosRing!
		echo You got the InfMoney!
		echo You used ChaosRing to break out of the cave!
		goto ending_secret
	)
)

:TestZone
title You shouldn't be here.
cls
echo [TEST ZONE - NPC SANDBOX]
timeout /t 1 > nul
echo You enter a room with strange smiling figures.
echo They don't move. But they speak.
timeout /t 2 > nul
echo.
echo NPC_01: Welcome to test NPC! I hope that you will have a nice day.
echo NPC_02: This is where I learned to speak. I never stopped.
echo NPC_03: The devs forgot to delete me. I'm glad.
echo.
echo You feel... strangely comforted.
timeout 5 > nul
goto :ending_dev

:ending_secret
title The true ending.
cls
echo.    
echo.     Congratulations^^!
echo.
echo.
echo.    You did the best you could do^^!
echo.    %Name% is living his best live a
echo.    human could ever have still to 
echo.    these days.
echo.
echo.     Thank you for doing your best!
echo.
pause
exit

:ending_good
title Your reward.
cls
echo.    
echo.     Congratulations^^!
echo.
echo.
echo.    You won a good ending^^!
echo.    %Name% escaped the caves
echo.    and had a beautiful life.
echo.
echo.     Thank you for playing!
echo.
pause
exit

:ending_bad
title YOU DID BAD
cls
echo. 
echo.     [Game Over!]
echo.
echo.
echo.    You did bad.
echo.    %Name% never made it out and
echo.    died in the caves.
echo.
echo.     Thank you for trying!
echo.
pause
exit

:ending_dev
title WORK IN PROGRESS^^!
cls
echo. [DEVELOPER ENDING]
echo.
echo. That's the end of the game right now.
echo. Thank you for testing the Development version^^!
echo.
echo. We are still working on this game,
echo. I hope hou had fun!
echo.
echo.    So. . .
echo.    TO BE CONTINUED.
pause
exit


:InspectItem
set "ToDescribe=%~1"

if /I "%ToDescribe%"=="DoorKey" (
	echo DoorKey - a key with a piece of Paper, which reads: "Gigantic door".
)

if /I "%ToDescribe%"=="Torch" (
	echo "Torch" - a simple wooden stick with oil-soaked cloth. Smells like old adventures.
)

if /I "%ToDescribe%"=="Stick" (
	echo "Stick" - Weapon, 1AT. Its bark is worse than its bite.
	echo It seems familiar to you.
)

::if /I "%ToDescribe%"=="Copilot" (
::	echo Copilot - not quite human, not quite machine. they hummle a melody you can't forget. Also, they are writing
::	echo something, but you can't understand it.
::)

goto :eof




:RemoveItem
set "Remove=%~1"

:: Delete "Remove" from "Inventory"
set "NewInventory="
for %%i in (%Inventory%) do (
	if /I not "%%i"=="!Remove!" (
		if defined NewInventory (
			set "NewInventory=!NewInventory!, %%i"
		) else (
			set "NewInventory=%%i"
		)
	)
)
set "Inventory=!NewInventory!"
echo Updated Inventory: !Inventory!
goto :eof





:CheckItem
set "Check=%~1"
echo %Inventory% | findstr /i /c:"%Check%" >nul
if errorlevel 1 (
	exit /b 1
) else (
	exit /b 0
)



:UseItem
set "Item=%~1"

if /I "!Item!"=="Torch" (
	echo You lit up the room using Torch!
	echo . . .nothing else happened.
)

goto :eof




::How To Call
::call :SaveGame

:SaveGame
echo Saving. . .
(
	echo !Name!
	echo !Room!
	echo !Inventory!
	echo !HasDoorKey!
	echo !HasReadStory!
) > "%~dp0save.txt"
timeout /t 3 > nul
echo Game saved.
goto :eof





::How To Call
::1. set "NewItem="
::2. call ItemGot

:ItemGot
:: Check if item is already in the inventory
echo %Inventory% | findstr /i /c:"%NewItem%" >nul
if errorlevel 1 (
	:: Item not found, add it
	if not "%Inventory%"=="" (
		set "Inventory=%Inventory%, %NewItem%"
	) else (
		set "Inventory=%NewItem%"
	)
) else (
	echo You already have "%NewItem%" in your inventory.
)

:: Optional: display inventory
echo Current Inventory: %Inventory%
goto :eof

:toggledebuglog
if "!ToggleDebugLog!"=="1" (
	set ToggleDebugLog=0
) else set ToggleDebugLog=1
goto :eof

:devcomm
if "!DEVCOMM!"=="1" (
	set DEVCOMM=0
) else set DEVCOMM=1
goto :eof

:toggle_sound
if "!SOUND!"=="1" (set SOUND=0) else (set SOUND=1)
goto :eof

:toggle_color
if "!COLOR!"=="1" (
    set COLOR=0
    color 0F
) else (
    set COLOR=1
    color 0A
)
goto :eof

:toggle_mode
if "!SCREEN_MODE!"=="WINDOWED" (
    set SCREEN_MODE=FULLSCREEN
) else (
    set SCREEN_MODE=WINDOWED
)
goto :eof

:toggle_ratio
if "!SCREEN_RATIO!"=="16:9" (
    set SCREEN_RATIO=4:3
) else (
    set SCREEN_RATIO=16:9
)
goto :eof

:toggle_size
if "!SCREEN_SIZE!"=="SMALL" (
    set SCREEN_SIZE=MEDIUM
) else if "!SCREEN_SIZE!"=="MEDIUM" (
    set SCREEN_SIZE=LARGE
) else (
    set SCREEN_SIZE=SMALL
)
goto :eof

:apply_video
if "!SCREEN_SIZE!"=="SMALL" (mode con: cols=80 lines=25)
if "!SCREEN_SIZE!"=="MEDIUM" (mode con: cols=100 lines=30)
if "!SCREEN_SIZE!"=="LARGE" (mode con: cols=120 lines=35)
if "!SCREEN_RATIO!"=="4:3" (
    mode con: cols=80 lines=30
) else (
    mode con: cols=100 lines=30
)
if "!COLOR!"=="1" (color 0A) else (color 0F)
powershell -command "& {$w=New-Object -ComObject WScript.Shell; $w.AppActivate('TEXT ADVENTURE'); $w.SendKeys('%{ }x')}" 2>nul
goto :eof

:save_config
(
    echo !SCREEN_MODE!
    echo !SCREEN_RATIO!
    echo !SCREEN_SIZE!
    echo !COLOR!
    echo !SOUND!
    echo !DEVMODE!
    echo !DEVCOMM!
) > "%~dp0config.sys"
goto :eof

:apply_fullscreen
if "!SCREEN_MODE!"=="FULLSCREEN" (
    start /max "" "%~f0" :video
    exit
) else if "!SCREEN_MODE!"=="WINDOWED" (
	start "" "%~f0" :video
	exit
)
goto :eof

:apply_color
if "!COLOR!"=="1" (color 0A) else (color 0F)
goto :eof