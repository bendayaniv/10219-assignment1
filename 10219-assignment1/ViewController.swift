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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        image1.image = UIImage(named: "back")
        image2.image = UIImage(named: "back")
        
        label1.text = "Player I"
        label2.text = "Player II"
        
        pokemon1Name.text = ""
        pokemon2Name.text = ""
        winnerAnnouncer.text = ""
        
        changeScores()
    }
    
    func changeScores() -> Void {
        score_player1.text = String(gameManager.player1.pokemons.count)
        score_player2.text = String(gameManager.player2.pokemons.count)
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        next()
    }
    
    //todo - moving this to GameManager
    func next() {
        if !self.firstTurn {
            let result = self.pokemons[self.pokemons.count - 2].comapre(pokemon: self.pokemons[self.pokemons.count - 1])
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
                    
            if gameManager.checkingGameOver() {
                self.button.isHidden = true
                if gameManager.player1.pokemons.count == 0 {
                    self.image2.isHidden = true
                    winnerAnnouncer.text = "\(self.gameManager.player1.name) is the winner"
                }
                else {
                    self.image1.isHidden = true
                    winnerAnnouncer.text = "\(self.gameManager.player1.name) is the winner"
                }
            }
        }
        else {
            self.firstTurn = false
        }
        
        image1.image = UIImage(named: gameManager.player1.getPokemonName())
        image2.image = UIImage(named: gameManager.player2.getPokemonName())
        pokemon1Name.text = gameManager.player1.getPokemonName()
        pokemon2Name.text = gameManager.player2.getPokemonName()
                
        let player1Pokemon = gameManager.player1.getPokemon()
        let player2Pokemon = gameManager.player2.getPokemon()
        
        pokemons.append(player1Pokemon)
        pokemons.append(player2Pokemon)
        
        
    }
    
}

