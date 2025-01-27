/*
This is a comment block. It won't be read as an Ink story.
Comments are very useful for leaving ideas for story and functionalty

This exercise will demonstrate the following in the example video:
 - Variable types: integer, float, boolean
 - Variable assignment
 - Printing variables
 - Variable checking
 
 In the assignment:
 - Add four more knots
 - Assign at least TWO new variables through player choices
 - Print at least one of the variables to the player in a passage
 - Check the value of a variable and have it do something
*/

VAR torch = ""
VAR hook = ""
VAR goldBar = ""
VAR diamondStatue = ""
VAR rocks = ""
VAR inventory = 0
VAR tr = 0
VAR sr = 0
VAR dt = 0
VAR dh = 0
VAR dgb = 0
VAR dds = 0
VAR dj = 0

-> cavemouth

== cavemouth ==
You are at the entrance to a cave. {torchpickup: | There is a torch on the floor. } The cave extends to the east and west.
+ {not liteasttunnel or dt == 1} [Take the East Tunnel] -> easttunnel
+ {liteasttunnel && torch != ""} [Take the East Tunnel] -> liteasttunnel
+ [Take the West Tunnel] -> westtunnel
* {inventory <= 2} [Aquire the Majestic Torch] -> torchpickup
* {inventory == 3 && torch == "" && dt == 0} [Aquire the Majestic Torch] -> fullInventory
+ [Check Inventory] -> bag
+ {dt == 1} [Pick up Torch] 
~ dt = 0
~ inventory = inventory + 1
~ torch = "torch"
-> cavemouth
+ {dh == 1 && inventory != 3} [Pick up Grappling Hook] 
~ dh = 0
~ inventory = inventory + 1
~ hook = "Grappling Hook"
-> cavemouth
+ {dgb == 1 && inventory < 2} [Pick up Gold Bar] 
~ dgb = 0
~ inventory = inventory + 2
~ goldBar = "Gold Bar"
-> cavemouth
+ {dds == 1 && inventory <= 1} [Pick up Diamond Statue] 
~ dds = 0
~ inventory = inventory + 3
~ diamondStatue = "Diamond Statue"
-> cavemouth
+ {dj == 1 && inventory <= 1} [Pick up Jewels] 
~ dj = 0
~ inventory = inventory + 3
~ rocks = "Jewels"
-> cavemouth
* [Go Home] -> exit
-> END

== bag ==
You currently are holding: {torch} {hook}  {goldBar}  {diamondStatue}  {rocks} {torch == "" && hook == "" && goldBar == "" && diamondStatue == "" && rocks == "": A big bag of nothing}
+ {torch != ""} [Drop Torch]
~ torch = ""
~ inventory = inventory -1
~ dt = 1
-> cavemouth
+ {hook != ""} [Drop Grappling Hook]
~ hook = ""
~ inventory = inventory -1
~ dh = 1
-> cavemouth
+ {goldBar != ""} [Drop Gold Bar]
~ goldBar = ""
~ inventory = inventory -2
~ dgb = 1
-> cavemouth
+ {diamondStatue != ""} [Drop Diamond Statue]
~ diamondStatue = ""
~ inventory = inventory -3
~ dds = 1
-> cavemouth
+ {rocks != ""} [Drop Jewels]
~ rocks = ""
~ inventory = inventory -3
~ dj = 1
-> cavemouth
+ [Return] -> cavemouth
-> END

== fullInventory ==
You are carrying too much, you must discard some of your items.
+ [Damn]-> cavemouth
-> END

== easttunnel ==
You are in the east tunnel, it is too dark to see anything.
* {torch == "torch"} [Light Torch] -> liteasttunnel
+ [Go Back] -> cavemouth
-> END

== westtunnel ==
You are in the west {not rope && not gold:, there is a minecart in the corner which contains both a bar of gold and a grappling hook.| } {gold && rope && sr == 0: You accidentally bump into the minecart, it shifts greatly revealing a hidden passage underneath it.| {sr == 1: A passage through the floor leads into a ancient altar.}} {not gold && inventory >= 2: you could not possibly carry the gold with you right now}
* {inventory <= 1 && not gold} [Take Gold] -> gold
* {not rope && inventory < 3} [Take Grappling Hook] -> rope
+ {gold && rope} [Enter the mysterious passage]
-> altar
+ [Go Back] -> cavemouth
-> END

== rope ==
You now have a rope{torchpickup:, not as majestic as the torch but its close}.
* [Yipeeeeeee] 
~ inventory = inventory + 1
~ hook = "Grappling hook"
-> westtunnel


== gold ==
You now have to carry around a bar of Gold
* [yay? ]
~ goldBar = "Gold bar"
~ inventory = inventory + 2
-> westtunnel
-> END

=== torchpickup ===
You now have a majestic torch, it is incredibly majestic.
+ [Go Back]
~ torch = "torch" 
~ inventory = inventory + 1
-> cavemouth
-> END

== liteasttunnel ==
{not tresherroom: You can see there is a cliff in front of you and a ledge another 20ft away | The treasure room is on the other side of this cliff with the rope from your grappling hook still hanging from the stalagtite.}
* [You can defintely jump it] -> cliffdeath
* { not tresherroom && rope} [Swing over with rope]
~ inventory = inventory -1
~ hook = ""
-> tresherroom
+ {tresherroom} [Swing to the treasure room on the hook] -> tresherroom
+ [Return to entrance] -> cavemouth
-> END

== cliffdeath ==
You could not jump it, you fall for an enitre minute before you splat on the ground.
-> END

== bouldertrap ==
<b> A completely unexpected boulder comes rolling at you !!!!</b>
* [RRRUUUUUUNNNNNNN] -> exit
* [walk] -> boulderdeath
-> END


== boulderdeath ==
The boulder crushes you in an incredibly grusome scene, you survive just long enough to suffer in agony for a few more minutes.
-> END


== tresherroom ==
{tr == 0: You do the sickest indiana jones on a stalagtite to the ledge and find a room full of jewels with a diamond statue in the center of the room on a pedestal. You lose your grappling hook, it got stuck on the stalagtie and now hangs there.| Your rope  hangs from the stalagtite behind you. }{inventory < 1: You dont have the strength to carry anything else out of here.} 
* {inventory <= 1 && dds == 0}[Take the diamond statue, its so worth it] 
~ inventory = inventory + 2
~ diamondStatue = "Diamond Statue"
-> bouldertrap
* {goldBar != ""} [Swap the Gold Bar and the Diamond Statue]
~ goldBar = ""
~ tr = tr + 1
~ diamondStatue = "Diamond Statue"
-> noBoulderTrap
* {inventory <= 1}[Take the jewels and leave {dds == 0:, the statue is an obvious trap}]
~ inventory = inventory + 3 
-> jewels
+ [Swing back to the East Tunnel] 
~ tr = tr + 1
-> liteasttunnel

-> END


== noBoulderTrap ==
You quickly pick up the statue and set down the gold bar in its place, nothing seems to happen.
* [God damn this is heavy] -> tresherroom
-> END

== jewels ==
You pocket as many jewels as you can and swiftley make your escape.
* [I could buy a house with this many jewels]
~ rocks = "jewels"
-> cavemouth
-> END

== altar == 
{sr == 0: You enter a mysterious room with cryptic writing and mysterious symbols lining the walls. There are four statues in each of the corners all with there eyes missing. In the center you see a stone block, on its sides there are carvings dipicting a masked person stabbing the eyes out of someone laying down. | You are in the the  seceret room. }
* {rocks != ""} [Fill the statues eyes with the jewels] 
~ rocks = ""
-> river
+ [Go Back] 
~ sr = sr + 1
-> westtunnel
-> END


== river ==
{not bonfire: As you put the last gems in, the floor falls out from under you. A long drop lands you in a river of water and you eventually wash up to a bank. {torch != "":Your torch may have been extinguished but}} you can see the light from a fire around the corner of a tunnel.
* [Continue following the river, it must flow to an exit] -> swimming
+ [Follow the light] -> bonfire
-> END

== swimming ==
You get back in the river and start swimming. The water is incredibly cold {bonfire: but your time around the fire keeps you warm}.
* {not bonfire} [The cold is becoming too much] -> riverDeath
* {bonfire} [Push onwards] -> riverExit
-> END

== bonfire ==
There is a small bonfire in the middle of a room with a corridor leading further into the cave. Your torch is to wet to relight, its best you don't continue.
* [follow the path] -> caveDeath
+ [Rest and Return to the River] -> river
-> END

== caveDeath ==
You blindly follow the wall of the cave deeper into the passage, you hear a sudden screech and feel a sharp pain go through your skull.
-> END

== riverDeath ==
The cold sets in,  you cant move anymore. You concuiussness drifts into nothing as you sink to the bottom of the cave. 
-> END

== riverExit ==
You finnally see a light after an hour of swimming, you climb out of the river onto dry land in the middle of the forest. You didn't make it out with much but you at least still have your life.
-> END

== exit ==
{rocks == "jewels": With all the money you have managed to obtain from the jewels, you buy yourself a nice modest house out on the countryside and live happily ever after. | { diamondStatue == "Diamond Statue": You run all the way out of the cave without looking back. Although you could carry it out of the cave, you struggle to get it any farther during your walk back to civilization. Over the course of the next week you continue trying to get it back so you can make money but you have exhausted yourself, you die starving in the woods before you could cash it in | {goldBar != "": The gold bar was a nice haul but it didn't get you as much as you though it would, it got you about a month of rent before you were back on the streets, homeless again. | {rope != "" && not tresherroom: When you get back you try and make of this excurshion what you can, you sell the rope for five buckaroonies. Thats 2 whole boxes of tic tacs. | } } } } {torchpickup && diamondStatue == "": You find out that your majestic torch was so majestic that a collector is willing to buy it for a BILLION TRILLION DOLLARS, but you know that some thing are with more than any amount of money so you keep it.| } 
{not torchpickup && rocks == "" && diamondStatue == "" && goldBar == "" && rope == "": You return to the bridge you have been living under for the past five years with the emptiest of hands, maybe its for the best, you would have just gambled it all away again anyway. | }
-> END
