# Script Template
___

## Community
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

Using the drop-down menu provided you can easily select from a few different pre-made run configurations like headless mode
or running inside a docker container (and of course whatever variation you choose.)

###### *Debugging*
You can use the debugging features present in both **IntelliJ** (the bug button beside the play button)
and utilize some ones present in both
[OsrsBot](https://github.com/OSRSB/OsrsBot) and [RuneLite](https://github.com/RuneLite)
to diagnose any unwanted behavior.
In the future the API will support being launched using an RSPS client for quick testing scripts.

###### *Why is it so easy?*
The reason this works so simply is due to Gradle run tasks being configured to enable accessing
[OsrsBot](https://github.com/OSRSB/OsrsBot) 's main method without IntelliJ throwing an error.
Since we have the project set-up to already have settings configured script-template[botRunGUI].
If not just select that one to launch. Other options are available, so feel free to toy around with them.



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
13. Your jar will be present in the project's build directory inside libs

Now you have a script you can use in the OsrsBot.jar OR you can continue to run and test within your build environment.
It is up to you.


###### Where to put your scripts

To use a script for OsrsBot, traverse to the following location and place the .jar:

**Windows:** C:\\Users\\[username]\\OsrsBot\\Scripts\\Precompiled \
**Linux:** /home/[username]/.config/OsrsBot/Scripts/Precompiled \
**MacOS:** /Users/[username]/Library/Application Support/OsrsBot/Scripts/Precompiled

Otherwise; if the script is in the form of class files drop them into the Scripts/Sources folder.

Now you're ready to script.

### Docker
The script-template additionally includes a Dockerfile to aid in building containers. The Dockerfile itself is fairly
simple and anyone experienced with Docker should find this all very easy to use. That said it isn't necessary for general
script builders to be utilizing containerization, but decent reasons include wanting to keep the bot files separate from
your actual PC. (Currently the builds target your PC, but execution will occur on the container).
That said there are Gradle tasks for easier Docker building, but some essential instructions are needed first.

###### Install Docker:
https://docs.docker.com/engine/install/

###### XServer
For Windows, I personally use:
https://mobaxterm.mobatek.net/

For Mac, XQuartz is a nice XServer tool.
[Click this link for extra details on setting that up](https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088)

Nix users should be capable of setting up an XServer without instruction.


#### Easy Instructions
So provided are run configurations which are accessible next to the green play button at the top 
in which you can select options dockerRunGUI or dockerRunHeadless which will both build and run the
docker build. This is by far the easiest method to launch, but should you choose to be difficult then 
below are some helpful commands.


#### Manual Instructions

###### Build Docker:
```
docker build -t bot-image .
```

###### Run Docker:
This will remove the container every time you run it (Fresh container)

```
docker run -e DISPLAY=host.docker.internal:0 -t --rm bot-image
```

Without removing the container

```
docker run -e DISPLAY=host.docker.internal:0 -t bot-image
```
Or without docker.host:internal

```
docker run -e DISPLAY="$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'):0.0" --rm -t bot-image
```

Open Terminal in IntelliJ:
Alt+F12 (Windows)

To connect to a running container with Bash open the terminal in Intellij (or wherever) and then run the following

```
docker container ls
```

Note the name for the container (unless you want to copy the id)
Then with that name run

```
docker container exec -it {container-name} bash
```

For Windows users if you make any mistakes with your Docker setup, check here for some guidance
https://github.com/docker/for-win/issues/6971

## [Script Reloading](https://github.com/OSRSB/script-template/wiki/Script-Reloading-and-API-Reloading)
The above link redirects to the wiki page with detailed info on how to appropriately perform script-reloading in the current state of the client

If you find a bug in any API of OSRSB report it in the respective API library.

Current libraries are:
1. [OsrsBot](https://github.com/OSRSB/OsrsBot)
2. [DaxWalkerRSB](https://github.com/OSRSB/DaxWalkerRSB)
