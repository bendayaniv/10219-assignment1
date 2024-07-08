//
//  StartScreen.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 03/07/2024.
//

import UIKit
import CoreLocation

class StartScreen: UIViewController, CLLocationManagerDelegate {
        
    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var getNameButton: UIButton!

    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var startGame: UIButton!

    @IBOutlet weak var westSide: UIImageView!

    @IBOutlet weak var eastSide: UIImageView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.isHidden = true
        startGame.isHidden = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let userName = UserDefaults.standard.string(forKey: "UserName")
        
        if userName != nil {
            existingUserName(userNameTextField: nil, userName: userName)
        }
        
    }
    
    func existingUserName(userNameTextField: UITextField?, userName: String?) {
        
        var theName: String
        
        locationManager.requestLocation()
        
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
    }
    
    
    @IBAction func getName(_ sender: Any) {
        if ((userNameTextField.text?.isEmpty) == false) {
            existingUserName(userNameTextField: userNameTextField, userName: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            print("\(lat) \(lng)")
            
            if lng > 34.817549168324334 {
                UserDefaults.standard.set("EAST", forKey: "Direction")
                westSide.isHidden = true
            } else {
                UserDefaults.standard.set("WEST", forKey: "Direction")
                eastSide.isHidden = true
            }
        }
    }
    
    func locationManager(_ manager:CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error)")
    }
    
}
