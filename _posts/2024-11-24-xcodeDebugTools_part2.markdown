---
layout: post
title:  "Xcode Debugging Tools - Part 2"
date:   2024-11-24 9:56:33
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile, debugging]
---

> Part of the Mobile Development series

> This blog post was inspired by a demo that Filippo Zazzeroni (add link?) gave during a team meeting. Thank you Filippo for sharing your knowledge with the team on your debugging tips.

# Overview
This blog post assumes you have some familiarity with Xcode. If you do not have any experience, we recommend starting with watching this WWDC: 
https://developer.apple.com/videos/play/wwdc2019/404/  

When debugging in Xcode, there are some useful commands that I didn't know until 

## Low-Level Debugger (LLDB) 
In Xcode, the Low-Level Debugger (LLDB) is a debugging tool used that provides developers with control in analyzing their code behavior, providing ease for spotting issues, and understanding code execution. Using LLDB, developers can set breakpoints, inspect variables, evaluate expressions, and step through code. This tool allows developers to work from the debugger console itself or use the breakpoint UI through breakpoints. By understanding basic LLDB commands, you can diagnose issues efficiently and gain a deeper understanding of your app’s behavior.

Overall, LLDB is useful for more efficient debugging and provides useful tools for exploring object details and experimenting with code in real time.

## LLDB Commands
There are various LLDB commands, here are some expression commands ones that we find useful:
* `po` (print object): This command is useful for objects that conform to the `CustomStringConvertible` protocol. It prints a human-readable description of the object, which allows us to inspect high level object details.
* `p` is useful when wanted to find more info that may not be provided by **po**
* `expr`: useful for code injection or manipulating variables at runtime

Here is an example of code injection where we want to replace the background color of the button with red. This helps
when we want to change the code 

![Expr Command](/images/ios/xcodeDebugging_part2/04-exprCommand.png)

* `typelookup`: useful for looking up the type information and printing to consolt the structure of the type

![Type Lookup](/images/ios/xcodeDebugging_part2/05-typeLookup.png)

## Breakpoints
In the breakpoints, we can add conditions and actions to breakpoints. Below are some useful 
![Breakpoint Panel](/images/ios/xcodeDebugging_part2/01-breakpointPanel.png)

### Debugger Command
![Debugger Command](/images/ios/xcodeDebugging_part2/02-debuggerCommand.png)
The debugger command is useful if you want to use the same expressions from the LLDB commands mentioned above. We can 
add the expressions to the **Debugger Command** section in the breakpoint panel. 

Here is an example of printing to the console. `po monitorIt`
![Debugger Command](/images/ios/xcodeDebugging_part2/02-debuggerCommand.png)
        
### Conditions
Conditions are helpful if you want a breakpoint to stop execution for a specific case such as only want the breakpoint 
to activate on a certain cell type when running code through the collection and table views.

![Condition](/images/ios/xcodeDebugging_part2/03-condition.png)

## More resources
* [Debug Swift debugging with LLDB - WWDC22 - Videos](https://developer.apple.com/videos/play/wwdc2022/110370/#:~:text=LLDB%20is%20the%20underlying%20debugging,your%20code%2C%20and%20much%20more.)

To learn more about other Xcode tools, check out my other blog on debugging tools:
* [Xcode Debugging Tools](https://cyndichin.github.io/blog/xcodedebugtools)
