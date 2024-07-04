//
//  StartScreen.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 03/07/2024.
//

import UIKit

class StartScreen: UIViewController {
        
    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var getNameButton: UIButton!

    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var startGame: UIButton!


    @IBOutlet weak var westSide: UIImageView!

    @IBOutlet weak var eastSide: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.isHidden = true
        startGame.isHidden = true
        
        let userName = UserDefaults.standard.string(forKey: "UserName")
        
        if userName != nil {
            existingUserName(userNameTextField: nil, userName: userName)
        }

        // Remove Object
//        UserDefaults.standard.removeObject(forKey: "UserName")
        
    }
    
    func existingUserName(userNameTextField: UITextField?, userName: String?) {
        
        var theName: String
        
        if userNameTextField == nil || userNameTextField?.text?.isEmpty == true {
            theName = userName ?? ""
        } else {
            theName = userNameTextField?.text ?? ""
        }
        
        userNameLabel.text = "Hey " + theName
        userNameLabel.isHidden = false
        startGame.isHidden = false
        userNameTextField?.isHidden = true
        getNameButton.isHidden = true
        UserDefaults.standard.set(theName, forKey: "UserName")
        UserDefaults.standard.set("EAST", forKey: "Direction")
        
        let direction = UserDefaults.standard.string(forKey: "Direction")
        
        if direction == "WEST" {
            eastSide.isHidden = true
        }
        else {
            westSide.isHidden = true
        }
    }
    
    @IBAction func getName(_ sender: Any) {
        if ((userNameTextField.text?.isEmpty) == false) {
            existingUserName(userNameTextField: userNameTextField, userName: nil)
        }
    }
    
}
