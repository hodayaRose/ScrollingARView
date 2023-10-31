# ScrollingARView

This project demonstrates the seamless integration of AR (Augmented Reality) and SwiftUI to create an interactive app that provides an intuitive starting point for building your AR APP.

![ARView Preview](https://github.com/your_username/ScrollingARView/blob/main/ARViewPreview.jpeg)

## Features
- This project includes 3 3D models to explore.
- Load, anchor, and display 3D models in an AR view through `ARViewManager`.
- Configure, update, and handle touch gestures in AR view through `ARViewContainer`.
- Browse through available 3D models using a horizontal scroll view in `ScrollViewComponent`.
- Integrate AR view and the scroll view in a seamless user interface in `ContentView`.
- Utilizes ARKit and RealityKit for AR interactions and SwiftUI for user interface.
- Modify the 3D models, anchoring, and gesture handling according to your use case.

## Requirements

- iOS 17.0+
- Xcode 15.1 beta

## Installation

```bash
# Clone the repository
git clone https://github.com/hodayaRose/ScrollingARView.git

# Open the project in Xcode
open ARScrollingView.xcodeproj


```
## Getting Started

### ARViewManager
`ARViewManager` is responsible for loading and anchoring 3D models into the provided ARView instance. You can specify the 3D model name and the ARView instance to load and anchor the model.

### ARViewContainer
`ARViewContainer` handles the configuration of the ARView, updates, and coordination of touch gestures. It ensures ARWorldTrackingConfiguration is supported and sets up gesture recognizers for handling interactions.

### ScrollViewComponent
`ScrollViewComponent` provides a horizontal scroll view for browsing through available 3D models. Tapping on a model will load and anchor it in the AR view.

### ContentView
`ContentView` integrates the AR view and the scroll view into a seamless user interface, providing a delightful user experience.

### Notes
If you want to add more .usdz models to the app all you have to do is: 
- drag the model to the project (make sure the file is .usdz)
- add model name to modelNames array
- EX: I have a 3d model names Hat.usdz I'll add the model to project and then add to modelNames array ["Guitar,"Robot","Hat"]


## Preview

```swift
ContentView(arView: .constant(ARView(frame: .zero)))
```

Extend your AR capabilities and SwiftUI interface by exploring and modifying the code to
 fit your needs. Your journey in building interactive AR apps starts here!
> This is a feature project made by Hodaya Rosenberg, check out more at my profile (https://github.com/hodayaRose).





