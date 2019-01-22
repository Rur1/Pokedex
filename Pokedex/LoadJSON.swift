//
//  LoadJSON.swift
//  Pokedex
//
//  Created by 瑠璃 on 2018/12/20.
//  Copyright © 2018 瑠璃. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    let no: Int
    let name: String
    let type: [String]!
    let ability: [String]!
    let hiddenAbility: [String]!
    let stats: Stats
    
    struct Stats: Codable {
        let hp: Int
        let attack: Int
        let defence: Int
        let spAttack: Int
        let spDefence: Int
        let speed: Int
    }
    
}

struct Ability: Codable {
    let ability: String
    let effect: String
}

class LoadJSON {
    
    static let loadJSON = LoadJSON();
    var pokemons: [Pokemon]!
    var abilitys: [Ability]!
    
    private init() {
        
    }
    
    func loadPokemonJSON() {
        guard let path = Bundle.main.path(forResource: "pokemon", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        pokemons = try! JSONDecoder().decode([Pokemon].self, from: data)
    }
    
    func loadAbilityJSON() {
        guard let path = Bundle.main.path(forResource: "ability", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        abilitys = try! JSONDecoder().decode([Ability].self, from: data)
    }
    
}
