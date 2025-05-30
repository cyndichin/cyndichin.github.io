---
layout: post
title:  "Firefox iOS: Homepage Rebuild Project"
date:   2024-05-29 7:08:25
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile, firefox, homepage]
---

> Part of the Mobile Development series

# Overview
This blog post goes over the homepage rebuild project for the Firefox iOS app, which I led and was dev complete by release version 138. This post is mainly a self reflection of the project and I hope to share my thoughts for those who are interested.

## Homepage Feature
Before I dive in, this post assumes some knowledge of how the Firefox homepage works from the user perspective. If you are unfamiliar with the homepage feature, there is a [brief wiki](https://github.com/mozilla-mobile/firefox-ios/wiki/Application-overview#firefox-homepage) that gives an overview of the homepage feature. You can read more details there and feel free to [reach out](https://cyndichin.github.io/contact/) to me if you have further questions! 

## Background Context
**Proposal**
The homepage is one of the main features in the Firefox app and we want to contiously improve and enhance the experience for our users. There was a time when our homepage code caused app crashes every other week. To put out the fire, the team implemented temporary patches and band-aid fixes to help stabilize the application. However, these fixes were never intended to be long term solutions, as they make the code brittle and difficult to update. 

Knowing that in the near future we want to experiment on the homepage, we took this opportunity to propose rebuilding the homepage instead of refactoring it. Therefore, a proposal was written to compare the two options with a recommendation to rebuild the homepage, which was eventually approved. While refactoring allows code changes to land in production sooner and give quicker results, in the long-term, the rebuilding option will save us from investing time in untangling code, pulling apart dependencies, and handling unknowns that arise when refactoring. By investing in a complete rebuild, we ensure the homepage will not only perform better but also be a make it easier for future development and feature expansion. 

With the approval, we began the start of the hompage rebuild project.

### Goal
The main goal of the project was to rebuild the homepage by integrating Redux for state management and using diffable data source to allow the UI to respond better to changes in the underlying data. Previously, the homepage was reloading an unnecessary large amount of times which also caused poor user experience such as flickering icons and diffable data source solves this by making updates on differences. 

There were 3 main key objectives that were listed out for this project:

**A. Centralized State Management with Redux**
Implement Redux architecture to centralize and standardize state management across the homepage. Each section in the homepage will have itself contained Redux components if needed. Redux will provide a single source of truth, making it easier to track, debug, and manage state transitions for each homepage section. This should significantly reduce the likelihood of state-related bugs, eliminate some usage of delegates and provide a single directional flow of information.

An example of a section using Redux architecture:
The Top Sites section will have its own state [(TopSitesSectionState)](https://github.com/mozilla-mobile/firefox-ios/blob/main/firefox-ios/Client/Frontend/Home/Homepage%20Rebuild/TopSites/TopSitesSectionState.swift), action [(TopSitesAction)](https://github.com/mozilla-mobile/firefox-ios/blob/main/firefox-ios/Client/Frontend/Home/Homepage%20Rebuild/TopSites/TopSitesAction.swift) and middleware [(TopSitesMiddleware)](https://github.com/mozilla-mobile/firefox-ios/blob/main/firefox-ios/Client/Frontend/Home/Homepage%20Rebuild/TopSites/TopSitesMiddleware.swift).

**B. Enhanced UI Updates with Diffable Data Source**
Integrate diffable data source to manage dynamic content updates in the UI. This will allow the system to efficiently handle changes to the data model, such as insertions, deletions, and reordering of elements, without requiring full updates in reloading the whole collection view, which we are doing currently. This will lead to smoother and more performant UI transitions and less crashes in terms of inconsistencies between data and UI.

This implementation can be found in [HomepageDiffableDataSource](https://github.com/mozilla-mobile/firefox-ios/blob/main/firefox-ios/Client/Frontend/Home/Homepage%20Rebuild/HomepageDiffableDataSource.swift).

**C. Improved Stability, Reliability + Maintainability**
The combination of Redux and diffable data source is expected to enhance the stability and reliability of the homepage. By reducing the complexity of state and UI management, we aim to eliminate crashes and other issues that have previously affected the user experience. The improved architecture will also make the codebase more robust and easier to extend in the future. The goal is to facilitate easier onboarding to our homepage code, faster development cycles, and more straightforward debugging and feature enhancements.

From testing, there have been minimal bugs, but as of writing this blog, we are still running the experiment and confirming with metrics is still to be determined. 

### Expected Outcomes
More maintainable and scalable homepage architecture for future development
- Reduced instances of crashes
- Improved application stability
- Enhance user experience through smoother + more responsive UI updates

# Project Development 
This project was in development from October 2024 until April 2024, but was not worked 100% capacity (i.e. vacation time and work weeks). 

## Set up 
- Estimation: To better estimation the project, I created a spreadsheet that outline the different  Originally, the estimation provided with two full time engineers, but due to re-prioritization it became mainly one engineer at a time.
- Epic: Created separate tasks that needed to be complete for the project (Phase I, Phase II, nice to haves).
- Public channel: Created a public communication channel so that the team and stakeholders can view any questions or status updates.
- Documentation: Internal doc that was created (I reused some of that information here).
- Architecture Diagram: Created initial diagram to confirm with the team on the architecture before implementing. Updated and used this diagram to perform handoff to homepage engineers that will be working on the new experimentation.

![Architecture Diagram](/images/ios/homepageRebuildProject/01-diagram.png)

## Implementing New Homepage
The homepage rebuild project has been implemented and dev complete (aside from some nice to haves). Most of the new code can be found in the [Homepage Rebuild folder](https://github.com/mozilla-mobile/firefox-ios/tree/main/firefox-ios/Client/Frontend/Home/Homepage%20Rebuild).

![Homepage Rebuild Directory](/images/ios/homepageRebuildProject/02-directory.png)

**Phase Breakdown**
Due to the large scope of the homepage, the rebuild project was broken up into two phases. The phases were also a way to help QA test and familiarize with the homepage rebuild project without waiting until full completion. This would help catch issues earlier if needed.

**Phase I** - Create a foundation for the homepage using diffable datasource and compositional layout and start the Redux foundation for the following subsections: Top Sites Section, Pocket Section, Customize Homepage. Also, includes wallpaper, context menu, scrolling logic.

**Phase II** - Continue to rebuild the other homepage subsections: Messaging, Bookmarks Section, Jump Back In. Also, includes adding telemetry + adhering to our new telemetry naming guidelines.

I foresaw that top sites and jump back in section would take the most time so I made sure to split the two in diferent phases to balance out the timeline. To help in keeping tracking with my progress, I would create a simply spreadsheet shown below, which really helps me when working on a self-led project.

![Progress Tracker](/images/ios/homepageRebuildProject/03-tracker.png)

### New telemetry guidelines
The biggest blocker of this project was having undefined telemetry guidelines. When we received the guideline to keep the telemetry consistent with previous implementation, it was discovered that there some flaws in the existing implemention. After discussion and review, we decided to implement new telemetry that adhere to our new telemetry naming guidelines (another initiative on the team), while keeping a few the same. Going forward, having telemetry requirements upfront and defined earlier would've helped moved the project more quickly.

### Writing unit tests
Since the project was an opportunity to rewrite the homepage from the ground up. One of the issues that the old homepage faced was flaky unit tests. Therefore, I wanted to make sure that I was developing with a TDD mindset. This prompted the wiki documentation - [Unit tests guidelines](https://github.com/mozilla-mobile/firefox-ios/wiki/Unit-Tests-Guidelines/_history).

The homepage project also led to developing unit tests for middlewares. This prompted creating the StoreUtility class and thanks to the collaboration with my team members, we also developed a better mock for testing middlewares. Our guidelines in testing with store is documented in this [wiki](https://github.com/mozilla-mobile/firefox-ios/wiki/Unit-Tests-Guidelines#mocking-the-store). The issues with testing our Redux architecture is that our store and its middlewares are global and cause tests to be less isolated or testable. As we are moving forward to using a Redux architecture through the app, we are still learning what works best for our project. With that, we are still refining unit tests, such as needing to modify having the global middlewares set for the store. See more details in this [PR]. 

### Decision Table
Throughout the project, there were many decisions made and changes to the homepage as well as clarification as what we wanted. Later in the development, I decided to create the decision table in the ongoing project document, but it would have been helpful to make this table earlier.

## Testing the New Homepage
As of May 30, the new homepage is still under experimentation and hidden behind a feature flag. It can be tested in our nightly builds, or you if you pull down the Firefox iOS repo  (https://github.com/mozilla-mobile/firefox-ios), the feature flag has been enabled in dev mode by default. See details on configuration in [homepageRebuildFeature.yaml](https://github.com/mozilla-mobile/firefox-ios/blob/8523c4d4697662405dd6e1eba2a05dab0bca89fa/firefox-ios/nimbus-features/homepageRebuildFeature.yaml#L3).

## Final thoughts + wrap up
Overall, I feel very fortunate to be able to work on this rewrite on a large feature using modern APIs and gained more confidence in working with our Redux architecture. Previously, I haven't really worked with the homepage. With the homepage rebuild, I avoided going too much out of scope, so some areas are not adopting Redux fully and still follow MVVM (wallpapers) and the cell UI + data layer was reused. Having this experience, I was able to solidify my knowledge in diffable datasource, compositional layout and improving our guidelines in Redux. 

Leading this project gives me more confidence to take on bigger project. While I was able to break a complex project in to separate tasks, I would like to have worked more closely with other engineers throughout the project. I was grateful that my teammate has also helped me with wallpapers and scrolling logic when I was out of office. During the time where we were both discussing the project, I really enjoyed to conversations and pairing we had. 

### Checklist 
While working on this project from end to end, I developed a checklist for myself that I hope to expand + continue for the future. Happy to hear any feedback on this list.

**Initial Project Assignment**
[ ] Confirm design finalize (+ went through design system review)
[ ] Confirm telemetry requirement defined
[ ] Create project documentation (notes / feature overview)
[ ] Create public communication channel
[ ] Create spike + develop initial architecture diagram
[ ] Create tickets in epic

**Project Implementation**
[ ] Create spreadsheet with timeline + delegate tasks
[ ] Add unit tests / UI tests
[ ] Accessibility review
[ ] Post weekly status on Epic ticket or public channel
[ ] Confirm feature works in all themes / devices (iPad, iPhone, split view, multitasking)

**Project Completion**
[ ] Finalize all documentation
[ ] Create QA Request
[ ] Experiment created (if needed)