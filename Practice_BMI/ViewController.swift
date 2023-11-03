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
    
    var bmi: Double?
    
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
        // bmi 결과값을 뽑아내야함 => 함수제작 사용권장
        
        guard let height = heightTextField.text,
              let weight = weightTextField.text else { return }
        bmi = calculateBMI(height: height, weight: weight)
        // let _ = calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
    }
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "정확한 키와 몸무게를 입력해주세요!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = .black
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController

            // 계산결과 데이터 다음화면으로 전달
            secondVC.bmiNumber = self.bmi
            // 실제로는 secondVC.bmi = bmi 도 가능
            
            secondVC.adviceString = getBMIAdviceString()
            secondVC.bmiColor = getBackgroundColor()
        }
        
        // 다음화면으로 가기전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else { return 0.0 }
        // 계산은 모든 값이 double 임으로 가능함
        var bmi = w / (h * h) * 10000
        // 일반적으로 반올림처리할때 사용하는 코드
        bmi = round(bmi * 10) / 10
        return bmi
    }
    
    
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
         // return UIColor(displayP3Red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        case 18.6..<23.0:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 23.0..<25.0:
            return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case 25.0..<30.0:
            return #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        case 30.0...:
            return #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        default:
            return UIColor.black  // 실수형은 항상 default 문 필요
        }
    }
    
    
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "분석결과가 아직 없어요"}
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return "분석결과가 아직 없어요" // 실수형은 항상 default 문 필요
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    //위처럼 둘다 대리자로 self(UI뷰컨트롤러)를 지정했기 때문에 둘중에 뭐가 입력되든 해당 메서드가 호출됨
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 만약 heightTextField에만 조건을 적용하고 싶다면?
        // if textField == heightTextField 이렇게 감싸면 된다
        if Int(string) != nil || string == "" {
            return true
        }
        return false
        
    }
    
    // 버튼을 누르면 다음 텍스트필드로 넘어가도록
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료
        if heightTextField.text != "", weightTextField.text != "" {
            // 두 텍스트필드 모두 빈 문자열이 아니라면(입력되어있다면)
            textField.resignFirstResponder()
            // textField를 응답객체에서 해제하겠다
            return true // 엔터입력을 허락한다(새로운 글자열로 인식해준다)
            
            // 두번째 텍스트필드로 넘어가도록
        } else if heightTextField.text != "" {
            // (둘다입력된게 아닌상태에서) heightTextField가 빈문자열이 아니라면(입력되어있다면)
            weightTextField.becomeFirstResponder()
            // weightTextField를 응답객체로 사용하겠다
            return true // 엔터입력을 허락한다(새로운 글자열로 인식해준다)
            
        } else  {
            heightTextField.becomeFirstResponder()
            return true // 엔터입력을 허락한다(새로운 글자열로 인식해준다)
        }
        
    }
    
    // 바깥 화면을 클릭하면 키보드가 내려가는 기능
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
