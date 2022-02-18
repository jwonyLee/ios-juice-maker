//
//  JuiceMakerViewController.swift
//  JuiceMaker
//
//  Created by 박형석 on 2022/02/16.
//

import UIKit

final class JuiceMakerViewController: UIViewController {
    // MARK: - Views
    @IBOutlet weak var strawberryStockLabel: UILabel!
    @IBOutlet weak var bananaStockLabel: UILabel!
    @IBOutlet weak var pineappleStockLabel: UILabel!
    @IBOutlet weak var kiwiStockLabel: UILabel!
    @IBOutlet weak var mangoStockLabel: UILabel!
    
    // MARK: - Properties
    private let fruitStore: FruitStore = FruitStore()
    private lazy var juiceMaker: JuiceMaker = JuiceMaker(fruitStore: self.fruitStore)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateFruitStock()
    }
    
    @IBAction func presentUpdateStockScene() {
        let updateStockViewController: UpdateStockViewController = .instantiate()
        updateStockViewController.fruitStore = self.fruitStore
        let navigationController: UINavigationController = UINavigationController(rootViewController: updateStockViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func orderJuice(_ sender: UIButton) {
        guard let juice: Juice = Juice(rawValue: sender.tag) else {
            return
        }
        
        do {
            let result: String = try self.juiceMaker.makeJuice(juice)
            self.updateFruitStock()
            self.showSuccessAlert(message: result)
        } catch {
            self.showFailAlert()
        }
    }
    
    private func showSuccessAlert(message: String) {
        let alert: UIAlertController = UIAlertController(title: "제조 완료",
                                                         message: message,
                                                         preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "확인",
                                                    style: .default,
                                                    handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showFailAlert() {
        let alert: UIAlertController = UIAlertController(title: "제조 실패",
                                                         message: "재료가 모자라요. 재고를 수정할까요?",
                                                         preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "예",
                                                    style: .default) { _ in
            self.presentUpdateStockScene()
        }
        let cancleAction: UIAlertAction = UIAlertAction(title: "아니오",
                                                        style: .default,
                                                        handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup
extension JuiceMakerViewController {
    private func updateFruitStock() {
        DispatchQueue.main.async {
            self.strawberryStockLabel.text = "\(self.fruitStore.fruits[.strawberry, default: 0])"
            self.bananaStockLabel.text = "\(self.fruitStore.fruits[.banana, default: 0])"
            self.pineappleStockLabel.text = "\(self.fruitStore.fruits[.pineapple, default: 0])"
            self.kiwiStockLabel.text = "\(self.fruitStore.fruits[.kiwi, default: 0])"
            self.mangoStockLabel.text = "\(self.fruitStore.fruits[.mango, default: 0])"
        }
    }
}
