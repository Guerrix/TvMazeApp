# TvMazeApp

GoNet iOS Code Challenge

# Developer Notes

### Requirements

- Xcode 13.3,x
- Cocoapods
- A super speedy futuristic machine or a Mac

### Architecture 

For the sake of the code challenge for the UI layer I used a combination of Storyboards, xib, and code-only components. 

- MVVM + RxSwift

- Layers: 

  - Network -> DataModels, Routes, Server
  - UI -> Controllers, xibs, code-only components
  - Behaviour -> ViewModels, DBManager
  - Foundation -> Models

- 3rd Party Vendors: Please take a look to the `podfile`

  

### Getting started

In Terminal

1. Go to the Root Directory
4. `pod install`
6. Open `TvMazeApp.xcworkspace` with Xcode

