# JustJson

[![CI Status](http://img.shields.io/travis/fattomhk/JustJSON.svg?style=flat)](https://travis-ci.org/fattomhk/JustJSON)
[![Version](https://img.shields.io/cocoapods/v/JustJson.svg?style=flat)](https://cocoapods.org/pods/JustJson)
[![License](https://img.shields.io/cocoapods/l/JustJson.svg?style=flat)](https://cocoapods.org/pods/JustJson)
[![Platform](https://img.shields.io/cocoapods/p/JustJson.svg?style=flat)](https://cocoapods.org/pods/JustJson)

<!--
<a href="https://placehold.it/400?text=Screen+shot"><img width=200 height=200 src="https://placehold.it/400?text=Screen+shot" alt="Screenshot" /></a> -->


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate JustJson into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'JustJson'
```

Then, run the following command:

```bash
$ pod install
```

## Example
### Convert to Dictionary from JSON string
```swift
let dict = jsonStr.toDictionary()
```

### Convert Dictionary [String: Any] to JSON string
```swift
let jsonString = dict.toJSONStr()
```

### Get Data from Dictionary
```swift
let foo = dict[keyPath: "first.second.abc 123"] //return an optional Any
```

```swift
let foo = dict[string: "first.second.abc 123"] //return an optional String
```

```swift
let foo = dict[dict: "first.second.abc 123"] //return an optional Dictionart
```

```swift
let foo = dict[array: "first.second.abc 123"] //return an optional Array
```

### Looping
```swift
for foo in dict[arrayValue: "first.second.foos"] {
  print(foo)
}
```

## More Exampes:
[Test case](https://github.com/fattomhk/JustJSON/blob/master/Tests/JustJsonTests.swift)

## Author

Horst Leung

## Thanks
Ole Begemann [https://oleb.net/blog/2017/01/dictionary-key-paths/]


## License

JustJson is available under the MIT license. See the LICENSE file for more info.
