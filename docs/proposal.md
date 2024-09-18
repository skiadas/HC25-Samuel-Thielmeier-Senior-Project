# My Project Proposal

## Gameplay Goals
<p>The game I plan to create will be a rougelike. I want to my game to be the user exploring a world, with dungeons, caves, forests, etc. Enemies will be scattered throughout this world, with the number and strength of the enimes increasing the further in the user explores. The game will be a top-down 2D 'retro' style game, similar to the first <b>Legend of Zelda</b> game. I plan on having 8 directional movement, with at least 3 different types of attacks: normal, smash, and tackle (which will double as a dodge mechanic). I have found multiple 'grunt' enemies, but I also plan to have 'bosses' before the player can continue to the next area. While the grunt enemies may have just a simple "follow and attack" type of script, I plan to have the bosses follow an attack pattern, where the player would have to dodge projectiles/wide-range attacks.</p>

## Where I'm creating my Game
<p>The Godot Game Engine[1] is cross-platform, open-sourced, and capable of being installed through steam for free. The development engine can run on multiple platforms to create games(eg; Linux, macOS, Windows) and games created can then be exported to more platforms(eg; HTML, both Andriod and iOS phones/tablets, and even consoles like Xbox and Playstation). Godot enables developers to create both 3D and 2D games using multiple programming languages, such as C++, C#, and GDScript (a programming language exclusive to the Godot game engine). GDScript shares a lot of similarities to Python, so it is pretty easy to pick up if your familar with Python already.</p>

![Godot_icon svg (1)](https://github.com/user-attachments/assets/406ea17b-dae4-4c37-96fe-b9138f450965)


## Character Assets I plan to Use
<p> itch.io is a online community where developers can find and sell assets. A creater on there, Foozle[2], offers multiple assets for free that are available to be used for commercial/non-commercial games. If you go to his page on itch.io, there are dozens of both sprite sheets, tilesets, and tilemaps for users to download. I personally really like the design of the sprites in the 'Lucifier' section.</p>

![warrior](https://github.com/user-attachments/assets/62d2c027-5d41-4db0-9939-05dda44cddf3)![goblin](https://github.com/user-attachments/assets/9df36918-5b8d-437b-b9fa-013e9029c56d)![skeleton](https://github.com/user-attachments/assets/d30ee197-b9d7-442a-b201-62abe3ff5a23)

## Physics Engine I plan to use
<p> The Godot Engine uses a built-in physics engine, PhysicsServer2D[3], which can directly create and manipulate all physics objects. PhysicsServer2D offers four different types of physics bodies: Area2D, StaticBody2D, RigidBody2D, and CharacterBody2D. Issues users might encounter when using PhysicsServer2D might include: unstable and wobbly stacked objects, unstable cylinder collision shapes, unreliable physics simulation when far away from the world origin. In Godot 4.x, users are able to use GDExtension to integrate their own physics. The Rapier Physics 2D[4] is one of these third party extensions. There are 2 versions of this physics engine, one that is crossplatform deterministic, which is the version I plan to use. Going to the github page for the Rapier Physics 2D, users are able to see the physic engine at work, showcasing the engine's stability, fluids (2D and 3D), and ghost collisions (which is being compared to Godot's physics engine). From looking at these short demos, the Rapier Physics engine appears much more stable and consistent than the built in engine.</p>



## References
<p>[1] The Godot Foundation, "Your free, open-source game engine," [Online]. Available: https://godotengine.org/. [Accessed: September 13, 2024]</p>
<p>[2] Foozle, "Free game assets," [Online]. Available: https://foozlecc.itch.io/. [Accessed: September 14, 2024]</p>
<p>[3] </p>

