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

    @IBOutlet weak var sceneView: ARSKView!
    @IBOutlet weak var emojiPicker: UIPickerView!
    @IBOutlet weak var currenEmojiButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    var currentEmoji: String = ""
     let emoji: [String] = [" \u{1F41C} "," \u{1F9A1} "," \u{1F987} "," \u{1F43B} "," \u{1F426} ", " \u{1F421} ", " \u{1F403} ", " \u{1F41B} "," \u{1F98B} "," \u{1F42A} "," \u{1F408} "," \u{1F431} "," \u{1F42D} "," \u{1F425} "," \u{1F424} "," \u{1F414} "," \u{1F43F} "," \u{1F42E} "," \u{1F404} "," \u{1F980} "," \u{1F997} "," \u{1F40A} "," \u{1F98C} "," \u{1F436} "," \u{1F415} "," \u{1F42C} "," \u{1F54A} "," \u{1F432} "," \u{1F409} "," \u{1F986} "," \u{1F985} "," \u{1F418} "," \u{1F411} "," \u{1F41F} "," \u{1F438} "," \u{1F98A} "," \u{1F992} "," \u{1F410} "," \u{1F423} "," \u{1F994} "," \u{1F99B} "," \u{1F41D} "," \u{1F434} "," \u{1F40E} "," \u{1F998} "," \u{1F428} "," \u{1F41E} "," \u{1F406} "," \u{1F981} "," \u{1F98E} "," \u{1F999} "," \u{1F412} "," \u{1F99F} "," \u{1F439} "," \u{1F401} "," \u{1F419} "," \u{1F98D} "," \u{1F989} "," \u{1F402} "," \u{1F436} "," \u{1F99C} "," \u{1F99A} "," \u{1F427} "," \u{1F437} "," \u{1F416} "," \u{1F429} "," \u{1F430} "," \u{1F407} "," \u{1F99D} "," \u{1F40F} "," \u{1F400} "," \u{1F98F} "," \u{1F413} "," \u{1F995} "," \u{1F982} "," \u{1F988} "," \u{1F41A} ", " \u{1F40C} "," \u{1F40D} "," \u{1F577} "," \u{1F991} "," \u{1F9A2} "," \u{1F42F} "," \u{1F405} "," \u{1F996} "," \u{1F420} "," \u{1F983} "," \u{1F422} "," \u{1F42B} "," \u{1F984} "," \u{1F433} "," \u{1F40B} "," \u{1F98A} "," \u{1F993} "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        self.emojiPicker.delegate = self
        self.emojiPicker.dataSource = self
        
        if let scene = SKScene(fileNamed: "Scene"){
            sceneView.presentScene(scene)
        }
    //hide emoji for pick item
        emojiPicker.isHidden = true
        
        currentEmoji = "  "
        currentEmoji.append(emoji[0])
        currentEmoji.append(" ")
        currenEmojiButton.setTitle(currentEmoji, for: .normal)
        emojiPicker.layer.backgroundColor = UIColor.lightText.cgColor
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
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
        return emoji.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentEmoji = "  "
        currentEmoji.append(emoji[row])
        currentEmoji.append("  ")
        currenEmojiButton.setTitle(currentEmoji, for: .normal)
        emojiPicker.isHidden = true
        currenEmojiButton.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil)
        {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Arial", size: 70)
        }
        
        pickerLabel?.text = emoji[row]
 
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return emoji[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 70
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 110
    }
    
   
//ACTION BUTTONS
    @IBAction func currentEmojiAction(_ sender: UIButton) {
        if(emojiPicker.isHidden){
            emojiPicker.isHidden = false
            currenEmojiButton.isHidden = true
        }

    }
    @IBAction func clearButtonAction(_ sender: UIButton) {
        if let scene = SKScene(fileNamed: "Scene"){
            sceneView.presentScene(scene)
        }
    }

    @IBAction func contributionsInfoAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Developer and Image Information", message: "My name is Julieth Angel. The images of the Unicode emojis are Copyright © 1991-2019 Unicode, Inc. All rights reserved", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
   
}


extension ViewController: ARSKViewDelegate{
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        let nodeEmoji = SKLabelNode(text: currentEmoji)
        node.addChild(nodeEmoji)
    }
   
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        let alert = UIAlertController(title: "There was an error with loading Camera", message: "We are sorry for the inconvinience. We are getting better every day and would be fixing this soon. Thank you", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
       
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
       
    }
    
}
