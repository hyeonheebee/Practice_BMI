//
//  BMICalculatorManager.swift
//  Practice_BMI
//
//  Created by 심현희 on 2023/11/05.
//

// cannot find UIColor in scope 에러 해결 // UIKit 내부에는 Foundation 이 이미 포함되어있으므로 별개 import 불필요
import UIKit


struct BMICalculatorManager {
    
    var bmi: Double?
    
    // MARK: - BMI지수를 저장하는 함수
    // 구조체로 만들었으니 내부 메서드에서 저장속성을 (여기서는 bmi) 바꿔주는 경우 mutating 키워드필요
    mutating func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = 0.0
            return  // 가드문은 반드시 else 에  return 필요
        }
        // 계산은 모든 값이 double 임으로 가능함
        let bmiNumber = w / (h * h) * 10000
        // 일반적으로 반올림처리할때 사용하는 코드
        bmi = round(bmiNumber * 10) / 10
    }
    
    
    // 계산된 bmi 값을 제공해줌
    func getBMIResult() -> Double {
        // 약간의 트릭 Double? 을 리턴을 안하는 대신 닐코얼리싱으로 기본값을 설정해줌 
        return bmi ?? 0.0
    }
    
    
    // MARK: - BMI지수에 따른 label 배경색상을 패턴매칭하는 함수
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
    
    
    // MARK: - BMI지수에 따른 label 조언 문자열을 패턴매칭하는 함수
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
