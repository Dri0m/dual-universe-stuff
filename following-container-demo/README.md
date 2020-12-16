# following-container-demo
This is a script for ECU that will make a hover-engine-only hover ship follow you around. It was designed to be used as a mining ship on talemai/madis (lower gravity, minimal hills) and needs improvements if you want it to work properly on hills and mountains.

## Video

[See video here how it works and how it doesn't :) ](https://unstable.life/pending-universe/following-container-demo.mp4)

### Why is the code so ugly?
This is the first thing I made in DU. Also the first thing i made in Lua. It took me like 40 hours to figure it all out and make it not crash to the ground all the time. I'm releasing it as-is, use it for inspiration, as a soution for your problems or whatever, or make a PR and improve it, the whole thing is like **100 lines of code** at the moment.

### Setup
1. Build a hovership like you see in the video (give it good breaks and stabilizers, maybe even wings :)
2. Copy `following-container-demo.json` into an ECU on your ship
3. Link core and gyro to the ECU
4. Enable ECU, enter a pilot chair to fly around (this was design for a pilotable hovering container, that's why it's done this way)
5. Leave pilot chair, the ship will start following when it's 100m away.
6. Console is printing out distance and real depth from the surface/from ship (useful for mining)
7. Some variabled are exported, tune if you want

