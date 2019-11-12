//
//  Scene.swift
//  Kids_AR_Kid
//
//  Created by Julieth Angel on 8/3/19.
//  Copyright © 2019 JuliethAngel. All rights reserved.
//

import Foundation
import ARKit

class Scene: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {return}
        if let touchLocation = touches.first?.location(in: sceneView){
            if let hit = sceneView.hitTest(touchLocation, types: .featurePoint).first{
                sceneView.session.add(anchor: ARAnchor(transform: hit.worldTransform))
            }
        }
    }
    
   
}
