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

## What is SwiftUI?
In iOS development, there are two popular frameworks used to build user interfaces for apps in the Apple ecosystem, which are SwiftUI and UIKit. SwiftUI is a UI framework that takes a more declarative approach in developing apps for Apple's ecosystem. While there have been many discussions surrounding architectures around UIKit, I'm curious to understanding and see what discussions there have been regarding SwiftUI architecture and whether we can apply the same solutions. 

SwiftUI is becoming more popular in the iOS development community and was introduced in iOS 13 as a way to simplify the development process in creating UI for apps. The decision to choose between SwiftUI and UIKit is largely depending on the development goals for the app and complexity. For the purpose of this post, we will focus on SwiftUI and consider various architectures that can be applied.

## Resources
To learn more about SwiftUI, here are some useful resources that dives deeper into the framework:
* [Apple Documentation on SwiftUI](https://developer.apple.com/documentation/swiftui)
* [100 Days of SwiftUI](https://www.google.com/search?client=safari&rls=en&q=hacking+with+swift&ie=UTF-8&oe=UTF-8)
* [Stanford's Course on Developing Apps for iOS](https://cs193p.sites.stanford.edu)

# Common Architecture Patterns
There are several architecture patterns that are floating around when it comes to iOS development. Reading [objc's app architecture book](https://www.objc.io/books/app-architecture/), I have learned some sample iOS application design patterns in Swift. Although the examples in the book were using UIKit as the framework for building user interfaces, this has led me to ponder about the different architectures that can be developed with the SwiftUI framework.
* MVC - Model-View-Controller
* MVVM-C - Model-View-ViewModel + Coordinator
* MVC-VS - Model-View-Controller+ViewState
* MAVB - ModelAdapter-ViewBinder
* ELM - The Elm Architecture

There isn't one solution or one way to architect an application and the decision is mainly a group discussion with the developers that are working on the application. This is the beauty of programming where we get to use our creative mindset to determine how to program so that we maintain a solid foundation for an application that is constantly iterating and changing.

## SwiftUI Architecture in Pocket's iOS App
My main experience with building an application in SwiftUI is through Pocket's iOS app. Therefore, I will briefly outline what the current architecture that the Pocket currently uses for their iOS app. Although there still needs to be discussion, let's analyze the current architecture as it is in this open source repository: https://github.com/Pocket/pocket-ios

Currently, the project has a mix of UIKit and SwiftUI, but we're moving towards replacing as many of our UIKit views with SwiftUI views. When creating these SwiftUI views, we are following the MVVM architecture approach. 

MVVM (Model-View-ViewModel) allows us to separate the state and logic handling from our views into classes called view models. Our view models typically conform to the `ObservableObject` protocol so that changes can be reported back to the view. The view that wants to make UI updates based on the viewmodel will create a property variable with the view model as its type. By making this separation, we can write tests for our code more easily. We create `@Published` properties in the view model class to announce when changes occur and SwiftUI will monitor those changes. 

```
class ViewModel: ObservableObject {
  @Published private(set) var model: Model
}

struct ContentView: View {
  @ObservedObject var viewModel: ViewModel
}
```

# Architectures aside MVVM
There are resources out there that argue the use of MVVM for SwiftUI. Some argue that MVVM is over engineering the code as mentioned in this [thread](https://developer.apple.com/forums/thread/699003). 
One popular architecture that I noticed was the The Composable Architecture (TCA) developerd by [pointfree](https://github.com/pointfreeco/swift-composable-architecture). I hope to investigate this architecture future and will expand upon this blog post with my learnings from there. 

## Considerations
As we move forward to adopting a mindset of using SwiftUI as our main framework for building our user interface elements, there are some considerations that we want to keep in mind. 
* Dependency Injection: improve our existing DI patterns; consider using SwiftUI's `Environment` class to handle this 
* Architecture: while we are using the MVVM approach, we may not need a view model in cases where it may see overkill
* Navigation: Previously, we utilized MVVM-C with our UIKit framework and our coordinators handled the presentation layer. However, we decided to remove this, but we may consider using NavigationPath as a way to organization our complex presentation 

# Summary
Overall, this is my initial research and consideration of using SwiftUI in applications. I will continue to iterate and expand this post as I learn about various architectures that can be considered. Any feedback is appreciated! 