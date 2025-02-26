# Terminal Games

It was a fun project that helped me learn more about the ANSI/ASCII characters and terminal input/output manipulation. Also my first Ruby project.

<br/>

# NOTE
Windows CMD and PowerShell don't support getting user input without pausing the program. The easiest workaround is to run a second thread responsible only for user input (I'll update the code eventually).

<br/>

# Installation

Clone the GitHub repository into the current folder:
```
git clone https://github.com/Me-Wosh/TerminalGames.git
```

<br/>

Navigate to the specific game folder (SpaceInvaders / Snake):

<br/>

Run program with ruby:
```
ruby main.rb
```

<br/>

To check if you have ruby installed type:
```
ruby -v
```

If you don't have ruby installed I highly recommend installing it with a manager (rbenv, chruby, etc.), especially if you are on macOS and don't want to spend your entire day installing Ruby just because macOS already comes with Ruby installed and making it use the correct version is a pain in the ass.

More installation info: https://www.ruby-lang.org/en/documentation/installation/

<br/>

# Space Invaders

### It features (I believe) all mechanics that the original game had, that is:
* Moving player character
* Shooting at enemies
* Enemies moving at intervals and shooting back at the player
* Special faster enemy that spawns once in a while and rewards bonus points if shot
* Shields that block both enemy bullets and player bullets
* Lives that can regenerate if certain conditions are met
* Level ups

### Short demo

https://github.com/Me-Wosh/TerminalGames/assets/101999705/ed841a42-6333-4cfa-86cc-1a69ee8854a9

<br/>

# Snake

### Features:
* 2 Game modes - classic and speed
* Collision with body and border
* Menu
* Eating food to grow in size
* Game over screen

### Game modes (speed game mode is artificially boosted to illustrate the idea), collision with border
https://github.com/Me-Wosh/TerminalGames/assets/101999705/f3eb7cc2-8697-4382-97e8-2c1def4ee230

### Collision with body
https://github.com/Me-Wosh/TerminalGames/assets/101999705/b1011a47-0410-463d-bae2-a7abe32a2cd4

### Menu
https://github.com/Me-Wosh/TerminalGames/assets/101999705/ad8afba3-8f0c-4ad0-93ea-d9e44e37b76d

# Flappy Bird

Work in progress.
