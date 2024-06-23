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
            Pokemon(strength: 4, types: ["Psychich"], imageName: "Abra"),
            Pokemon(strength: 5, types: ["Bug", "Poison"], imageName: "Beedrill"),
            Pokemon(strength: 8, types: ["Water"], imageName: "Blastoise"),
            Pokemon(strength: 5, types: ["Grass", "Poisom"], imageName: "Bulbasaur"),
            Pokemon(strength: 4, types: ["Bug", "Flying"], imageName: "Butterfree"),
            Pokemon(strength: 8, types: ["Fire","Flying"], imageName: "Charizard"),
            Pokemon(strength: 6, types: ["Fire"], imageName: "Charmander"),
            Pokemon(strength: 7, types: ["Fire"], imageName: "Charmeleon"),
            Pokemon(strength: 4, types: ["Grass"], imageName: "Chicorita"),
            Pokemon(strength: 5, types: ["Ground"], imageName: "Cubone"),
            Pokemon(strength: 6, types: ["Ground"], imageName: "Dugtrio"),
            Pokemon(strength: 6, types: ["Normal"], imageName: "Eevee"),
            Pokemon(strength: 7, types: ["Fire"], imageName: "Flareon"),
            Pokemon(strength: 8, types: ["Water", "Flying"], imageName: "Gyarados"),
            Pokemon(strength: 6, types: ["Grass", "Poison"], imageName: "Ivysaur"),
            Pokemon(strength: 5, types: ["Normal", "Fairy"], imageName: "Jigglypuff"),
            Pokemon(strength: 8, types: ["Electric"], imageName: "Jolteon"),
            Pokemon(strength: 8, types: ["Fighting"], imageName: "Machamp"),
            Pokemon(strength: 6, types: ["Water", "Fairy"], imageName: "Maril"),
            Pokemon(strength: 7, types: ["Fire"], imageName: "Ninetales"),
            Pokemon(strength: 4, types: ["Grass", "Poison"], imageName: "Oddish"),
            Pokemon(strength: 5, types: ["Ground"], imageName: "Phanpy"),
            Pokemon(strength: 7, types: ["Normal", "Flying"], imageName: "Pidgeot"),
            Pokemon(strength: 6, types: ["Normal", "Flying"], imageName: "Pidgeotto"),
            Pokemon(strength: 5, types: ["Normal", "Flying"], imageName: "Pidgey"),
            Pokemon(strength: 7, types: ["Electric"], imageName: "Pikachu"),
            Pokemon(strength: 5, types: ["Water"], imageName: "Psyduck"),
            Pokemon(strength: 6, types: ["Fire"], imageName: "Quilava"),
            Pokemon(strength: 7, types: ["Bug", "Flying"], imageName: "Scyther"),
            Pokemon(strength: 4, types: ["Normal", "Flying"], imageName: "Spearow"),
            Pokemon(strength: 6, types: ["Water"], imageName: "Squirtle"),
            Pokemon(strength: 8, types: ["Steel", "Ground"], imageName: "Steelix"),
            Pokemon(strength: 5, types: ["Fire"], imageName: "Torchic"),
            Pokemon(strength: 5, types: ["Water"], imageName: "Totodile"),
            Pokemon(strength: 7, types: ["Water"], imageName: "Vaporeon"),
            Pokemon(strength: 6, types: ["Bug", "Poison"], imageName: "Venomoth"),
            Pokemon(strength: 7, types: ["Grass", "Poison"], imageName: "Venusaur"),
            Pokemon(strength: 4, types: ["Electric"], imageName: "Voltorb"),
            Pokemon(strength: 5, types: ["Fire"], imageName: "Vulpix"),
            Pokemon(strength: 3, types: ["Bug", "Poison"], imageName: "Weedle"),
            
            
            
        ]
        self.pokemons.shuffle()
        let quarterPokemons = self.pokemons.count / 8
        
        
        self.player1 = Player(name: "Player 1", pokemons: Array(self.pokemons[0..<quarterPokemons]))
        self.player2 = Player(name: "Player 2", pokemons: Array(self.pokemons[quarterPokemons..<self.pokemons.count / 4]))
        
        self.firstTurn = true
    }
    
    func next() {
        
    }
    
    func newGame() {
        self.pokemons.shuffle()
        let quarterPokemons = self.pokemons.count / 8
        
        
        self.player1 = Player(name: "Player 1", pokemons: Array(self.pokemons[0..<quarterPokemons]))
        self.player2 = Player(name: "Player 2", pokemons: Array(self.pokemons[quarterPokemons..<self.pokemons.count / 4]))
        
        self.firstTurn = true
    }
    
    
    func checkingGameOver() -> Bool {
        return self.player1.pokemons.count == 0 || self.player2.pokemons.count == 0
    }
    
    func checkingWinner() -> String {
        if self.player1.pokemons.count == 0 {
            self.player2.addPokemons(pokemons: pokemons)
            return "\(self.self.player2.name) is the winner"
        }
        else {
            self.player1.addPokemons(pokemons: pokemons)
            return "\(self.player1.name) is the winner"
        }
    }
    
}
