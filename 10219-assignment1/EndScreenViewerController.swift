//
//  EndScreenViewerController.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 03/07/2024.
//

import UIKit

class EndScreenViewerController: UIViewController {

    
    @IBOutlet weak var theWinner: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        theWinner.text = UserDefaults.standard.string(forKey: "Winner")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
