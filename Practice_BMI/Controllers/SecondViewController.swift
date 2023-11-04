//
//  SecondViewController.swift
//  Practice_BMI
//
//  Created by 심현희 on 2023/11/03.
//
// 두번째 화면에서는 굳이 비즈니스로직을 따로 분리할필요 없음(모델을 분리할 필요 없음) 
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 아예 구조체같은 것으로 묶어서 전달도 가능
    
    var bmi: BMI?

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
        // 그냥 bmiNumberLabel.text = "\(bmi?.value)" 의 경우 옵셔널로 라벨에 표시됨
        guard let bmiNumber = bmi?.value else { return }
        bmiNumberLabel.text = String(bmiNumber)
        
        // 옵셔널 언래핑 안해도 되는 이유
        // adviceLabel.text 와 backgroundColor 가 이미 옵셔널타입이라서 벗겨줄 필요없음
        adviceLabel.text = bmi?.advice
        
        bmiNumberLabel.backgroundColor = bmi?.matchColor
        
        /*💡
         이렇게도 가능
         guard let bmi = bmi else { return }
         
         //💡 어차피 양쪽 모두 옵셔널 이므로 옵셔널 체이닝 불필요한 경우(바로 밑 코드한줄)
         bmiNumberLabel.text = String(bmi.value)
        // bmi 자체는 옵셔널이 아니지만 String 화 하면서 옵셔널이 됨 => bmi.value 는 옵셔널이 아니지만 String(bmi.value)는 옵셔널임
        
        // 밑에는 왼쪽은 옵셔널, 오른쪽은 옵셔널이 아닌코드이므로 담을 수 있음
         adviceLabel.text = bmi.advice
         bmiNumberLabel.backgroundColor = bmi.matchColor

         */
        
        backButton.setTitle("다시 계산하기", for: .normal)
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        // self.dismiss(animated: true, completion: nil) 와 같은의미
    }
    
}
