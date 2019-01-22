//
//  StatsViewController.swift
//  Pokedex
//
//  Created by 瑠璃 on 2018/12/16.
//  Copyright © 2018 瑠璃. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var typeLabels: [UILabel]!
    @IBOutlet var abilityButtons: [UIButton]!
    @IBOutlet var hpLabel: UILabel!
    @IBOutlet var attackLabel: UILabel!
    @IBOutlet var defenceLabel: UILabel!
    @IBOutlet var spAttackLabel: UILabel!
    @IBOutlet var spDefenceLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    
    let loadJSON = LoadJSON.loadJSON
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSON.loadAbilityJSON()
        
        guard let obj = UserDefaults.standard.object(forKey: "nameLabel") else { return }
        let name = obj as! String
        navigationItem.title = name
        for i in 0 ..< loadJSON.pokemons.count {
            if (name != loadJSON.pokemons[i].name) {
                continue
            }
            imageView.image = UIImage(named: loadJSON.pokemons[i].name)
            for j in 0 ..< loadJSON.pokemons[i].type.count {
                typeLabels[j].text = loadJSON.pokemons[i].type[j]
                typeLabels[j].sizeToFit()
            }
            for j in 0 ..< loadJSON.pokemons[i].ability.count {
                abilityButtons[j].setTitle(loadJSON.pokemons[i].ability[j], for: .normal)
                abilityButtons[j].sizeToFit()
            }
            abilityButtons[2].setTitle(loadJSON.pokemons[i].hiddenAbility[0], for: .normal)
            abilityButtons[2].sizeToFit()
            hpLabel.text = "HP\n" + loadJSON.pokemons[i].stats.hp.description
            attackLabel.text = "攻撃\n" + loadJSON.pokemons[i].stats.attack.description
            defenceLabel.text = "防御\n" + loadJSON.pokemons[i].stats.defence.description
            spAttackLabel.text = "特攻\n" + loadJSON.pokemons[i].stats.spAttack.description
            spDefenceLabel.text = "特防\n" + loadJSON.pokemons[i].stats.spDefence.description
            speedLabel.text = "素早さ\n" + loadJSON.pokemons[i].stats.speed.description
        }
    }
    
    @IBAction func touch(_ sender: UIButton) {
        var effect = ""
        for i in 0 ..< loadJSON.abilitys.count {
            if sender.currentTitle == loadJSON.abilitys[i].ability {
                effect = loadJSON.abilitys[i].effect
                break
            }
        }
        let alert = UIAlertController(title: sender.currentTitle, message: effect, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "閉じる", style: .default)
        alert.addAction(defaultAction)
        present(alert, animated: true)
    }
    
}
