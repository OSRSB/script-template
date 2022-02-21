# Script Template
___

## Community 
* [Forums](https://osrsbot.org/) - Ask questions, find guides, make requests
* [Discord](https://discord.gg/CGBXNrHREP)

## Building your first script

###### Setting up the environment
It is a personal recommendation that you attempt to clone this repository using **IntelliJ**

This is so the intended template present is loaded as it was created.

Doing so will allow the run configurations to be prepared for you to simply run the script effortlessly.

###### Making Changes
The project uses Gradle to handle dependencies, so if you're interested in adding a new library to your script then
simply add it in whatever manner that library recommends.

#### API Reference
To explore the methods you can use in your script check out the API References here:

[OsrsBot API Reference](https://osrsb.github.io/OsrsBot/)

One for the DaxWalkerRSB API will be added later.

By default, the project will come with [RuneLite](https://github.com/RuneLite), [OsrsBot](https://github.com/OSRSB/OsrsBot),
and [DaxWalkerRSB](https://github.com/OSRSB/DaxWalkerRSB) already listed as imports for use.

The script in the example is a basic cannonball making script to outline general script making practices and capabilities. 
An advanced script maker can go far beyond this adding their own dependencies, functionalities, 
utilizing the WebWalker (DaxWalkerRSB), and even go as far as edit the underlying API if they see the need to. 
After all, it is open source.

###### Testing your script
###### *To Run*
To run your script it is as easy as hitting the green play button in **Intellij**

###### *Debugging*
You can use the debugging features present in both **IntelliJ** (the bug button beside the play button)
and utilize some ones present in both 
[OsrsBot](https://github.com/OSRSB/OsrsBot) and [RuneLite](https://github.com/RuneLite) 
to diagnose any unwanted behavior. 
In the future the API will support being launched using an RSPS client for quick testing scripts.

###### *Why is it so easy?*
The reason this works so simply is due to Gradle run tasks being configured to enable accessing 
[OsrsBot](https://github.com/OSRSB/OsrsBot) 's main method without IntelliJ throwing an error.
Since we have the project set-up to already have settings configured script-template[launchClientWithScript].
If not just select that one to launch.



###### Deploying your script
Using **IntelliJ** you should find that compiling your script is rather simple.
In **IntelliJ** build outputs are referred to as **Artifacts**.

**IMPORTANT**

When you go to create an artifact ensure that ONLY the compiled source is selected as output
UNLESS you imported an external dependency that wouldn't be used in OsrsBot, DaxWalkerRSB, or
RuneLite

Instructions:

To set up an artifact that outputs as a jar (the format one would use in the OsrsBot.jar) simply hit:
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

Now you have a script you can use in the OsrsBot.jar OR you can continue to run and test within your build environment. 
It is up to you.


To use a script for OsrsBot, traverse to
```{HOME_DIRECTORY}/GService/Scripts/Precompiled```

and place the compiled jar here.
Similarly, if you wish to use someone else's you would do the same.

Now you're ready to script.

If you find a bug in any API of OSRSB report it in the respective API library.

Current libraries are:
1. [OsrsBot](https://github.com/OSRSB/OsrsBot)
2. [DaxWalkerRSB](https://github.com/OSRSB/DaxWalkerRSB)
