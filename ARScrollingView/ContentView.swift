//
//  ContentView.swift
//  AroomaArt
//
//  Created by Hodaya Rosenberg on 10/22/23.
//


import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
        @State var modelNames = ["Shoe", "Robot", "Guitar"] // Add more model names as needed
  
        @Binding var arView: ARView
        var body: some View {
            GeometryReader { geometry in
                   ZStack {
                       ARViewContainer(arView: $arView, modelNames : $modelNames)
                           .edgesIgnoringSafeArea(.all) // Ignore safe area for AR view

                       ScrollViewComponent(arView: $arView, modelNames: $modelNames)
                           .padding() // Add padding around the ScrollView
                           .background(Color.black.opacity(0.5)) // Optional: Add a background color
                           .position(x: geometry.size.width / 2, y: geometry.size.height - 50) // Position at the bottom
                   }
               }
           
  
        }
        
}
func loadModel(in arView: ARView, for modelName: String) {
   
   
        if let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
            loadAndAnchorEntity(from: url, in: arView, modelName: modelName)
        }
    
}

func loadAndAnchorEntity(from url: URL, in arView: ARView,modelName : String) {
    do {
        let loadedEntity = try Entity.load(contentsOf: url)
        
        
      //  loadedEntity.scale = SIMD3<Float>(0.2., 0.2, 0.2)
       print( loadedEntity.availableAnimations)
        let anchor = AnchorEntity(plane: .vertical,classification: .wall)
        anchor.name = modelName
            anchor.addChild(loadedEntity)
            arView.scene.addAnchor(anchor)
        
        
    } catch {
        print("Error loading entity from \(url): \(error)")
    }
}
func removeAllEntities(from arView: ARView) {
    for anchor in arView.scene.anchors {
        arView.scene.removeAnchor(anchor)
    }
}
struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: ARView
    @Binding var modelNames: [String]
   

    func makeUIView(context: Context) -> ARView {
        configureARView()
        setupGestureRecognizers(for: arView, context: context)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    private func configureARView() {
        // Ensure that ARWorldTrackingConfiguration is supported
        guard ARWorldTrackingConfiguration.isSupported else {
            print("ARWorldTrackingConfiguration is not supported.")
            return
        }

        // Enable debugging options
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
    }

    private func setupGestureRecognizers(for arView: ARView, context: Context) {
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapRecognizer)
    }
   

    // MARK: Coordinator for handling interactions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var container: ARViewContainer
        var selectedWord: String?
        var speachFeature = SpeachFeature()
        
        init(_ container: ARViewContainer) {
            self.container = container
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let arView = sender.view as? ARView else { return }

            let location = sender.location(in: arView)
            
            // Create a raycast query for entity hits
            if let query = arView.makeRaycastQuery(from: location, allowing: .existingPlaneGeometry, alignment: .any) {
                let results = arView.session.raycast(query)
                
                // If we hit an entity, handle it
                if let firstResult = results.first, let hitAnchor = firstResult.anchor {
                    for anchorEntity in arView.scene.anchors where anchorEntity.anchorIdentifier == hitAnchor.identifier {
                        
                        // Print the name of the AnchorEntity
                        print("AnchorEntity name: \(anchorEntity.name)")
                        self.selectedWord = anchorEntity.name
                        
                        // Handle the selected word (e.g., update UI, trigger other actions, etc.)
                        handleSelectedWord()
                        
                        break
                    }
                }
            }
        }
        
        func handleSelectedWord() {
            if let word = selectedWord {
                speachFeature.pronunciationOfWord(word)
                print("Selected word: \(word)")
                
            }
        }






    }
}


#Preview {
    ContentView(arView: .constant(ARView(frame: .zero)))
}
