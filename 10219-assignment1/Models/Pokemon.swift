//
//  Pokemon.swift
//  10219-assignment1
//
//  Created by Yaniv Ben David on 22/06/2024.
//

import Foundation

class Pokemon {
    
    let strength: Int
    let types: [String]
    let imageName: String
    
    init(strength: Int, types: [String], imageName: String) {
        self.strength = strength
        self.types = types
        self.imageName = imageName
    }
    
    func calculateEffectiveness(attackerTypes: [String], defenderTypes: [String]) -> Double {
        var effectiveness: Double = 1.0
        for atkType in attackerTypes {
            for defType in defenderTypes {
                if let typeEffect = typeEffectiveness[atkType]?[defType] {
                    effectiveness *= typeEffect
                }
            }
        }
        return effectiveness
    }
    
    func comapre(pokemon: Pokemon) -> Int {
        let p1Effectiveness = calculateEffectiveness(attackerTypes: self.types, defenderTypes: pokemon.types)
        let p2Effectiveness = calculateEffectiveness(attackerTypes: pokemon.types, defenderTypes: self.types)
            
        let p1Score = Double(self.strength) * p1Effectiveness
        let p2Score = Double(pokemon.strength) * p2Effectiveness
            
        if p1Score > p2Score {
            return 1
        } else if p2Score > p1Score {
            return -1
        } else {
            return 0
        }
    }
    
    
    
    
}
