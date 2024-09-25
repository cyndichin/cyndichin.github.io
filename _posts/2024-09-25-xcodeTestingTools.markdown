---
layout: post
title:  "Xcode Testing Tools"
date:   2024-09-25 5:16:33
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile, testing]
---

> Part of the Mobile Development series

# Overview
This blog post assumes you have some familiarity with Xcode and tests.  

Here are some Xcode tools that I use when writing tests to make sure that my tests are valuable.

## Run tests repeatedly
Running tests repeatedly helps catch issues early and provide a level of confidence that the tests are not flaky. In order to run tests repeatedly, this can be accomplished by going to the test navigator in Xcode and right clicking on the test that you would like to run repeatedly.

![Test Navigator](/images/ios/xcodeTestingTools/01-testNavigator.png)

After you select an option to run the tests repeatedly, then you should see a prompt pop up to specify some parameters. I usually keep the default settings and change the maximum repetitions to use 1000 times for individual test classes and 10 times for when I run the whole test suite.

![Test Repeatedly Prompt](/images/ios/xcodeTestingTools/02-testRepeatedlyPrompt.png)

## Check code coverage
Code coverage is a good way to indicate whether your tests are hitting certain code paths. It is a way oof mesasuing how much production code the test code covers. This helps us discover different paths of control low. 

First, I turn on the code coverage bar by navigating to the setting shown in the screenshot. Then, I run the tests to see how much of the file is covered. The coverage bar will show you the number of times a test has executed a part of the code. It is green if the code has been reached, but you will see red if no tests covers a part of the code.

![Code Coverage](/images/ios/xcodeTestingTools/04-codecoverage.png)

![Code Coverage bar](/images/ios/xcodeTestingTools/09-codeCoverageBar.png)

## View the reports
After running tests, I also look at the Tests and Coverage sections in the Report Navigator. This provides a high level view on tests and the metrics related to the code coverage that the tests have. By heading over to the report navigator, I can view the test results and view if there are any issues. 
![Report Navigator](/images/ios/xcodeTestingTools/05-reportNavigator.png)

If successful, you should see a screenshot similar to the one below when running a test repeatedly:
![Test Report](/images/ios/xcodeTestingTools/06-testReport.png)

Additionally, you can also view code coverage results from the Coverage report in the Report Navigator. 

![Coverage Report](/images/ios/xcodeTestingTools/08-codeCoverageReport.png)

## More resources
To learn more about other Xcode tools, check out my other blog on debugging tools:
* [Xcode Debugging Tools](https://github.com/Quick/Quick/blob/main/Documentation/en-us/README.md#documentation)
Apple Docs:
* [Apple Docs - Code Coverage](https://developer.apple.com/documentation/xcode/determining-how-much-code-your-tests-cover#Enable-code-coverage-in-your-test-plan).
* [Apple Docs - Updating tests](https://developer.apple.com/documentation/xcode/updating-your-existing-codebase-to-accommodate-unit-tests)
