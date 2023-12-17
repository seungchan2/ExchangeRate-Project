//
//  NetworkError.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/17.
//

import Foundation

enum ExchangeRateServiceError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}
