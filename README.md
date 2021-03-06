# DSRadialMenu

[![Version](https://img.shields.io/cocoapods/v/DSRadialMenu.svg?style=flat)](http://cocoapods.org/pods/DSRadialMenu)
[![License](https://img.shields.io/cocoapods/l/DSRadialMenu.svg?style=flat)](http://cocoapods.org/pods/DSRadialMenu)
[![Platform](https://img.shields.io/cocoapods/p/DSRadialMenu.svg?style=flat)](http://cocoapods.org/pods/DSRadialMenu)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

DSRadialMenu provides a way to display menu items that appear from behind and are positioned around a given center button. Menu item positions are defined as the hours on a clock face. Menu items can be added or removed and respond to interaction.

<b>Updated for Swift 3.</b>

![Example](http://i.imgur.com/nRxR3h3.gif)

## Usage

1. Add a UIView. Set the Class and Module in Interface Builder to DSRadialMenu.
2. Add a button that will act as the center of the menu and will perform the open and close action. This button will need constraints that define its size and position.
3. Connect this button's outlet to the centerButton property of the DSRadialMenu.
4. Add code to open or close the menu when the button is tapped.
   ```swift
   switch radialMenu.state {
   case .closed:
      radialMenu.open()
   case .open:
      radialMenu.close()
   }
   ```
   
5. Add your menu items and configure the buttons if necessary.
   ```swift
   typealias MenuItem = (title: String, position: DSRadialMenu.MenuItemPosition)
   let menuItems = [
      MenuItem("Account", .threeOClock),
      MenuItem("Share", .fourOClock),
      MenuItem("Start", .fiveOClock),
      MenuItem("Sign Out", .sixOClock)
   ]

   for menuItem in menuItems {
      let button = radialMenu.addMenuItem(menuItem.title, position: menuItem.position)
      button.setTitleColor(UIColor.black, for: .normal)
   }
   ```

## Installation

### CocoaPods
DSRadialMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DSRadialMenu"
```
### Carthage
DSRadialMenu supports [Carthage](https://github.com/Carthage/Carthage). Add the following to your Cartfile:
```ruby
github "DanSessions/DSRadialMenu"
```

## Author

Dan Sessions, dansessions+github@gmail.com

## License

DSRadialMenu is available under the MIT license. See the LICENSE file for more info.


