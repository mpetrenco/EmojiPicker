# EmojiPicker

<p align="center">
<img src="https://i.postimg.cc/FFW5K7xC/picker.png" alt="Logo" width="200px">
</p>

<p align="center">
An emoji picker build in SwiftUI, inspired by Apple's emoji keyboard.
</p>

## How to use:

First of all, make sure to import the package:

```swift
import EmojiPicker
```

Then, add the `EmojiPicker` component to your SwiftUI view and bind it to a boolean state, which will be responsible for showing/hiding the emoji picker.

```swift
EmojiPicker(shouldDisplay: $shouldDisplay) { selectedEmoji in
  //...
}
```

> **Note:**  
> In SwiftUI, the navigation bar will always stay on top of the view. To fix this, wrap the `NavigationView` in a `ZStack` and add the `EmojiPicker` on top.

## To Do:
- [ ] Add search functionality to the emoji picker;
- [ ] Add dark mode support;
- [ ] Add skin tone variations when long tapping an emoji;
- [ ] Add iPad support;
- [ ] Add landscape support;