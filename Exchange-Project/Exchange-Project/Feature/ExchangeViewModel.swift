//
//  ExchangeViewModel.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Combine
import Foundation

final class ExchangeViewModel: ViewModelType {
    private var networkProvider: ExchangeRateServiceType
    private var cancelBag = CancelBag()
    
    init(networkProvider: ExchangeRateServiceType) {
        self.networkProvider = networkProvider
    }
    
    struct Input {}
    
    struct Output {}
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
       
        return output
    }
}
