//
//  ToastError.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/17.
//

import Foundation

@frozen
enum ToastError {
    case lessZero
    case overTenThousands
    
    var error: String {
        switch self {
        case .lessZero:
            return "0 USD보다 작은 금액은 송금할 수 없습니다."
        case .overTenThousands:
            return "10,000 USD보다 큰 금액은 송금할 수 없습니다."
        }
    }
}
