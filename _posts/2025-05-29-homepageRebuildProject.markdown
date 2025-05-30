---
layout: post
title:  "Firefox iOS: Homepage Rebuild"
date:   2024-05-29 7:08:25
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile, firefox, homepage]
---

> Part of the Mobile Development series

# Overview
This blog post goes over the homepage rebuild project for the Firefox iOS app, which I led and dev completed by the release version 138. This post is mainly a self reflection of the project and hope to share for those who are interested.

## Homepage Feature
Before I dive in, this post assumes some knowledge of how the Firefox homepage works from the user perspective. If you are unfamiliar with the homepage feature, there is a brief wiki that gives an overview of the homepage feature. You can see more details there. 

## Background Context
**Proposal**
The homepage is one of the main features in the Firefox app and as with many apps, we want to contiously improve and enhance the experience for our users. Knowing that in the near future we want to experiment on the homepage, we took this opportunity to propose rebuilding the homepage instead of refactoring it. A proposal was written to compare the two options with a recommendation to rebuild the homepage, which was eventually approved.

While refactoring allows code changes to land in production sooner and give quicker results, in the long-term, the rebuilding option will save us from investing time in untangling code, pulling apart dependencies, and handling unknowns that arise when refactoring. By investing in a complete rebuild, we ensure the homepage will not only perform better but also be a make it easier for future development and feature expansion.

**Goal**: Rebuild the homepage by integrating Redux for state management and using diffable data source to allow the UI to respond better to changes in the underlying data.
Key Objectives

**Centralized State Management with Redux**
Implement Redux to centralize and standardize state management across the homepage. Each section in the homepage will have itself contained Redux components if needed. For example, the Pocket section will have its own state (PocketState), action (PocketAction) and middleware (PocketMiddleware). Redux will provide a single source of truth, making it easier to track, debug, and manage state transitions for each homepage section. This should significantly reduce the likelihood of state-related bugs, eliminate usage of delegates and provide a single directional flow of information.

**Enhanced UI Updates with Diffable Data Source**
Integrate diffable data source to manage dynamic content updates in the UI. This will allow the system to efficiently handle changes to the data model, such as insertions, deletions, and reordering of elements, without requiring full updates in reloading the whole collection view, which we are doing currently. This will lead to smoother and more performant UI transitions and less crashes in terms of inconsistencies between data and UI.

**Improved Stability, Reliability + Maintainability**
The combination of Redux and diffable data source is expected to enhance the stability and reliability of the homepage. By reducing the complexity of state and UI management, we aim to eliminate crashes and other issues that have previously affected the user experience. The improved architecture will also make the codebase more robust and easier to extend in the future. The goal is to facilitate easier onboarding to our homepage code, faster development cycles, and more straightforward debugging and feature enhancements.

**Expected Outcomes**
More maintainable and scalable homepage architecture for future development
- Reduced instances of crashes
- Improved application stability
- Enhance user experience through smoother + more responsive UI updates (one paint point was the flickering images on homepage that was due to reloading the collection view multiple times)

# Project Development 
## Set up 
- Estimation: To better estimation the project. Originally, the estimation provided with two full time engineers, but with prioritization it became one engineer
- Epic:
- Public channel: 
- Documentation:
- Architecture Diagram: 

## Implementing New Homepage
See screenshot of file directory and link (https://github.com/mozilla-mobile/firefox-ios/tree/main/firefox-ios/Client/Frontend/Home/Homepage%20Rebuild).

The foundation of the new homepage starting with the homepage view controller 

**Phase Breakdown**
Due to the large scope of the homepage, the rebuild project was broken up into two phases. The phases were also a way to help QA test and familiarize with the homepage rebuild project without waiting until full completion. This would help catch issues earlier if needed.

**Phase I** - Create a foundation for the homepage using diffable datasource and compositional layout and start the Redux foundation for the following subsections: Top Sites Section, Pocket Section, Customize Homepage. Also, includes wallpaper, context menu, scrolling logic.

**Phase II** - Continue to rebuild the other homepage subsections: Messaging, Bookmarks Section, Jump Back In. Also, includes adding telemetry + adhering to our new telemetry naming guidelines

I foresaw that top sites and jump back in section would take the most time so I made sure to split the two in diferent phases to balance out the timeline.

### Decision Table
Throughout the project, there were many decisions made and changes to the homepage as well as clarification as what we wanted. Later in the development, I decided to create the decision table in the document, but I wished I made this table earlier.

## Writing unit tests
Since the project was an opportunity to rewrite the homepage from the ground up. One of the issues that the old homepage faced was flaky unit tests. Therefore, I wanted to make sure that I was developing with a TDD mindset. This prompted the wiki documentation - [Unit tests guidelines](https://github.com/mozilla-mobile/firefox-ios/wiki/Unit-Tests-Guidelines/_history).

The homepage project was also the lead in developing unit tests for middlewares as well as states and managers. This prompted creating the StoreUtility class and thanks to the collaboration with ih-codes and cransen.  the Mock for Middlewares. https://github.com/mozilla-mobile/firefox-ios/wiki/Unit-Tests-Guidelines#mocking-the-store This is due to our app

Collaborating with other engineers on the team, we created a Story

As we are moving forward to using a Redux architecture through the app, we are still learning what works best for our project. With that, we are still refining unit tests. As of writing this, we realize that having the global middlewares set on, so [add link]. 

For the project, new tests were added for 
* view controller
* middlewares
* states

As soon as the feature

## Other 
- Telemetry requirements defined
- Accessibility review

## Final thoughts + wrap up
Overall, I feel very fortunate to be able to work on this rewrite on a large feature using modern APIs and gained more confidence in working with our Redux architecture. Previously, I haven't really worked with the homepage. Although the data layer itself hasn't changed. The new homepa ge

Having this, I was able to solidify my knowledge if diffable datasource, compositional layout and work on improving guidelines in Redux. 

Leading this project gives me more confidence to take on bigger project. While I was able to break a complex project in to separate tasks, I would like to have worked more closely with other engineers throughout the project. I was grateful that my teammate (cramsen) has also helped me with wallpapers and scrolling logic when I was out of office. During the time where we were both discussing the project, I really enjoyed to conversations and pairing we had. 

## Checklist 
While leading this project, I developed a checklist for myself that I hope to expand + continue for the future.
Initial Project Assignment
[ ] Confirm design finalize (+ went through design system review) + telemetry requirement defined
[ ] Create project documentation (notes / feature overview)
[ ] Create public communication channel
[ ] Create spike + develop initial architecture diagram
[ ] Create tickets in epic

Project Implementation
[ ] Create spreadsheet with timeline + delegate tasks
[ ] Add unit tests / UI tests
[ ] Accessibility review
[ ] Post weekly status on Epic ticket or public channel

Project Completion
[ ] Finalize all documentation
[ ] Create QA Request
[ ] Experiment created (if needed)

## Resources
To learn more about other Xcode tools, check out my other blog on debugging tools:
* [Homepage Rebuild PRs](https://github.com/Quick/Quick/blob/main/Documentation/en-us/README.md#documentation)
* [Apple Docs - Code Coverage](https://developer.apple.com/documentation/xcode/determining-how-much-code-your-tests-cover#Enable-code-coverage-in-your-test-plan).
* [Apple Docs - Updating tests](https://developer.apple.com/documentation/xcode/updating-your-existing-codebase-to-accommodate-unit-tests)
