//
//  ViewController.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 22/06/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var pokemon1: UIImageView!
    
    @IBOutlet weak var pokemon2: UIImageView!
    
    @IBOutlet weak var score_player1: UILabel!
    
    @IBOutlet weak var score_player2: UILabel!
        
    @IBOutlet weak var pokemon1Name: UILabel!
    
    @IBOutlet weak var pokemon2Name: UILabel!
    
    @IBOutlet weak var winnerAnnouncer: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var gameManager = GameManager()
    
    var pokemons = [Pokemon]()
    
    var firstTurn = true
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        image1.image = UIImage(named: "back")
        image2.image = UIImage(named: "back")
        
        label1.text = "Player I"
        label2.text = "Player II"
        
        button.setTitle("Start Fight", for: .normal)
        
        pokemon1Name.text = ""
        pokemon2Name.text = ""
        winnerAnnouncer.text = ""
        
        self.button.setTitle("Start Fighting", for: .normal)
        
        changeScores()
        
//        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
    }
    
//    @objc func updateUI() {
//        
//    }
    
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
        self.button.isHidden = true
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
        self.button.isHidden = false
        self.button.setTitle("Fight Again", for: .normal)
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
        self.image1.isHidden = true
        self.image2.isHidden = true
        self.label1.isHidden = true
        self.label2.isHidden = true
        self.score_player1.isHidden = true
        self.score_player2.isHidden = true
        self.pokemon1Name.isHidden = true
        self.pokemon2Name.isHidden = true
    }
    
}

