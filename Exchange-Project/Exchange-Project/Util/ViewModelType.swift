//
//  ViewModelType.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Combine
import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output
}
