//
//  ViewController.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 22/06/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1: UILabel!
    
    @IBOutlet weak var player2: UILabel!
    
    @IBOutlet weak var pokeball1: UIImageView!
    
    @IBOutlet weak var pokeball2: UIImageView!
    
    @IBOutlet weak var pokemon1: UIImageView!
    
    @IBOutlet weak var pokemon2: UIImageView!
    
    @IBOutlet weak var score_player1: UILabel!
    
    @IBOutlet weak var score_player2: UILabel!
        
    @IBOutlet weak var pokemon1Name: UILabel!
    
    @IBOutlet weak var pokemon2Name: UILabel!
    
    @IBOutlet weak var winnerAnnouncer: UILabel!
    
    @IBOutlet weak var startGame: UIButton!
    
    @IBOutlet weak var animtaion_button: UIButton!
    
    var gameManager = GameManager()
    
    var pokemons = [Pokemon]()
    
    var firstTurn = true
    
    var timer: Timer?
    
    var animationTimer: Timer?
    
    var isClose = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        pokeball1.image = UIImage(named: "pokeball-close")
        pokeball2.image = UIImage(named: "pokeball-close")
        
        let direction = UserDefaults.standard.string(forKey: "Direction")
        
        if direction == "WEST" {
            player1.text = UserDefaults.standard.string(forKey: "UserName")
            player2.text = "CP"
        }
        else {
            player1.text = "CP"
            player2.text = UserDefaults.standard.string(forKey: "UserName")
        }
        
        startGame.setTitle("Start Fight", for: .normal)
        
        pokemon1Name.text = ""
        pokemon2Name.text = ""
        winnerAnnouncer.text = ""
        
        self.startGame.setTitle("Start Fighting", for: .normal)
        
        changeScores()
        
//        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
    }
    
//    @objc func updateUI() {
//        
//    }
    @IBAction func activate_animation(_ sender: Any) {
        if isClose {
            self.isClose = false
            
            var images = [UIImage]()
            
            guard let imageOpen = UIImage(named: "pokeball-open") else { return; }
            guard let imageClose = UIImage(named: "pokeball-close") else { return; }
            
            images.append(imageClose)
            images.append(imageOpen)
            
            self.pokeball1.animationImages = images
            self.pokeball1.animationDuration = 1.0 // Adjust as needed
            self.pokeball1.animationRepeatCount = 1
            self.pokeball1.startAnimating()
            
            // Set a timer to stop the animation and set the final image
            animationTimer?.invalidate() // Invalidate any existing timer
            animationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                self?.pokeball1.stopAnimating()
                self?.pokeball1.image = UIImage(named: "pokeball-open") // Set to the last frame
            }
        } else {
            self.isClose = true
            
            var images = [UIImage]()
            
            guard let imageOpen = UIImage(named: "pokeball-open") else { return;  }
            guard let imageClose = UIImage(named: "pokeball-close") else { return; }
            
            images.append(imageOpen)
            images.append(imageClose)
            
            self.pokeball1.animationImages = images
            self.pokeball1.animationDuration = 1.0 // Adjust as needed
            self.pokeball1.animationRepeatCount = 1
            self.pokeball1.startAnimating()
            
            // Set a timer to stop the animation and set the final image
            animationTimer?.invalidate() // Invalidate any existing timer
            animationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                self?.pokeball1.stopAnimating()
                self?.pokeball1.image = UIImage(named: "pokeball-close") // Set to the last frame
            }
        }
    }

    
    
    @objc func runningTimer() {
        if gameManager.checkingGameOver() {
            timer?.invalidate()
            timer = nil
            finishGame()
        }
        else {
            next()
        }
    }
    
    func changeScores() -> Void {
        score_player1.text = String(self.gameManager.player1.pokemons.count)
        score_player2.text = String(self.gameManager.player2.pokemons.count)
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        self.gameManager.newGame()
        self.startGame.isHidden = true
        if self.firstTurn {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(runningTimer), userInfo: nil, repeats: true)
        }
    }
    
    //todo - moving this to GameManager
    func next() {
        if !self.firstTurn {
            let pokemonsCount = self.pokemons.count
            let result = self.pokemons[pokemonsCount - 2].comapre(pokemon: self.pokemons[pokemonsCount - 1])
            if result == 1 {
                gameManager.player1.addPokemons(pokemons: pokemons)
                pokemons.removeAll()
                changeScores()
            }
            else if result == -1 {
                gameManager.player2.addPokemons(pokemons: pokemons)
                pokemons.removeAll()
                changeScores()
            }
        }
        else {
            self.firstTurn = false
        }
        
        let player1Pokemon = gameManager.player1.getPokemon()
        let player2Pokemon = gameManager.player2.getPokemon()
        
        pokemon1.image = UIImage(named: player1Pokemon.imageName)
        pokemon2.image = UIImage(named: player2Pokemon.imageName)
        pokemon1Name.text = player1Pokemon.imageName
        pokemon2Name.text = player2Pokemon.imageName
        
        pokemons.append(player1Pokemon)
        pokemons.append(player2Pokemon)
        
        
    }
    
    func finishGame() {
        self.startGame.isHidden = false
        self.startGame.setTitle("Fight Again", for: .normal)
        hidingElements()
        let message = self.gameManager.checkingWinner()
        
        if message.contains("1") {
            self.pokemon2.isHidden = true
        }
        else {
            self.pokemon1.isHidden = true
        }
        
        winnerAnnouncer.text = message
    }
    
    func hidingElements() {
        self.pokeball1.isHidden = true
        self.pokeball2.isHidden = true
        self.player1.isHidden = true
        self.player2.isHidden = true
        self.score_player1.isHidden = true
        self.score_player2.isHidden = true
        self.pokemon1Name.isHidden = true
        self.pokemon2Name.isHidden = true
    }
    
}

