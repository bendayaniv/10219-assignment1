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
        
        changeScores()
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
    }
    
    @objc func updateUI() {
        
    }
    
    @objc func runningTimer() {
        if gameManager.checkingGameOver() {
            timer?.invalidate()
            timer = nil
            checkingWinner()
        }
        else {
            next()
        }
//        next()
    }
    
    func changeScores() -> Void {
        score_player1.text = String(gameManager.player1.pokemons.count)
        score_player2.text = String(gameManager.player2.pokemons.count)
    }

    @IBAction func buttonClick(_ sender: UIButton) {
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
        
        image1.image = UIImage(named: player1Pokemon.imageName)
        image2.image = UIImage(named: player2Pokemon.imageName)
        pokemon1Name.text = player1Pokemon.imageName
        pokemon2Name.text = player2Pokemon.imageName
        
        pokemons.append(player1Pokemon)
        pokemons.append(player2Pokemon)
        
        
    }
    
    func checkingWinner() {
        self.button.isHidden = true
        hidingLabels()
        if gameManager.player1.pokemons.count == 0 {
            self.image1.isHidden = true
            gameManager.player2.addPokemons(pokemons: pokemons)
            winnerAnnouncer.text = "\(self.gameManager.player2.name) is the winner"
        }
        else {
            self.image2.isHidden = true
            gameManager.player1.addPokemons(pokemons: pokemons)
            winnerAnnouncer.text = "\(self.gameManager.player1.name) is the winner"
        }
        changeScores()
    }
    
    func hidingLabels() {
        label1.isHidden = true
        label2.isHidden = true
        score_player1.isHidden = true
        score_player2.isHidden = true
        pokemon1Name.isHidden = true
        pokemon2Name.isHidden = true
    }
    
}

