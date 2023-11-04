//
//  BMICalculatorManager.swift
//  Practice_BMI
//
//  Created by 심현희 on 2023/11/05.
//

// cannot find UIColor in scope 에러 해결 // UIKit 내부에는 Foundation 이 이미 포함되어있으므로 별개 import 불필요
import UIKit


// 구조체의 역할
// bmi 와 관련된 모든 계산행위를 하는 구조체
// 클래스로 생성해도 상관없음(mutating 차이)
// 큰 프로젝트의 경우 단 heap 에 저장되는게 좋음 (비즈니스 로직의 경우) => 여러모델이 접근하기 때문
// 현재 프로젝트는 하나의 뷰 컨트롤러만 접근중이므로 구조체 가능

struct BMICalculatorManager {
    
    // private 으로 접근제어 함
    // 외부에서 바로 접근 불가능 
    private var bmi: BMI?
    
    
    // 계산된 bmi 값을 제공해줌 // bmi 계산된 값을 얻어내는 내부로직 포함
    mutating func getBMIResult(height: String, weight: String) -> BMI {
        // 약간의 트릭 Double? 을 리턴을 안하는 대신 닐코얼리싱으로 기본값을 설정해줌
        
        // BMI 계산하는 함수를 호출
        calculateBMI(height: height, weight: weight)
        return bmi ?? BMI(value: 0.0, matchColor: .white, advice: "문제발생")
    }
    
    
    // MARK: - BMI 계산하는 함수
    // 구조체로 만들었으니 내부 메서드에서 저장속성을 (여기서는 bmi) 바꿔주는 경우 mutating 키워드필요
    
    //문자열 두개를 얻어서 계산하는 함수
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, matchColor: .white, advice: "문제발생")
            return  // 가드문은 반드시 else 에  return 필요
        }
        // 계산은 모든 값이 double 임으로 가능함
        var bmiNumber = w / (h * h) * 10000
        // 일반적으로 반올림처리할때 사용하는 코드
        bmiNumber = round(bmiNumber * 10) / 10
        
        // 기존 메서드 합치기
        // 스위치문을 통해 패턴매칭 후 패턴마다 적절한 초기값을 셋팅하여 memberwise init을 통해 bmi 인스턴스를 찍어냄
        switch bmiNumber {
        case ..<18.6:
            let color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            bmi = BMI(value: bmiNumber, matchColor: color, advice: "저체중")
         // let color = UIColor(displayP3Red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        case 18.6..<23.0:
            let color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            bmi = BMI(value: bmiNumber, matchColor: color, advice: "표준")
        case 23.0..<25.0:
            let color = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            bmi = BMI(value: bmiNumber, matchColor: color, advice: "과체중")
        case 25.0..<30.0:
            let color = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            bmi = BMI(value: bmiNumber, matchColor: color, advice: "중도비만")
        case 30.0...:
            let color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            bmi = BMI(value: bmiNumber, matchColor: color, advice: "고도비만")
        default:
            let color = UIColor.black  // 실수형은 항상 default 문 필요
            bmi = BMI(value: bmiNumber, matchColor: color, advice: "분석결과가 아직 없어요")
        }
        
        
    }
    
    
    
    
}
