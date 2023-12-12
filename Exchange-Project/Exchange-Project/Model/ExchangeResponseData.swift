//
//  ExchangeResponseData.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Foundation

struct ExchangeResponseData: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
