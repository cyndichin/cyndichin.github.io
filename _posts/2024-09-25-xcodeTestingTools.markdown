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

Select "Run" and can verify if your newly created tests have succeeded for all runs.

## Check code coverage
Code coverage is a good way to indicate whether your tests are hitting certain code paths. It is a way of measuring how much production code the test code covers. This helps us discover whether we tested different paths of control flow. 

First, we need to make sure that code coverage is enabled in our Test Plan configurations. After selecting the test plan in the Project navigator, you should see a similar configuration as below. Ensure that the Code Coverage setting is On.

![Code Coverage](/images/ios/xcodeTestingTools/07-codeCoverageSetting)

Next, I turn on the code coverage bar by navigating to the setting shown in the screenshot below. Then, I run the tests to see how much of the file is covered.

![Code Coverage](/images/ios/xcodeTestingTools/04-codecoverage.png)

The coverage bar will show you the number of times a test has executed a part of the code. Green indicators show if the portion of a code has been reached, and red will be shown if no tests covers that specific part of the code. By using these indicators, this can help us confirm if we test multiple paths. Usually, the happy paths are covered, but its also important to cover other cases as well such as what happens when we return early.

![Code Coverage bar](/images/ios/xcodeTestingTools/09-codeCoverageBar.png)

## View the reports
After running tests, I also look at the Tests and Coverage sections in the Report Navigator. The reports provides a high level overview on tests and the metrics related to the code coverage. By heading over to the report navigator, I can view the test results and view if there are any issues. 

![Report Navigator](/images/ios/xcodeTestingTools/05-reportNavigator.png)

Here is an example of what a Test report may look like. This may be useful to understand patterns, trends and issues that occurred when running tests.

![Test Report](/images/ios/xcodeTestingTools/06-testReport.png)

Additionally, you can also view code coverage results from the Coverage report in the Report Navigator. This may be useful to understand gaps in coverage and areas that may need more testing.

![Coverage Report](/images/ios/xcodeTestingTools/08-codeCoverageReport.png)

## Wrap up
Overall, these are some handy tools that I use in Xcode while I am writing, viewing or troubleshooting tests. Hope sharing this will also help others who aren't aware of these tools. 
In general, I enjoy writing tests because it gives me a sense of confidence in the code that I am writing and ensures that my production code is testable and decoupled. Additionally, it reaffirms that I understand
the code and provides me feedback when I am implementing requirements. The bonus for me that it can also catch bugs early on.

## More resources
To learn more about other Xcode tools, check out my other blog on debugging tools:
* [Xcode Debugging Tools](https://github.com/Quick/Quick/blob/main/Documentation/en-us/README.md#documentation)

Useful Apple Docs on testing tools:
* [Apple Docs - Code Coverage](https://developer.apple.com/documentation/xcode/determining-how-much-code-your-tests-cover#Enable-code-coverage-in-your-test-plan).
* [Apple Docs - Updating tests](https://developer.apple.com/documentation/xcode/updating-your-existing-codebase-to-accommodate-unit-tests)
