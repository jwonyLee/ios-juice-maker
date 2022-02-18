//
//  UpdateStockViewController.swift
//  JuiceMaker
//
//  Created by 박형석 on 2022/02/16.
//

import UIKit

final class UpdateStockViewController: UIViewController, StoryboardBindable {
    // MARK: - Views
    @IBOutlet weak var strawberryStockLabel: UILabel!
    @IBOutlet weak var bananaStockLabel: UILabel!
    @IBOutlet weak var pineappleStockLabel: UILabel!
    @IBOutlet weak var kiwiStockLabel: UILabel!
    @IBOutlet weak var mangoStockLabel: UILabel!
    
    @IBOutlet weak var strawberryStockStepper: UIStepper!
    @IBOutlet weak var bananaStockStepper: UIStepper!
    @IBOutlet weak var pineappleStockStepper: UIStepper!
    @IBOutlet weak var kiwiStockStepper: UIStepper!
    @IBOutlet weak var mangoStockStepper: UIStepper!
    

    var fruitStore: FruitStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupStepper()
        self.setupFruitStock()
    }
    
    @IBAction func chageStockSteppers(_ sender: UIStepper) {
        print(sender.value)
    }
    
}

// MARK: - Setup
extension UpdateStockViewController {
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationItem.title = "재고 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "닫기",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(back))
    }

    @objc
    private func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupStepper() {
        guard let fruitStore: FruitStore = self.fruitStore else {
            return
        }
        self.strawberryStockStepper.value = Double(fruitStore.fruits[.strawberry]?.value ?? 0)
        self.bananaStockStepper.value = Double(fruitStore.fruits[.banana]?.value ?? 0)
        self.pineappleStockStepper.value = Double(fruitStore.fruits[.pineapple]?.value ?? 0)
        self.kiwiStockStepper.value = Double(fruitStore.fruits[.kiwi]?.value ?? 0)
        self.mangoStockStepper.value = Double(fruitStore.fruits[.mango]?.value ?? 0)
    }
    
    private func setupFruitStock() {
        guard let fruitStore: FruitStore = self.fruitStore else {
            return
        }
        DispatchQueue.main.async {
            self.strawberryStockLabel.text = "\(fruitStore.fruits[.strawberry, default: Number()])"
            self.bananaStockLabel.text = "\(fruitStore.fruits[.banana, default: Number()])"
            self.pineappleStockLabel.text = "\(fruitStore.fruits[.pineapple, default: Number()])"
            self.kiwiStockLabel.text = "\(fruitStore.fruits[.kiwi, default: Number()])"
            self.mangoStockLabel.text = "\(fruitStore.fruits[.mango, default: Number()])"
        }
    }
}
