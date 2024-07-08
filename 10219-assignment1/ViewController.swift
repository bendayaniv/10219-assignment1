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

    @IBOutlet weak var cardsPlayer1: UIImageView!

    @IBOutlet weak var cardsPlayer2: UIImageView!

    @IBOutlet weak var score_player1: UILabel!

    @IBOutlet weak var score_player2: UILabel!

    @IBOutlet weak var pokemon1Name: UILabel!

    @IBOutlet weak var pokemon2Name: UILabel!

    @IBOutlet weak var startGame: UIButton!
    
    var gameManager = GameManager()
    
    var pokemons = [Pokemon]()
    
    var firstTurn = true
    
    var timer: Timer?
        
    var isBack = true
        
    var isPaused = true
    
    @IBOutlet weak var startCounter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        cardsPlayer1.image = UIImage(named: "back")
        cardsPlayer2.image = UIImage(named: "back")
        
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
        
        self.startGame.setTitle("Start Fighting", for: .normal)
        
        changeScores()
    }
    
    @objc func runningTimer() {
        if gameManager.checkingGameOver(scorePlayer1: score_player1.text ?? "", scorePlayer2: score_player2.text ?? "") {
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

    
    @IBAction func buttonClick(_ sender: Any) {
        self.gameManager.newGame()
//        self.startGame.setTitle("Pause", for: .normal)
        self.startGame.isHidden = true
//        self.startGame.isHidden = false
        if self.firstTurn {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(runningTimer), userInfo: nil, repeats: true)
        }
    }
    
    func next() {
        if isBack == true {
            self.isBack = false
            
            let player1Pokemon = gameManager.player1.getPokemon()
            let player2Pokemon = gameManager.player2.getPokemon()
        
            self.cardsPlayer1.image = UIImage(named: player1Pokemon.imageName)
            self.cardsPlayer2.image = UIImage(named: player2Pokemon.imageName)
            
            UIView.transition(with: self.cardsPlayer1, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            UIView.transition(with: self.cardsPlayer2, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
            pokemon1Name.text = player1Pokemon.imageName
            pokemon2Name.text = player2Pokemon.imageName
            
            pokemons.append(player1Pokemon)
            pokemons.append(player2Pokemon)
        }
        else {
            self.isBack = true
            
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
                else {
                    if score_player1.text == "9" && score_player2.text == "1" {
                        score_player1.text = "10"
                        score_player2.text = "0"
                    }
                    else if score_player2.text == "9" && score_player1.text == "1" {
                        score_player1.text = "0"
                        score_player2.text = "10"
                    }
                }
            }
            else {
                self.firstTurn = false
            }
            
            cardsPlayer1.image = UIImage(named: "back")
            cardsPlayer2.image = UIImage(named: "back")
            
            pokemon1Name.text = ""
            pokemon2Name.text = ""
            
            UIView.transition(with: self.cardsPlayer1, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            UIView.transition(with: self.cardsPlayer2, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    func finishGame() {
        self.startGame.isHidden = false
//        self.startGame.setTitle("Fight Again", for: .normal)
        hidingElements()
        let winner = self.gameManager.checkingWinner()
        
        if winner.contains("1") {
            UserDefaults.standard.set(player1.text, forKey: "Winner")
        }
        else {
            UserDefaults.standard.set(player2.text, forKey: "Winner")
        }
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "EndScreenViewerController") as! EndScreenViewerController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    func hidingElements() {
        self.cardsPlayer1.isHidden = true
        self.cardsPlayer2.isHidden = true
        self.player1.isHidden = true
        self.player2.isHidden = true
        self.score_player1.isHidden = true
        self.score_player2.isHidden = true
        self.pokemon1Name.isHidden = true
        self.pokemon2Name.isHidden = true
    }
    
}

