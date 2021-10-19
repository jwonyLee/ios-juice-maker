//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

struct JuiceMaker {
    fileprivate typealias Recipe = [FruitStore.Fruit: Int]
    
    let store: FruitStore = FruitStore()
    
    enum Juice {
        case strawberryJuice
        case bananaJuice
        case kiwiJuice
        case pineappleJuice
        case strawberryAndBananaJuice
        case mangoJuice
        case mangoKiwiJuice
        
        fileprivate var recipe: Recipe {
            switch self {
            case .strawberryJuice:
                return [.strawberry: 16]
            case .bananaJuice:
                return [.banana: 2]
            case .kiwiJuice:
                return [.kiwi: 3]
            case .pineappleJuice:
                return [.pineapple: 2]
            case .strawberryAndBananaJuice:
                return [.strawberry: 10, .banana: 1]
            case .mangoJuice:
                return [.mango: 3]
            case .mangoKiwiJuice:
                return [.mango: 2, .kiwi: 1]
            }
        }
    }
    
    private func canMakeJuice(requiredRecipe: Recipe) -> Bool {
        let availableRecipe = requiredRecipe.filter {
            store.checkEnoughStock(of: $0.key, requiredAmount: $0.value)
        }
        
        guard availableRecipe.count == requiredRecipe.count else {
            return false
        }
        
        return true
    }
    
    func makeJuice(juice: Juice) throws {
        let recipe = juice.recipe
        
        guard canMakeJuice(requiredRecipe: recipe) else {
            throw JuiceMakeError.notEnoughStock
        }
        
        for (fruit, amount) in recipe {
            try store.subtractStock(of: fruit, by: amount)
        }
    }
}
