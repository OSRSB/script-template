# Set base image from Docker image repo
FROM amazoncorretto:17

# Adds the bot jar to the container
ADD OSRSBot.jar OSRSBot.jar
# Adds the scripts to the container
ADD ./build/scripts root/.config/OsrsBot/Scripts/Sources/

# Installs XDisplay packages so we can actually view the container (and run the bot)
RUN yum install libXext.x86_64 libXrender.x86_64 libXtst.x86_64 -y

# Exposes a port to connect via
EXPOSE 8080

# Runs the bot with the bot flag
CMD java -jar OSRSBot.jar -bot-runelite -developer-mode