//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

class FruitStore {
    private(set) var fruitQuantity: Dictionary<Fruit, Int> = Dictionary(uniqueKeys: Fruit.allCases, repeating: 10)
        
    func changeQuantity(of fruit: Fruit, count: Int, do operation: (Int, Int) -> Int) {
        guard let stock = fruitQuantity[fruit] else {
            return
        }
        fruitQuantity[fruit] = operation(stock, count)
    }
}

extension Dictionary {
    init<T>(uniqueKeys: T, repeating value: Value) where T: Collection, T.Element == Key {
        self = Dictionary(uniqueKeysWithValues: zip(uniqueKeys, Array(repeating: value, count: uniqueKeys.count)))
    }
}
