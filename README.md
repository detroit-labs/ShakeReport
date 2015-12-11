# ShakeReport

[![CI Status](http://img.shields.io/travis/git/ShakeReport.svg?style=flat)](https://travis-ci.org/git/ShakeReport)
[![Version](https://img.shields.io/cocoapods/v/ShakeReport.svg?style=flat)](http://cocoapods.org/pods/ShakeReport)
[![License](https://img.shields.io/cocoapods/l/ShakeReport.svg?style=flat)](http://cocoapods.org/pods/ShakeReport)
[![Platform](https://img.shields.io/cocoapods/p/ShakeReport.svg?style=flat)](http://cocoapods.org/pods/ShakeReport)

ShakeReport allows your users to simply submit bug reports by shaking the device.
When a shake is detected, the current screen state is captured and the user is
prompted to submit a bug report via a mail composer with the screenshot attached.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

**NOTE:** There is a known issue with using a mail compose view controller in a simulator
which causes some simulators simulator to crash. You will need to run the example on a
device to test out the full report mail functionality.

## Installation

ShakeReport is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ShakeReport"
```

## Author

Dan Trenz ([@dtrenz](http://www.twitter.com/dtrenz)) c/o [Detroit Labs](http://www.detroitlabs.com)

## License

ShakeReport is available under the MIT license. See the LICENSE file for more info.
