# emergency-container-monitor-demo

A usable example/demo on how to monitor containers for items and warn user if they are missing something.
This is a demo, the code quality is not as good as I would like it to be, but you should be able to understand what's going on if you're looking for an example. Or just use it as-is!

![](emergency-container-monitor-demo.png)

### Setup
1. Copy `emergency-container-monitor-demo.json` contents into the clipboard and paste into the programming board
2. Link screen to the programming board
3. Link containers to the programming board
4. Edit container names and the demands list at the top of `unit.start`. 


### I don't know what to put into the list of demands!
1. Put the desired item in of the connected containers
2. Activate the programming board
3. Open the chat window, switch to Lua tab, you should see container contents in the chat in JSON format
4. Find your container, find the item `class` name (not `name`!) and use that
![](console-out.png)
