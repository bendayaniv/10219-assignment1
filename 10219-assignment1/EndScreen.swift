//
//  StartScreen.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 03/07/2024.
//

import UIKit

class EndScreenViewController: UIViewController {
    
//    @IBOutlet weak var startGameButton: UIButton!
    
    @IBOutlet weak var theWinner: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theWinner.text = UserDefaults.standard.string(forKey: "Winner")
    }
    
//    @IBAction func moveToGame(_ sender: Any) {
//        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
//            navigationController?.pushViewController(nextVC, animated: true)
//        }
//    }
    
}
