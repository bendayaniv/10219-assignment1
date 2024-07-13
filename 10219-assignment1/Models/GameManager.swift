//
//  GameManager.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 22/06/2024.
//

import Foundation

class GameManager {
    
    var pokemons: [Pokemon]
    var player1: Player
    var player2: Player
    var firstTurn: Bool
    var waitingPokemons = [Pokemon]()
    
    init() {
        
        self.pokemons = [
            Pokemon(strength: 10, types: ["Psychich"], imageName: "Abra"),
            Pokemon(strength: 35, types: ["Bug", "Poison"], imageName: "Beedril"),
            Pokemon(strength: 95, types: ["Water"], imageName: "Blastoise"),
            Pokemon(strength: 50, types: ["Grass", "Poisom"], imageName: "Bulbasaur"),
            Pokemon(strength: 40, types: ["Bug", "Flying"], imageName: "Butterfree"),
            Pokemon(strength: 95, types: ["Fire","Flying"], imageName: "Charizard"),
            Pokemon(strength: 45, types: ["Fire"], imageName: "Charmander"),
            Pokemon(strength: 75, types: ["Fire"], imageName: "Charmeleon"),
            Pokemon(strength: 30, types: ["Grass"], imageName: "Chicorita"),
            Pokemon(strength: 35, types: ["Ground"], imageName: "Cubone"),
            Pokemon(strength: 75, types: ["Ground"], imageName: "Dugtrio"),
            Pokemon(strength: 35, types: ["Normal"], imageName: "Eevee"),
            Pokemon(strength: 70, types: ["Fire"], imageName: "Flareon"),
            Pokemon(strength: 95, types: ["Water", "Flying"], imageName: "Gyarados"),
            Pokemon(strength: 75, types: ["Grass", "Poison"], imageName: "Ivysaur"),
            Pokemon(strength: 20, types: ["Normal", "Fairy"], imageName: "Jigglypuff"),
            Pokemon(strength: 70, types: ["Electric"], imageName: "Jolteon"),
            Pokemon(strength: 80, types: ["Fighting"], imageName: "Machamp"),
            Pokemon(strength: 35, types: ["Water", "Fairy"], imageName: "Maril"),
            Pokemon(strength: 75, types: ["Fire"], imageName: "Ninetails"),
            Pokemon(strength: 10, types: ["Grass", "Poison"], imageName: "Oddish"),
            Pokemon(strength: 45, types: ["Ground"], imageName: "Phanpy"),
            Pokemon(strength: 85, types: ["Normal", "Flying"], imageName: "Pidgeot"),
            Pokemon(strength: 70, types: ["Normal", "Flying"], imageName: "Pidgeotto"),
            Pokemon(strength: 15, types: ["Normal", "Flying"], imageName: "Pidgey"),
            Pokemon(strength: 70, types: ["Electric"], imageName: "Pikachu"),
            Pokemon(strength: 35, types: ["Water"], imageName: "Psyduck"),
            Pokemon(strength: 65, types: ["Fire"], imageName: "Quilava"),
            Pokemon(strength: 75, types: ["Bug", "Flying"], imageName: "Scyther"),
            Pokemon(strength: 15, types: ["Normal", "Flying"], imageName: "Spearow"),
            Pokemon(strength: 65, types: ["Water"], imageName: "Squirtle"),
            Pokemon(strength: 85, types: ["Steel", "Ground"], imageName: "Steelix"),
            Pokemon(strength: 30, types: ["Fire"], imageName: "Torchic"),
            Pokemon(strength: 50, types: ["Water"], imageName: "Totodile"),
            Pokemon(strength: 70, types: ["Water"], imageName: "Vapereon"),
            Pokemon(strength: 30, types: ["Bug", "Poison"], imageName: "Venemoth"),
            Pokemon(strength: 90, types: ["Grass", "Poison"], imageName: "Venusaur"),
            Pokemon(strength: 30, types: ["Electric"], imageName: "Voltorb"),
            Pokemon(strength: 30, types: ["Fire"], imageName: "Vulpix"),
            Pokemon(strength: 10, types: ["Bug", "Poison"], imageName: "Weedle"),
            
            
            
        ]
        self.pokemons.shuffle()
        let quarterPokemons = self.pokemons.count / 8
        
        
        self.player1 = Player(name: "Player 1", pokemons: Array(self.pokemons[0..<quarterPokemons]))
        self.player2 = Player(name: "Player 2", pokemons: Array(self.pokemons[quarterPokemons..<self.pokemons.count / 4]))
        
        self.firstTurn = true
    }
    
    func newGame() {
        self.pokemons.shuffle()
        let quarterPokemons = self.pokemons.count / 8
        
        
        self.player1 = Player(name: "Player 1", pokemons: Array(self.pokemons[0..<quarterPokemons]))
        self.player2 = Player(name: "Player 2", pokemons: Array(self.pokemons[quarterPokemons..<self.pokemons.count / 4]))
        
        self.firstTurn = true
    }
    
    
    func checkingGameOver(scorePlayer1: String, scorePlayer2: String) -> Bool {
        return scorePlayer1 == "0" || scorePlayer2 == "0"
    }
    
    func checkingWinner() -> String {
        if self.player1.pokemons.count == 0 {
            self.player2.addPokemons(pokemons: pokemons)
            return self.player2.name
        }
        else {
            self.player1.addPokemons(pokemons: pokemons)
            return self.player1.name
        }
    }
    
}
