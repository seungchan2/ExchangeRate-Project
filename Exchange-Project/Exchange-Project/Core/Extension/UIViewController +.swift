//
//  UIViewController +.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/14.
//

import UIKit.UIViewController

extension UIViewController {
    func showToast(message: ToastError, duration: TimeInterval = 2.0) {
        let toastView = ToastView()
        toastView.showMessage(message.error)

        view.addSubview(toastView)
        toastView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])

        UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: { _ in
            toastView.removeFromSuperview()
        })
    }
}
