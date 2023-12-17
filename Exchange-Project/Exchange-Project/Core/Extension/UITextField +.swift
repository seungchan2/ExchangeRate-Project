//
//  UITextField +.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/17.
//

import UIKit.UITextField

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
    leftView = paddingView
    leftViewMode = ViewMode.always
  }
}
