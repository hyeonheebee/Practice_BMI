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
    
    var bmi: Double?
    
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
        guard let bmi = bmi else { return }
        bmiNumberLabel.text = String(bmi)
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        // self.dismiss(animated: true, completion: nil) 와 같은의미
    }
    
}
