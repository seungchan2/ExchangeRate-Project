//
//  ExchangeRateService.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Foundation
import Combine

enum ExchangeRateServiceError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

protocol ExchangeRateServiceType {
    func getExchangeRates() -> AnyPublisher<ExchangeReponseData, ExchangeRateServiceError>
}

final class ExchangeRateService: ExchangeRateServiceType {
    private let baseURL = URL(string: "\(Config.baseURL)access_key=\(Config.apiKey)")!

    func getExchangeRates() -> AnyPublisher<ExchangeReponseData, ExchangeRateServiceError> {
        return URLSession.shared.dataTaskPublisher(for: baseURL)
            .mapError { error in
                .networkError(error)
            }
            .flatMap { data, response -> AnyPublisher<ExchangeReponseData, ExchangeRateServiceError> in
                guard let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                    return Fail(error: ExchangeRateServiceError.invalidResponse).eraseToAnyPublisher()
                }

                let decoder = JSONDecoder()
                return Just(data)
                    .decode(type: ExchangeReponseData.self, decoder: decoder)
                    .mapError { error in
                        .decodingError(error)
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
