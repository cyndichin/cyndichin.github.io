---
layout: post
title:  "[Mobile] SwiftLint Overview"
date:   2022-12-06 8:03:03
image:  '/images/ios/main.jpeg'
tags:   [ios, swift, mobile development]
---

> Part of the Mobile Development series

# Mobile: SwiftLint Overview

**What is SwiftLint?** A tool that allows us to enforce certain Swift style guide and conventions. It is an open source library and more details can be found here: [https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)

**What are the benefits?** Having a consistent style guide across a codebase helps the repository become more readable and maintainable. Also, incorporating SwiftLint will prevent engineers from having to manually comment style nitpicks in open Pull Requests (PR) since SwiftLint will catch it.

There are thorough details in how to install and use SwiftLint in the GitHub repository, but this post will walk through how SwiftLint was incorporated in the [Pocket](https://github.com/realm/SwiftLint) project using Swift Package Manager (SPM) specifically. We will also go into seeing how warnings and errors are generated for violating the SwiftLint rules and how we can create custom rules that are specific to our projects.

This post will go over the following:
1. Installation
2. SwiftLint in Action
3. Custom Rules

# Installation
## Add SwiftLint to Build Phase in Pocket (iOS)
First, we want to add a Build Phase so that we run the swiftlint checks after each build. 

![SwiftLint Build Phase](/images/ios/01-buildphase.jpg)

Below is an example in the Pocket project, but feel free to configure the shell script differently.

```
export PATH="$PATH:/opt/homebrew/bin"

if which swiftlint > /dev/null; then
  if [ "$CONFIGURATION" = 'Debug' ]; then
    swiftlint
  else 
    echo "Skipping swift lint because it is not a local developer build."
  fi  
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

## Create the SwiftLint Configuration File

Add a `.swiftlint.yml` file in the directory you want to run the SwiftLint command from. This is what the file looks like in the Pocket repository: 
[https://github.com/Pocket/pocket-ios/blob/develop/.swiftlint.yml](https://github.com/Pocket/pocket-ios/blob/develop/.swiftlint.yml)

There are a set of rules that the SwiftLint can check for. There are two main groups:

- `disabled_rules`: Disable rules from the default enabled set.
- `opt_in_rules`: Enable rules that are not part of the default set.

Include and remove any rules that you want to apply the codebase. The rule directory is located here: https://realm.github.io/SwiftLint/rule-directory.html

For more details on configuration: [https://github.com/realm/SwiftLint#configuration](https://github.com/realm/SwiftLint#configuration)

# SwiftLint in Action
Once you add the `.swiftlint.yml` file, we can verify that swiftLint is checking that the codebase is adhering to the Swift Style rules. If you don’t see any warnings, we can see it in action with a simple test using the vertical whitespace rule ([https://realm.github.io/SwiftLint/vertical_whitespace.html](https://realm.github.io/SwiftLint/vertical_whitespace.html)). Make sure that the `disabled_rules` does not include the identifier `vertical_whitespace`. Then go to any of your files and add a bunch of vertical line spaces. The following warning should appear:

![Image 12-7-22 at 8.02 PM.jpg](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/261f490c-510b-47ca-be3f-a44415249feb/Image_12-7-22_at_8.02_PM.jpg)

Now you have SwiftLint integrated and working in your project! If you don’t want to address the issues manually, there is a neat command to auto fix the issues: `swiftlint --fix`. Sometimes it can’t auto fix the issues, but it does a pretty great job from what I seen.

If you are seeing the following issue `-bash: swiftlint: command not found`, you can run the following command `brew install swiftlint` to make sure it is installed properly.

# Custom Rules
As mentioned above, SwiftLint has a rule directory of all the different rules that you can disable or enabled depending on which set the rule belongs to. However, these set of rules are limited in numbers and at times we may want to add custom rules that are not included in the set from the directory. The custom rules uses regular expressions to capture any violations. For example, the rule below will warn if there is any string with `internal func` in the codebase. This custom rule is for demo purposes as it does not check whether it is redundant or not.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/59e4aace-b452-46eb-9c93-b86c2163bdbc/Untitled.png)

There are many regex tools out there that we can use such as [https://regex101.com](https://regex101.com/) to help us test out these rules.

You can also do a rule request by opening an issue on the open source repository as well: https://github.com/realm/SwiftLint/issues

# Summary

Overall, SwiftLint is amazing tool that I recommend integrating into your iOS projects at setup. It keeps you in check to make sure that a certain Swift Style is consistent across the codebase and becomes really helpful as a project has multiple engineers working on it. As always, feel free to reach out to me and provide any feedback or questions.
