---
layout: post
title:  "SwiftUI and Architecture Considerations"
date:   2023-10-19 9:16:33
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile, testing]
---

> Part of the Mobile Development series

# Quick + Nimble Overview
This blog post will document my journey in researching on Quick + Nimble frameworks. 

## What is Quick + Nimble?
Quick is a behavior driven development (BDD) testing framework and Nimble is a matching framework that helps make tests easier to read. Coupled together, they provide the advantage of being able to be very descriptive when writing unit tests in comparison to using XCTests. 

### Quick + Nimble vs. XCTests
Both frameworks have their advantages and disadvantages, so I created a chart to list down the positive and negatives from my perspective experimenting, discussing with coworkers and surfing the interwebs.

**Quick + Nimble** 

| Pros     | Cons |
| -------- | -------------- |
| Supports BBD and acceptance testing better since tests are descriptive | Third Party Dependency |
| Can easily read what is being tested | Does not have performance testing |
| Structure is consistent with testing done across other languages and platforms | Learning curve for developers used to XCTests |
| Easier to create subsets of tests in a suite | |
| Active community and open source project | |

**XCTests**

| Pros     | Cons |
| -------- | -------------- |
| Default native testing framework that is well integrated with Xcode | Hard to read and understand what is being tested |
| Less of a learning curve | Assertion methods are not as thorough as the Nimble matching framework |
| Can test performance | Less flexible in comparison |
| Support for UI testing | |

When it comes to making a decision between the two, I lean towards using XCTests as the default testing framework for my personal project. However as the project gets bigger, then I will look into using a combination of both Quick + Nimble + XCTests. 
For a project in which there are more contributors and stakeholders, I can see the benefits of using Quick + Nimble as its easier to perform acceptance testing, understand the value of a tests and modularize the code.


## Setting Up Quick + Nimble via SPM
It was fairly easy to add the dependencies if your project is using the Swift Package Manager. Here is a snippet of what it looks like to add the frameworks in the `Package.swift` file. 

```
dependencies: [
    .package(url: "https://github.com/Quick/Quick.git", from: "7.3.0"),
    .package(url: "https://github.com/Quick/Nimble.git", from: 13.0.0"),
]
```
After adding the dependencies to the package, we can use them in a test target by adding them as products to the dependency section for the test target.

```
.testTarget(
    name: "DiscoverKitTests",
    dependencies: [
        "DiscoverKit",
        .product(name: "Quick", package: "Quick"), 
        .product(name: "Nimble", package: "Nimble")
    ]
)
```
We can test if we incorporated the dependencies properly by importing the frameworks and creating a simple test file. For example, the following file that exists in the `DiscoverKitTests` target should not receive any compile errors after building. This is the start of writing a unit test.

```
import Quick
import Nimble

@testable import DiscoverKit

final class DiscoverKistTests: AsyncSpec {
    override class func spec() {
    }
}
```

## Quick Glance at Writing Unit Tests with Quick + Nimble
Quick provides uses a single function `spec()` to define a suite of test cases. `spec()` is can be composed of multiple sections which are `describe()`, `context()` and `it()`.
* `describe()` - acts as a container and defines the behavior or action you want to test at a high level
* `context()` - can be used if more details are needed to clarify a certain scenario that is being tested (optional)
* `it()` - used to define individual test cases as we would with a function in XCTests; expectation checks belong here.

```
import Quick
import Nimble

@testable import DiscoverKit

final class DiscoverKistTests: AsyncSpec {
    override class func spec() {
        describe("the Discover tab") {
            it("shows loading state at initial load") {
                ...
            }
            it("shows recommendation list after fetch") {
                ...
            }
            it("shows error state after fetching error") {
                ...
            }
        }
    }
}

```

When writing a test, the above constructs are used to organize the test cases within the suite. There are also other constructs to know such as `beforeEach` and `afterEach` that acts similar to setting up and tear down of a tests. Although it looks like one giant test case if you are used to creating a function per test case with XCTests, you can still run the individual `it` test cases by going to the test navigator and selecting on the test you want. 

Within each test case, we want to validate and fulfill test expectations. Nimble provides that power through using `expect()`, which replaces assertions from XCTests. There are a wide range of different matchers that can be used, some examples are:

```
# Checking if two values are equal
expect(value).to(equal(expectedValue)

# Checking if boolean is true
expect(isHappy).to(beTrue())

# Checking if result is nil
expect(result).to(beNil())

# Checking if collection contains a string
expect(books).to(contain("Harry Potter"))
```

Overall, this is a quick note of my initial investigation using Quick + Nimble.

## Resources
To learn more about SwiftUI, here are some useful resources that dives deeper into the framework:
* [Swift Package Index - Quick](https://swiftpackageindex.com/Quick/Quick)
* [Swift Package Index - Nimble](https://swiftpackageindex.com/Quick/Nimble)
* [Official Repository - Quick](https://github.com/Quick/Quick)
* [Official Repository - Nimble](https://github.com/Quick/Nimble)
* [Documentation](https://github.com/Quick/Quick/blob/main/Documentation/en-us/README.md#documentation)
