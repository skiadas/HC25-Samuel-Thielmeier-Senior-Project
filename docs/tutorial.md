# How to make a "smart" Enemy AI
## The objective
<p> The goal for this tutorial is to expand on an already existing enemy AI to make it react when the player enters a specific range</p>

## Prerequisites before starting
* You already have Godot installed and open on your device.
* You have assets to use for your player and enemy (png images will work)

## Before we start
* Before starting this tutorial, you should follow along with this video on youtube (https://www.youtube.com/watch?v=Ykz7W9BHzPg) which walks you through making an enemy AI to follow the player
* After watching the video you should have an enemy AI that follows the player wherever they are in the game world, we will be changing this functionality so it only follows the player when they
 enter a specified range.
* Your code should look something like this
![Screenshot 2024-11-14 143138](https://github.com/user-attachments/assets/ed7e5f25-6b15-4cc0-8599-689e524d4fc9)

## Explaining the existing functionality before moving on
* The navigation agent we set up helps the AI to understand where it can and cannot move, so that the AI knows to move around specified walls
* The **global_positon** takes the position of target_to_chase and keeps track of it wherever it is in the game world.
* The **target_to_chase** is what the AI will follow, you have to be sure to assign it in your game scene.
* To assign it click the enemy node in the game scene, the inspector tool should appear off to the side
* Look in the inspector tool for the target_to_chase variable

![Screenshot 2024-11-14 143905](https://github.com/user-attachments/assets/b88f2c61-ff4d-4a29-a87c-1547ed848c46)

* While still in the game scene inspecting your enemy, drag the player from the game's child nodes to the slot

![Screenshot 2024-11-14 144328](https://github.com/user-attachments/assets/24ac5b69-4b5a-4bee-b3a8-4f63dfcbf89d)

* The inspector window should look like this if done correctly

![Screenshot 2024-11-14 144429](https://github.com/user-attachments/assets/35edd61e-dcaf-4fb9-9486-8a48bd10ae92)

* Now your enemy should follow the player around the map, you can change the target_to_chase if you want the enemy to follow something else

* If you want to skip this and automatically have the enemy chasing the "Player" group, add in the **_process(delta)** function to look something like this.

![Screenshot 2024-11-15 124845](https://github.com/user-attachments/assets/9349f5b0-375d-4ac3-87b5-134470e558a1)

* Before continuing go to your player script and put in **add_to_group("Player")**
* This will add your player to a group called "Player" which we will need for our enemy AI

![Screenshot 2024-11-14 154954](https://github.com/user-attachments/assets/77620196-fc85-4c3a-a9c2-d4e2111ea7a1)

## Making the AI smarter
* Right now the enemy follows the player always no matter the distance between the two, lets change that.
* In your enemy scene create an Area2d node, with a CollisionShape2d child node. Make the collision shape a large circle around the enemy, something like this:

![Screenshot 2024-11-14 151441](https://github.com/user-attachments/assets/4f540915-ffd5-40fc-8a93-274af01e2cb6)

* This will be our enemy's 'territory' so rename the Area2d to match
* We will be adding funcionality so that the enemy only follows the player when they enter this range, feel free to make it as large or small as you want
* Here are the variables I will be using

![Screenshot 2024-11-14 155236](https://github.com/user-attachments/assets/e48049f7-8ce5-4da7-80e9-f4f1241fd2de)


* Since the AI is not supposed to be following the player constantly, we need to create a function that controls the direction the enemy goes until it 'sees' the player
* Lets create a **pick_random_direction()** function for our enemy's basic movement, here is mine:

![Screenshot 2024-11-14 152803](https://github.com/user-attachments/assets/c7078f25-c8d8-4ee3-ab70-6948701cdb72)

* **var new_direction = Vector2.ZERO** -> creates the varible new_direction and initializes it to (0, 0)
* **while new_direction == Vector2.ZERO** -> Insures that the chosen direction is never zero as a zero vector has no direction
* **new_direction = Vector2(randi() % 3 -1, randi() % 3 - 1)** -> Randomizes so that the values of x and y are -1, 0, or 1. randi % 3 gives values 0, 1 , or 2
* **last_direction = new_direction** -> updates the last_direction variable to the newly chosen direction

* Go to your enemy scene and have your enemy script open
* Click on the territory node we created earlier
* Off to the right where the inspector is, click on the Node tab

![Screenshot 2024-11-14 155523](https://github.com/user-attachments/assets/cef0ea1e-493e-41a2-89b1-8175d4eb4d3e)

* We will be using the 'body_entered' and 'body_exited' to control when the enemy 'sees' the player
* Go to an empty line in your enemy script, and double click on 'body_entered' in the Node menu, it will open this window:

![Screenshot 2024-11-14 161325](https://github.com/user-attachments/assets/387ee0da-bb57-49fb-b260-494db66f4d03)

* Click connect, and these lines should be added to your enemy script automatically:

![Screenshot 2024-11-14 161447](https://github.com/user-attachments/assets/0f92bbf1-0129-45a9-bdeb-260db3dfd513)

* Repeat for 'body_exited'
* This will connect the territory Area2d node to your script

* Edit these functions so that they are similar to this:

![Screenshot 2024-11-14 161935](https://github.com/user-attachments/assets/130db0a5-e8c9-4feb-98cf-c69fb2a555bb)

* This checks to see if the body that enters the territory is in the group "Player"
* **run** wil be used to help control the change for if the player is close enough for the enemy to follow
* Lets edit the **_physics_process(delta)** function, here's mine:

![Screenshot 2024-11-14 162538](https://github.com/user-attachments/assets/fb0e3c5d-6694-4156-98d5-ebd6e6e3b17b)

* The **if run:** statement uses the original follow movement we created earlier to follow the player only if run is True
* By defualt run is set to false, so it follows the else statement which uses the **pick_random_direction()** method we created, and the timer in the else statement is
to make sure the enemy changes it's direction after a set time has passed.
* In the 'body_entered' we set run to true for when the player enters the range, and for 'body_exited' run is set to false when the player exits range

## Summary
<p> This tutorial expands on an existing enemy AI to make it "smarter" by only following the player when they enter a specific range. After following
the video tutorial you should have an ememy AI that follows the player. Creating an Area2d node around the enemy to act as a territory we used
'body_entered' and 'body_exited' signals so the enemy can 'see' the player when they enter the territory. When the player is out of range,
the enemy moves around the world randomly, creating a more dynamic AI interaction.</p>

## See also
* Link to github page where code for video is located (https://github.com/Goldenlion5648/SmartEnemyMovementDemo)
* Link to Godot forum for error working with the Nodes (https://forum.godotengine.org/t/cant-seem-to-get-on-node-body-entered-body-working/7854)
