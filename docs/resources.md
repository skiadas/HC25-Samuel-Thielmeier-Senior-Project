# Idea 1: Rougelike Game

## Link to Phaser's main site
<p>https://phaser.io/</p>
<p>The phaser game engine is an opensource resource that enables anyone to code their own web game with the engine. You can pay for a subscription to get access to the Phaser editor, but I don't really feel a need to
because I've worked with the engine before back in my freshman year. So since I'm already familiar with a lot of the mechanics the engine offers, which the phaser editor helps with simplifying the work I don't need to use the editor.</p>

![Phaser logo](https://cdn.phaser.io/images/logo/logo-download-vector.png)

## Link to Phaser Rougelike games
<p>https://itch.io/games/made-with-phaser/tag-roguelike</p>
<p>A lot of the games shown on the site, while rougelikes are mainly <b>turn-based</b> games. I want to create a <b>real-time</b> game where the user has to actievly be moving around to dodge/block attacks.
I want my game to remind the user of the classic <b>Legend of Zelda</b> game that originally came out on the <b>NES</b>.</p>

![image from the Legend of Zelda](https://upload.wikimedia.org/wikipedia/en/thumb/3/3a/Legend_of_Zelda_NES.PNG/220px-Legend_of_Zelda_NES.PNG)

<p>One of the games on the site mentioned above <b>Rouge Fable III</b> offeres multiple different classes for the user to try. As I think that would be too much to start with, it will be something I keep
on the back burner in my mind as something I want to try to implement</p>

![Image of title of Rouge Fable III](https://img.itch.zone/aW1nLzE2NjI0NjEucG5n/315x250%23c/9uLyof.png)

## Link to Godot Documentation Resource
<p>https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html</p>
<p>Godot is another game engine/editor, but looks to offer a lot more resources than phaser. Both Godot and Phaser are both open source, but the editor for Godot is free which makes me debate using it versus Phaser. It is much more versitile, it boasts a number of different features. One of which is the ability to directly edit assets in the editor with Sprite Painter.</p>

![Godot logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQccrRW7QJQ2fjV36LzPmtMfaro6UCgCQLyEw&s)

<p> While I probably will just be sticking to a standard 2D game, Godot's engine makes it easy to code very beautiful 2D & 3D games. I think the sprite painter feature will also make it easier to create attack animations by just editing whatever spritesheet I use for my main character. Below are some screenshots from popular games made with Godot.</p>
<p><b>Brotato</b></p>

![Brotato](https://play-lh.googleusercontent.com/PCNm7iRhXYeFSuyuzlW4TgNvf7nvJJV-z8DU1nrOL0JasFWZuqdkaYtOvqkoE5LX1Q=w526-h296-rw)

<p><b>Ex-Zodiac</b></p>

![Ex-Zodiac](https://i0.wp.com/thebetanetwork.net/wp-content/uploads/2022/07/Vocals.00_00_06_16.Still003.jpg?resize=800%2C450&ssl=1)

## Link to game engine discussion
<p>https://www.reddit.com/r/gamedev/comments/rrg0z4/what_is_a_good_engine_to_make_2d_games_in/</p>
<p>The reddit thread above links to a discussion deciding the best engine to make a 2d game in. The consitent suggestions throughout the thread are: Godot, Unity, and Construct 3. Unity is better for 3D games,
and actually renders 2D games as 3D, which accourding to some users can cause some unwanted errors with the camera. Construct 3, appears to be a great choice for 2D games, and offers a simplifed way to create the game with minimal coding. I think for my game, I will be using Godot as it appears to have the most features, and a large community that uploads free assets for people to use.</p>

![Construct 3 Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg25dUnSl2-BjXCZA8MqPgrm9UsoTzpA-udw&s) ![Unity-Symbol](https://github.com/user-attachments/assets/9e98d52e-066a-4f73-b263-d11a5cf401fc)

## Platform 

<p>Planning on making it work in a web page setting first, godot makes it interchangeable so I might try making it multi-platform. Found a resource on the Godot Assets community page that provides mapping for all keyboards and controllers, with automatic remapping system. </p>
<p>https://godotengine.org/asset-library/asset/2565</p>

![contorller1](https://github.com/user-attachments/assets/0b0af31c-978e-4cde-9ef3-ffa9f6312566) ![controller2](https://github.com/user-attachments/assets/78fe7313-23d6-48a2-b266-f2d88b35c8b1)

## Programming Language
<p>The officially supported languages for the Godot Engine are: C#, C++, and GDScript (a custom godot language with syntax similar to python). Unlike Python, GDScript is optimized for Godot's scene-based architecture and can specify strict typing of variables.</p>

## Other Useful Assets I found

### Shape Texture 2d
<p>https://godotengine.org/asset-library/asset/2917</p>
<p>ShapeTexture2D is a resource for generating textures from simple shapes. Useful for prototype/placeholder textures, particle effects and GUI elements like buttons, icons and panels. Supports gradients for both fill and strokes (border).</p>

### Simple Enemy AI
<p>https://godotengine.org/asset-library/asset/2956</p>
<p>A demo that shows how to make an enemy follow the player using NavigationRegion2D. A tutorial video to achieve this is linked on the page.</p>

### 2D Revealer
<p>https://godotengine.org/asset-library/asset/3182</p>
<p>Provides tooling to quickly reveal/conceal canvas items in Godot. Used to emulate depth in 2d games eg entering buildings in side scrollers.</p>

### Better Terrain
<p>https://godotengine.org/asset-library/asset/1806</p>
<p>TileMapLayer terrain system that allows for simpler, more flexible rules. It covers all features of Godot 3's autotiles, along with big improvements on Godot 4's rule system, and has a straightforward API for applying and updating terrains from code.</p>

### Rapier Physics 2D
<p>https://godotengine.org/asset-library/asset/2267</p>
<p>A 2D drop-in replacement for the Godot engine that adds stability and fluids. This version is deterministic, just not cross platform deterministic.</p>

### Burst Particles 2D
<p>https://godotengine.org/asset-library/asset/1814</p>
<p>Make cool, chunky one-shot particle effects with textures, curves and gradients.</p>

## Free Character / Enemies sprite sheets

### Enemies Pixel Art for TD Free Pack
<p>https://free-game-assets.itch.io/free-field-enemies-pixel-art-for-tower-defense</p>
<p>Includes 4 enemy types: Small Green Slime, Evil Wolf, Big Goblin, Flying Bee</p>

### Lucifer Warrior Free Pack
<p>https://foozlecc.itch.io/lucifer-warrior</p>
<p>4 direction warrior with 10 animations in each direction. Great for action RPG type games. All animations include the .ase file in addition to the sprite sheets.</p>
