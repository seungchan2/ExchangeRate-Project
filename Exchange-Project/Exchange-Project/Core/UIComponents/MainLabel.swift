//
//  MainLabel.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/17.
//

import UIKit.UILabel

final class MainLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
