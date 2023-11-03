//
//  SecondViewController.swift
//  Practice_BMI
//
//  Created by 심현희 on 2023/11/03.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 아예 구조체같은 것으로 묶어서 전달도 가능 
    var bmiNumber: Double?
    var bmiColor: UIColor?
    var adviceString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    func makeUI() {
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 8
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 10
        bmiNumberLabel.backgroundColor = .gray
        
        // 옵셔널벗겨서 구현 
        guard let bmi = bmiNumber else { return }
        bmiNumberLabel.text = String(bmi)
        
        // adviceLabel.text 와 backgroundColor 가 이미 옵셔널타입이라서 벗겨줄 필요없음
        adviceLabel.text = adviceString
        
        bmiNumberLabel.backgroundColor = bmiColor
        
        backButton.setTitle("다시 계산하기", for: .normal)
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        // self.dismiss(animated: true, completion: nil) 와 같은의미
    }
    
}
