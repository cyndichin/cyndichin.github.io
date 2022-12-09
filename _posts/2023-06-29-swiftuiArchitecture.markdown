---
layout: post
title:  "SwiftUI and Architecture Considerations"
date:   2023-06-29 4:43:03
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile development, architecture]
---

> Part of the Mobile Development series

# SwiftUI Overview [ Work in Progress ]
This blog post will go over my current understanding of SwiftUI and existing architectures that can be used to apply. 

**What is SwiftUI?**
In iOS development, there are two popular frameworks used to build user interfaces for apps in the Apple ecosystem, which are SwiftUI and UIKit. SwiftUI is a UI framework that takes a more declarative approach in developing apps for Apple's ecosystem. While there have been many discussions surrounding architectures around UIKit, I'm curious to understanding and see what discussions there have been regarding SwiftUI architecture and whether we can apply the same solutions. 

SwiftUI is becoming more popular in the iOS development community and was introduced in iOS 13 as a way to simplify the development process in creating UI for apps. The decision to choose between SwiftUI and UIKit is largely depending on the development goals for the app and complexity. For the purpose of this post, we will focus on SwiftUI and consider various architectures that can be applied.

To learn more about SwiftUI, here are some useful resources that dives deeper into the framework:
* [Apple Documentation on SwiftUI](https://developer.apple.com/documentation/swiftui)
* [100 Days of SwiftUI](https://www.google.com/search?client=safari&rls=en&q=hacking+with+swift&ie=UTF-8&oe=UTF-8)
* [Stanford's Course on Developing Apps for iOS](https://cs193p.sites.stanford.edu)

# Common Architecture Patterns
There are several architecture patterns that are floating around when it comes to iOS development. Reading [objc's app architecture book](https://www.objc.io/books/app-architecture/), here are some sample iOS application design patterns in Swift. 
* MVC - Model-View-Controller
* MVVM-C - Model-View-ViewModel + Coordinator
* MVC-VS - Model-View-Controller+ViewState
* MAVB - ModelAdapter-ViewBinder
* ELM - The Elm Architecture

The questions that comes to mind when choosing an architecture is: 

## SwiftUI Architecture in Pocket's iOS App
We will outline what the current architecture that the Pocket currently uses for their iOS app. Although there still needs to be discussion, lets analyze the current architecture as it is in this open source repository: https://github.com/Pocket/pocket-ios

Currently, the project has a mix of UIKit and SwiftUI, but we're moving towards replacing as many of our UIKit views with SwiftUI views. When creating these SwiftUI views, we are following the MVVM architecture approach. 

# Arguments against MVVM
There are resources out there that argue the use of MVVM for SwiftUI. 

# Summary
Overall, this is our initial series 

# Resources

1> 3> 6>7>4>8>2>5>9