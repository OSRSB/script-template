package basicloopbot;

import dax_api.api_lib.DaxWalker;
import dax_api.api_lib.models.DaxCredentials;
import dax_api.api_lib.models.DaxCredentialsProvider;
import net.runelite.rsb.methods.Methods;
import net.runelite.rsb.methods.NPCs;
import net.runelite.rsb.script.Script;
import net.runelite.rsb.script.ScriptManifest;
import net.runelite.rsb.wrappers.RSNPC;
import net.runelite.rsb.wrappers.RSPath;
import net.runelite.rsb.wrappers.subwrap.WalkerTile;

import java.util.logging.Logger;

@ScriptManifest(
        authors = { "Baby Future" }, name = "Basic Loop Bot", version = 0.1,
        description = "<html><head>"
        + "</head><body>"
        + "<center>Basic example that kills chickens</center>"
        + "</body></html>"
)
public class Main extends Script {

    private final int MIN = random(250, 400); // Random minimum value for our loop
    private final int MAX = random(700, 900); // Random maximum value for our loop
    private final WalkerTile chickenCoop = new WalkerTile(3233, 3295, 0);

    @Override
    public int loop() {
        // A Lazy way to catch exceptions - some NPE's can get thrown from the API
        // Let's try to find them if it happens

        try {
            // We should execute one action at a time,
            // when an action is complete we loop again

            // Here's the start of our loop
            RSNPC chicken = NPCs.methods.npcs.getNearest("Chicken"); // Find the nearest chicken
            // If there's not an NPC available, let's walkt to the area
            if (chicken != null) {
                Logger.getLogger(getClass().getName()).info("Chicken not null");
                if (getMyPlayer() == null) // Let's make sure our local player isn't Null
                    return 100;

                if (!chicken.isOnScreen() || (chicken.getLocation() != null && getMyPlayer().getLocation().distanceTo(chicken.getLocation()) > 10)) {
                    // We're a bit far, let's walk a little closer
                    RSPath pathToChicken = ctx.walking.getPath(chicken.getLocation()); // We could use DaxWalker here
                    Logger.getLogger(getClass().getName()).info("Pathing to chicken");
                    if (pathToChicken.traverse()) {
                        return random(1200, 2100);
                    }
                } else if (!chicken.isInCombat() && !chicken.isInteractingWithLocalPlayer() && !getMyPlayer().isInCombat()) {
                    // We passed our checks, let's attack a chicken now
                    if (chicken.doAction("Attack")) {
                        Logger.getLogger(getClass().getName()).info("Attack");
                        // We successfully clicked attack
                        // TODO ideally the API should support a waitUntil type method
                        // i.e. you click attack and wait until your player is moving /
                        // isAttacking() returns true

                        Methods.sleep(700, 1200);
                        if (!getMyPlayer().isIdle() || getMyPlayer().isInCombat()) {
                            // Seems like our attack worked, we can exit
                            return 0;
                        }

                        // An alternative to the sleep and if statement
                        /*do {
                            Methods.sleep(700, 1200);
                        } while (getMyPlayer().isLocalPlayerMoving());*/
                    }
                }
            } else {
                // Chicken is null, we should find one
                Logger.getLogger(getClass().getName()).info("Walking");
                DaxWalker.walkTo(chickenCoop);
            }
        }  catch (NullPointerException e) {
            e.printStackTrace();
        }

        // Randomize how often we loop
        // Ideally we can use PlayerProfile's that make this random per user/bot
        return random(MIN, MAX);
    }

    @Override
    public boolean onStart() {
        // Pass DaxWalker credentials
        DaxWalker.setCredentials(new DaxCredentialsProvider() {
            @Override
            public DaxCredentials getDaxCredentials() {
                return new DaxCredentials("sub_DPjXXzL5DeSiPf", "PUBLIC-KEY");
            }
        });
        return true;
    }
}
