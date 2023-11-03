//
//  ViewController.swift
//  Practice_BMI
//
//  Created by 심현희 on 2023/11/01.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calcutateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()

    }

    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        // UI컨트롤러와 텍스트필드는 따로 존재 => 해당 텍스트필드들의 대리자로 UI컨트롤러를 설정해줌
        mainLabel.text = "키와 몸무게를 입력해주세요"
        calcutateButton.layer.cornerRadius = 8
        calcutateButton.clipsToBounds = true
        
        calcutateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
        
    }
    @IBAction func calcutateButtonTapped(_ sender: UIButton) {
        
        
    }
    

}

extension ViewController: UITextFieldDelegate {
    
    
    
}
