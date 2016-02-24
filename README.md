Assignment 4: Animation
=========================

## Using git
1. Download Git at https://git-scm.com
	a. For OSX, you may need to download the developer tools. Just type "git" into terminal.
	b. For Windows, you will need to use the included Git terminal, instead of Windows command prompt
2. Open terminal. Navigate to location you want to place local repository (i.e. personal version of program).
3. Type "git clone https://github.com/omodamos/Assignment4"
4. Write your code, make edits, add/remove files, etc...
5. To upload changes to the remote repository (i.e. shared version of program)
	a. Type "git add <files you want to change>" (to upload all your changes, types "git add .")
	b. Type "git commit -m <message>", with <message> being a brief description of your changes
	c. Type "git push" to send your commit to the remote
6. To download the latest remote repository
	a. Save your local changes with "git stash"
	b. Type "git pull"

## Installation
1. Open group_5_assignment4.pde in Processing. 
2. Select menu option Sketch->Import Library->Add Library. 
3. Search for PeasyCam and install.
4. Search for Minim and install.
5. Press run to execute program.

## Story
For our story we want to make an animation that represents the solar system. Our design will feature a star, planets, moons, comets, and a spaceship. Users will be able to watch the planets orbit around the sun as comets shoot past and a spaceship flies through the scene.

Our plan for the animation is to utilize 3D spheres of varying sizes for each of the planets, a sphere for the star at the center, cubes for the asteroids, and a downloaded 3D model for a spaceship. The sequence is planned to last for one orbit of the slowest planet, or about 30 seconds.

## Objects
* 1 Star - sitting at the center of the solar system, unmoving
* 8 Planets - orbiting the central star, each at different speeds and distances from the star
* 3 Moons - orbiting unique planets.
* 1-2 Comets - shooting across the galaxy
* 1 Spaceship - flies into the image, zooms around for a bit, and then flies away.

## Technical Considerations
* Planet Class - Class to describe orbits of each planet/moon which will be different circles around the sun at the center.
* Comet Class - Class to describe the movement of asteroids, cubes that fly across the image at varying directions. 
* Moon Class - Class to describe movement of moons orbiting planets in the solar system.
* Spaceship Class - Class to describe movement of a spaceship as it arrives in the picture, flies around, and then leaves.

## Group Requirements
Team Members
* Della Owens
    * Moon Class
    * Spheres for the moons
* Philip Bishop
    * Planet Class
    * Spheres for the sun/planets
* Joseph Moon
    * Comet Class
    * Spaceship Class
    * Cubes for comets
    * Spaceship model

## Integration Plan
Our group is going to work on our parts separately while adding to a central processing file on GitHub. On Tuesday we plan to meet again to go over each facet of our project and how we plan to complete our section. At the end of the week we should have a working program and at that point we can decide whether or not we plan to implement any extra credit features beyond 3D shapes. 

We also have a stretch goal of making our solar system procedurally generated. This would be incorporated by a python script that would randomize several facets of the solar system.
