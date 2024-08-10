# EmojiPicker

<p align="center">
<img src="https://iili.io/dlwAuSV.md.png" alt="Demo of the Emoji Picker UI.">
</p>

<p align="center">
An emoji picker built in SwiftUI, inspired by Apple's emoji keyboard.
</p>

## Note on Version 2.0:

With the release of 2.0, I did what I was meaning to do for a long time - add Dark Mode support, remove the stupid navigation bar limitation from 1.0 _(due to my lack of SwiftUI knowledge)_, and improve the overall code quality.

As such, I consider this more or less complete from my perspective. The code is licensed under MIT, so feel free to fork it, modify it and make it your own.

## How to use:

__STEP 1:__  
Import the package:

```swift
import EmojiPicker
```

__STEP 2:__  
Add the `.emojiPicker(isDisplayed:onEmojiSelected:)` modifier to your view:

```swift
struct MyView: View {

  @State var emojiValue = ""
  @State var isDisplayed = false

  var body {
    VStack {
      Text(emojiValue)
      Button("Select Emoji") {
        isDisplayed.toggle()
      }
    }
    .emojiPicker(isDisplayed: $isDisplayed) { emoji in
      emojiText = emoji.value
    }
  }
}
```