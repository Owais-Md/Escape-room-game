# EscapeRoomGame

#### This is a game I've made for my Zense Project

## Game Details

The player has been sent to a room where the player is given instructions on how to interact with the game. The game gives the player multiple hints and multiple puzzles, so that after solving each puzzle the player can go ahead to a new room, and finally the player must find the hidden room, so that the player can solve the final puzzle, and then win the game.

## Installation

Go to the [releases](https://github.com/Owais-Md/Escape-room-game/releases/tag/v1.0.0) section and download EscapeRoomGame.zip file.
You can extract the file and run EscapeRoomGame.exe to start the game.


## Accredition
Used Spritesheets by Laena Zimmerman, from [Spritesheets](https://opengameart.org/content/tiny-16-basic) under the creative commons license [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/).

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Implementation details (Description of each file)
### Conf.lua:
##### Sets window name and specifies window size.

### Main.lua:
##### Imports all necessary files, and initializes instances of all objects used inside the game, i.e, statestack, menu, player, background, and another object called gameobjects that handles all the other objects.
##### Has functions for load, update, and draw, and also passes keypresses to gameobjects.


### StateStack.lua:
##### The basic concept on which the game works, with multiple objects in the game that can be updated, and mulitple objects that can take input, input needs to be handled in such a way that only the object at the top of the stack is recieving input at a time.
##### So, statestack has background at bottom, on which player state is passed. At every iteration, both background and player are updated, but only player recieves input.
##### When a dialogBox or the menu is pushed to the stack, player is no longer recieving inputs, and the respective state at top recieves inputs.

### TableIO.lua
##### Has the functions load and dump that I use for saving and loading the game progress, in a file called  progress.save.

### Player.lua:
##### Uses the opensource libraries named anim8 and windfield to handle animation of player sprite, and to handle collisions between player and objects. Also has a feature to change the sprite of the player by changing the animation frames.
##### Player also returns a player.world table that has colliders for the player, and for the objects that will be generated by Background.lua


### TilesetDataGenerator.lua:
##### Uses basictiles.lua and things.lua, that were exported from Tiled, that is the map creation software that I used to create tilesets from the SpriteSheets by Laena Zimmerman which i obatined from https://opengameart.org/content/tiny-16-basic under the creative commons license CC BY 3.0.
##### This file generates quads, and also generates tileids and tile timers that I use later in Background.lua for the animation of the background which are necessary to intrepret the data from other files I export from Tiled.


### Interactable Animations.lua:
##### Uses things.png, and generates quads for the frames for interactable objects inside the game.
##### Can create new objects like chests, doors and levers, all of which can be either locked or opened or closed from the game, by interacting with them.
##### Each interactable object has its own timer and a frame count, so that if a button is held for a particular time when interacting with the object, the timer increases and changes the frame accordingly.
##### Also allows objects to be drawn flipped vertical or horizontal or both.


### Background.lua:
##### Uses Room1 to Room8.lua and Hidden Room.lua that I also created and exported from Tiled.
##### This file also uses Interactable Animations.lua and TilesetDataGenerator.lua that I mentioned above to load and render the background from the generated tilesets, and also handles animations that keep running in the background (The torches).
##### It also creates windfield colliders in player.world so that the player can interact with the background.

### Dialog.lua

##### Creates a dialogBox class that is used to create a global dialogBox object and another dialogBox inside the menu. The dialogBox class has functions to push, clear or to display the dialogBox.

### Menu.lua

##### Has its own menuStack on which current menu state gets pushed to top and all states are rendered from bottom up, so that whenever a menu state gets exited, the state below gets rendered.
##### Provides a "NewGame" state, a "midGame" state, and a "GameWon" state, and also provides buttons to Save the Game, Load a saved game, to show credits(gives credits to Laena Zimmerman for providing spritesheets), to go back or to exit the game.

### MenuButtons.lua

##### Creates all the buttons used inside Menu.lua, and has code for all of the functions that the buttons in Menu.lua call

### Game_Data.lua

##### Stores all of the information needed to operate every single interactable object in the game, and their states.
##### Also has text for each object at every state
##### Controls how a player moves from one room to the other, by the reloading game objects into different states
##### Evaluates each object that is interacted with and changes the states of that object and other objects accordingly
##### Takes inputs from the user and manipulates the correct objects accordingly
##### Detects if the Game was won and passes the "GameWon" to StateStack and menu.
