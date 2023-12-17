//
//  Date +.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/17.
//

import Foundation

extension Date {
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 mm월 dd일 HH시 mm분 ss초"
        return formatter.string(from: self)
    }
}
