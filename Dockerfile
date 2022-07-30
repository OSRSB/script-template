# syntax = docker/dockerfile:1.2
# Enable BuildKit https://docs.docker.com/develop/develop-images/build_enhancements/
# Using multistage docker build
# ref: https://docs.docker.com/develop/develop-images/multistage-build/
# Variable to use across build stages
ARG BUILD_HOME=/usr/app

# temp container to cache gradle
FROM gradle:7.4.2-jdk17-jammy AS cache
# Environment vars
ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME/bot
WORKDIR $APP_HOME
# Copy gradle settings and config to /app in the image
COPY build.gradle settings.gradle $APP_HOME

# Build gradle - caches dependencies
RUN gradle --no-daemon build || return 0

# Build container
FROM cache AS builder
ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME/bot

WORKDIR $APP_HOME

COPY --from=cache /root/.gradle /root/.gradle
COPY --from=cache $APP_HOME/build.gradle $APP_HOME/settings.gradle $APP_HOME
COPY src/ src/

RUN gradle --no-daemon -b build.gradle clean build

# We need to build the jar for interactive botting
# Note we could run this headless and skip this stage
FROM gradle:7.4.2-jdk17-jammy AS bot

ARG BUILD_HOME
# Set where to pull OSRSBot from - default OSRSB
ENV ORG=OSRSB
# Set where git should store the OSRSBPlugin project
ENV BOT_REPO=OsrsBot/
ENV APP_HOME=$BUILD_HOME/

WORKDIR $APP_HOME

# We need to clone the project and cache the git pull - everytime there's something new pushed
# to master it will pull the latest changes
RUN --mount=type=cache,target=/tmp/git_cache/ \
    git clone --single-branch --branch master https://github.com/$ORG/OsrsBot.git /tmp/git_cache/$BOT_REPO; \
    cd /tmp/git_cache/$BOT_REPO \
    && git pull origin master \
    && cp -r ./ $APP_HOME

RUN gradle --no-daemon clean jar

# actual container
# Set base image from Docker image repo
# https://adoptium.net/temurin
FROM eclipse-temurin:17-jdk-jammy

ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME/bot
# Name of the built OSRSBot jar file
ENV BOT_JAR_FILE OSRSBot.jar

# Installs XDisplay packages so we can actually view the container (and run the bot)
# Caches our apt-get(s) with BuildKit
# Remove the apt list to save space
RUN --mount=type=cache,target=/var/cache/apt apt-get update \
    && apt-get upgrade -y \
    && apt-get install -yqq --no-install-recommends libxext6 libxrender1 libxtst6 libxi6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Adds the scripts to the container (copies source files, if you want the built jar comment this out and uncomment the line below)
#COPY --from=builder $APP_HOME/build/scripts root/.config/OsrsBot/Scripts/Sources
COPY --from=builder $APP_HOME/build/libs /root/.config/OsrsBot/Scripts/Precompiled
# Adds the bot jar to the container
COPY --from=bot $BUILD_HOME/$BOT_JAR_FILE $APP_HOME/$BOT_JAR_FILE
# Adds runelite config settings to the container
# COPY /config/.runelite/settings.properties /root/.runelite/settings.properties
# Adds osrsbot account config to the container
# COPY /config/.config/osrsbot_acct.ini /root/.config/osrsbot_acct.ini

EXPOSE 8080

# Launch the bot with the GUI
# For the jar location, this must be manually written out as ENTRYPOINT does not allow ARGs to be accessible at runtime
# For further reference check out the following links:
# https://stackoverflow.com/questions/40902445/using-variable-interpolation-in-string-in-docker
# https://docs.docker.com/engine/reference/builder/#environment-replacement
ENTRYPOINT ["java", "-jar", "-debug", "/usr/app/bot/OSRSBot.jar", "--bot-runelite", "--developer-mode"]