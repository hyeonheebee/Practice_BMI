//
//  ViewController.swift
//  Practice_BMI
//
//  Created by 심현희 on 2023/11/01.
//
// 함수는 하나의 함수에 한 기능인 것을 지향하자


import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calcutateButton: UIButton!
    
    
    
    // controller 와 model(BMICalculatorManager)의 의사소통을 위한 변수선언, 구조체 인스턴스 생성
    var bmiManager = BMICalculatorManager()
    
    
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
    
    
    // MARK: - 계산하기 버튼이 눌릴때 실행되는 함수
    // 어차피 버튼이 눌리면 내부적으로 souldPerformSegue 가 호출되고 기존에 데이터를 계산하는 매니저를 호출하던 기능은 prepare가 가저감
    // 내부로직 필요없음
    @IBAction func calcutateButtonTapped(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    // MARK: - 세그웨이 실행여부를 판단하는 함수
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
    
    
    // MARK: - 💡데이터전달 메서드(직접세그웨이 이므로 shouldPerformSegue 가 true 일때 자동으로 호출됨)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController

            // 계산결과 데이터 다음화면으로 전달
            guard let height = heightTextField.text,
                  let weight = weightTextField.text else { return }
            // bmiManager.bmi // 불가능함 (private)
            // 계산하라고 데이터를 전달해주는 코드
            // bmi에 간접적으로 접근할 수 있는 매서드를 호출하고 결과값을 담는 역할 (직접적으로 접근하는 것은 private 제어걸려서 불가능)
            secondVC.bmi = bmiManager.getBMIResult(height: height, weight: weight)
            // let _ = gbmiManager.etBMIResult(height: heightTextField.text!, weight: weightTextField.text!)
            
        }
        
        // 다음화면으로 가기전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
    
}


// MARK: - 텍스트필드 관련 UI 구현을 위해 델리게이트 패턴 구현
extension ViewController: UITextFieldDelegate {
    
    
    // MARK: - 텍스트필드에 입력이 될때마다 실행되는 함수
    //위처럼 둘다 대리자로 self(UI뷰컨트롤러)를 지정했기 때문에 둘중에 뭐가 입력되든 해당 메서드가 호출됨
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 만약 heightTextField에만 조건을 적용하고 싶다면?
        // if textField == heightTextField 이렇게 감싸면 된다
        if Int(string) != nil || string == "" {
            return true
        }
        return false
        
    }
    
    
    // MARK: - 엔터키를 눌렀을때 행동 및 엔터키동작 허락여부 함수
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
    
    
    // MARK: - 바깥화면 클릭시 키보드 내리기
    // 바깥 화면을 클릭하면 키보드가 내려가는 기능
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
