[![Version](https://img.shields.io/cocoapods/v/TouchCheck.svg?style=flat)](http://cocoapods.org/pods/TouchCheck)
[![License](https://img.shields.io/cocoapods/l/TouchCheck.svg?style=flat)](http://cocoapods.org/pods/TouchCheck)
[![Platform](https://img.shields.io/cocoapods/p/TouchCheck.svg?style=flat)](http://cocoapods.org/pods/TouchCheck)

# TouchCheck

- [Installation (Swift 4)](#installation-swift-4)
    - [Cocoapods](#cocoapods)
    - [Manual](#manual)
- [Usage](#usage)
- [How it works](#how-it-works)
- [Author](#author)
- [License](#license)

TouchCheck shows debug overlays on buttons and interactive views based on a typical finger size - it'll show green and red depending on if the view is big enough and avoids clashes with other touch areas.  It works on all views, even if deeply nested within a view controller.

![https://github.com/rossbeale/TouchCheck/blob/master/example.png](Example)

## Installation

### Cocoapods

- Step 1: Add `pod 'TouchCheck', '~> 0.0.1'` to your Podfile and run `pod update` in Terminal.
- Step 2: Add the one required line, as seen in [usage](#usage)!

### Manual

- Step 1: Drop `TouchCheck.swift` into your project or copy the contents of it where ever you like.

## Usage

Super simple to get started, just add the following line within `didFinishLaunchingWithOptions`:

```swift
TouchCheck.configure(enabled: .always)
```

## How it works

It (when explicitly enabled) swizzles viewDidAppear to find, check and overlay debug views on all buttons or any view which has one gesture recognizer.

In future, this detection will evolve and be smarter.

## Author

Ross Beale, @rossbeale

## Credits

Thanks to [@kdzwinel](https://twitter.com/kdzwinel/status/986541370331541505) for the idea!

## License

TouchCheck is available under the MIT license. See the LICENSE file for more info.