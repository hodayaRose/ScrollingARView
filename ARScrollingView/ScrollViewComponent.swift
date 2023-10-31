//
//  ScrollViewComponent.swift
//  LiduLounge
//
//  Created by Hodaya Rosenberg on 8/14/23.
//

import SwiftUI
import ARKit
import RealityKit

struct ScrollViewComponent: View {
    @Binding var arView: ARView
    @Binding var modelNames : [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(modelNames, id: \.self) { modelName in
                    Button(action: {
                        print("model tapped")
                        DispatchQueue.main.async {
                            
                            // Clear all existing entities
                                  removeAllEntities(from: arView)
                            // Load specific model tapped
                            AroomaArt.loadModel(in: arView, for: modelName)
                        }
                    }) {
//                        Image( "model\(index)" )
                        Image(modelName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 35)  )
                            
                    }
                }
            }
        }
    }

//    private func loadModel(index: Int) {
//      
//        
//        // Directly create the SIMD2<Float> since it's non-optional
//        let minimumBounds = SIMD2<Float>([0,0])
//        
//        let anchor = AnchorEntity(.plane([.horizontal,.vertical], classification: .any, minimumBounds: minimumBounds))
//        
//        // Ensure that the model file URL is valid and the model can be loaded
//        guard let url = Bundle.main.url(forResource: "hhio", withExtension: "usdz"),
//              let modelEntity = try? ModelEntity.load(contentsOf: url) else {
//            print("Unable to load the model.")
//            return
//        }
//        modelEntity.orientation = simd_quatf(angle: .pi/2, axis: [1, 0, 0]) // Adjust as needed
//
//       // modelEntity.setScale(SIMD3(x: 0.1, y: 0.1, z: 0.1), relativeTo: anchor)
//       // modelEntity.transform.translation.y += 0.04
//       // modelEntity.transform.translation.z -= 0.04
//        
//        anchor.addChild(modelEntity)
//        arView.scene.addAnchor(anchor)
//    }




}


