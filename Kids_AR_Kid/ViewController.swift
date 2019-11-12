//
//  ViewController.swift
//  Kids_AR_Kid
//
//  Created by Julieth Angel on 8/3/19.
//  Copyright © 2019 JuliethAngel. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var imageHand: UIImageView!
    @IBOutlet weak var introChangeSticker: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var sceneView: ARSKView!
    @IBOutlet weak var introImageHide: UIImageView!
    @IBOutlet weak var emojiPicker: UIPickerView!
    @IBOutlet weak var currenEmojiButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    var colorCurrent: UIColor = UIColor.black
    var currentEmoji: String = ""
    var currentAnimal: UIImage = #imageLiteral(resourceName: "bearSmall")
    var currentAnimalName: String = "Here"

   
    let names: [String] = ["bearSmall","birdSmall","bunnySmall","catSmall", "cocoSmall","cowSmall","dogSmall", "dolphinSmall","flamSmall","foxSmall","giraSmall","hippoSmall", "horseSmall","seahSmall", "koalaSmall", "lambSmall", "lionSmall", "monkeySmall","parrotSmall", "peacSmall", "pigSmall", "pingSmall","rinoSmall", "sealSmall", "snakeSmall","tigerSmall", "turtleSmall"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        currentAnimalName = names[0]

        self.emojiPicker.delegate = self
        self.emojiPicker.dataSource = self
        
        if let scene = SKScene(fileNamed: "Scene"){
            sceneView.presentScene(scene)
    
        }

    //hide emoji for pick item
        emojiPicker.isHidden = true
        colorCurrent = introLabel.textColor
        currenEmojiButton.setTitle("", for: .normal)
        currenEmojiButton.setBackgroundImage(UIImage(named: names[0]), for: .normal)
        emojiPicker.layer.backgroundColor = UIColor.lightText.cgColor
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        introLabel.text = "Tap Anywhere to add Stickers"
    
        introChangeSticker.text = "Tap to pick a different sticker here"
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    @IBAction func cameraPhoto(_ sender: Any) {
        sceneView.snapshotView(afterScreenUpdates: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }
    
    //UI PICKER
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentAnimalName = names[row]
        currenEmojiButton.setBackgroundImage(UIImage(named: currentAnimalName), for: .normal)
        emojiPicker.isHidden = true
        currenEmojiButton.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myImageView = UIImageView()
        myImageView.image = UIImage(named: names[row])
        return myImageView

    }
   
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 70
    }
    
   
//ACTION BUTTONS
    @IBAction func currentEmojiAction(_ sender: UIButton) {
        if(emojiPicker.isHidden){
            emojiPicker.isHidden = false
            introLabel.isHidden = true
            introImageHide.isHidden = true
            introChangeSticker.isHidden = true
            currenEmojiButton.isHidden = true
        }

    }
    @IBAction func clearButtonAction(_ sender: UIButton) {
        if let scene = SKScene(fileNamed: "Scene"){
            sceneView.presentScene(scene)
            introLabel.isHidden = false
            introImageHide.isHidden = false
            introChangeSticker.isHidden = false
            imageHand.isHidden = false
               introLabel.text = "Tap Anywhere to add Stickers"
            
        }
    }

    @IBAction func contributionsInfoAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Instructions", message: "To start just a tap on any flat surface and you can place an Animal Sticker from anywhere at any time! \nno internet or real stickers need it! \n\nPick a different animal by taping on the current one on the bottom and scrolling down then play around. In random times if you shake the phone the stickers would start moving. \nClear the screen and start again! \n\nHave fun with it! \n\n\nDeveloped by \nJulieth Angel", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
}


extension ViewController: ARSKViewDelegate{
    
    
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        if !imageHand.isHidden {
            imageHand.isHidden = true
            introLabel.isHidden = true
        }
            let ImageAnimal = UIImage(named: currentAnimalName)
        if ImageAnimal != nil {
            let Texture = SKTexture(image: ImageAnimal!)
            let nodeNeed = SKSpriteNode(texture: Texture)
                             node.addChild(nodeNeed)
        }
                 
        
      
   
    }
   
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        if (ARConfiguration.isSupported) {
            let alert = UIAlertController(title: "There was an error with loading Camera", message: "We are sorry for the inconvenience. There was a problem loading the camera. Please try loading again or check permissions. Thank you", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default){ (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            })
            present(alert, animated: true)
            // Great! let have experience of ARKIT
        }
        else {
            let alert = UIAlertController(title: "There was an error with loading Camera", message: "We are sorry for the inconvinience. Augmented reality is not supported in this device.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alert, animated: true)
                    print(error.localizedDescription)

            // Sorry! you don't have ARKIT support in your device
        }
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
       
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
       
    }
    
}
