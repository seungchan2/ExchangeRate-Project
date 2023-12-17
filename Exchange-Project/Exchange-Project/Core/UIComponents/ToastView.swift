//
//  ToastView.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/14.
//

import UIKit

final class ToastView: UIView {
    private var style: ToastError
    private let label = UILabel()
    
    init(style: ToastError = ToastError.lessZero) {
        self.style = style
        super.init(frame: .zero)
        setupView()
        print("ToastView init")
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ToastView deinit")
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func showMessage(_ message: String) {
        label.text = message
    }
}
