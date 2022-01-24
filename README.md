# Script Template
___

## Community Discord
[Click here](https://discord.gg/CGBXNrHREP) to join our community Discord for more support and help

## Building your first script

###### Setting up the environment
It is a personal recommendation that you attempt to clone this repository using **IntelliJ**

This is so the intended template present is loaded as it was created.

Doing so will allow the run configurations to be prepared for you to simply run the script effortlessly.

###### Making Changes
The project uses Gradle to handle dependencies, so if you're interested in adding a new library to your script then
simply add it in whatever manner that library recommends.

By default the project will come with [RuneLite](https://github.com/RuneLite), [RSB](https://github.com/OSRSB/RSB),
and [DaxWalkerRSB](https://github.com/OSRSB/DaxWalkerRSB) already listed as imports for use.

While one does not currently exist, in the future an individual scriptwriter will be able to refer to the API reference 
for more details on each methods' functionality as well as aiding in their goal of writing a script.

The script in the example is a basic cannonball making script to outline general script making practices and capabilities. 
An advanced script maker can go far beyond this adding their own dependencies, functionalities, 
utilizing the WebWalker (DaxWalkerRSB), and even go as far as edit the underlying API if they see the need to. 
After all, it is open source.

###### Testing your script
To run your script it is as easy as hitting the green play button in **Intellij**
You can use the debugging features present in both **IntelliJ** (the bug button beside the play button)
as well as utilize some of the ones present in both 
[RSB](https://github.com/OSRSB/RSB) and [RuneLite](https://github.com/RuneLite) 
to diagnose any unwanted behavior. 

**IntelliJ** will warn you that configurations are incorrect.

****IGNORE IT****.
Simply hit continue anyway, and you are now running your script!


###### Deploying your script
Using **IntelliJ** you should find that compiling your script is rather simple.
In **IntelliJ** build outputs are referred to as **Artifacts**.

**IMPORTANT**

When you go to create an artifact ensure that ONLY the compiled source is selected as output
UNLESS you imported an external dependency that wouldn't be used in RSB, DaxWalkerRSB, or
RuneLite

Instructions:

To set up an artifact that outputs as a jar (the format one would use in the RSB.jar) simply hit:
1. File
2. Project Structure
3. Artifacts
4. The plus sign in the center column
5. Jar
6. Empty
7. From Available Elements Open the drop-down for Script_Template
8. From that drop-down open the one for Main
9. Double-click 'Script_Template.main' compiled output
10. Click Ok
11. Click Apply (in the Project Structure interface)
12. Click Ok (in the same interface as above)
13. Profit!

Now you have a script you can use in the RSB.jar OR you can continue to run and test within your build environment. 
It is up to you.


To use a script for RSB, traverse to
```{HOME_DIRECTORY}/GService/Scripts/Precompiled```

and place the compiled jar here.
Similarly, if you wish to use someone else's you would do the same.

Now you're ready to script.

If you find a bug in any API of OSRSB report it in the respective API library.

Current libraries are:
1. [RSB](https://github.com/OSRSB/RSB)
2. [DaxWalkerRSB](https://github.com/OSRSB/DaxWalkerRSB)