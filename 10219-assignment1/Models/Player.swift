//
//  Player.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 22/06/2024.
//

import Foundation

class Player {
    
    var name: String
    var pokemons: [Pokemon]
    
    init(name: String, pokemons: [Pokemon]) {
        self.name = name
        self.pokemons = pokemons
        self.pokemons.shuffle()
    }
    
    func getPokemon() -> Pokemon {
        let pokemon = self.pokemons.removeFirst()
        return pokemon
    }
    
    func addPokemons(pokemons: [Pokemon]) {
        self.pokemons.append(contentsOf: pokemons)
    }
    
    func getNumOfPokemons() -> Int {
        return self.pokemons.count
    }
    
    func getPokemonName() -> String {
        return self.pokemons[0].imageName
    }
}
