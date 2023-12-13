//
//  UITextField + Publisher.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/13.
//

import Combine
import UIKit.UITextField

extension UITextField {
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField}
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }
}
