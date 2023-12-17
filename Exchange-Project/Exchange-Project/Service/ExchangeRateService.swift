//
//  ExchangeRateService.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Foundation
import Combine

protocol ExchangeRateServiceType {
    func getExchangeRates() -> AnyPublisher<ExchangeResponseData, ExchangeRateServiceError>
}

final class ExchangeRateService: ExchangeRateServiceType {
    private let baseURL = URL(string: "\(Config.baseURL)access_key=\(Config.apiKey)")!

    func getExchangeRates() -> AnyPublisher<ExchangeResponseData, ExchangeRateServiceError> {
        let publisher = Future<ExchangeResponseData, ExchangeRateServiceError> { promise in
            URLSession.shared.dataTask(with: self.baseURL) { data, response, error in
                if let error = error {
                    promise(.failure(.networkError(error)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    promise(.failure(.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let exchangeResponseData = try decoder.decode(ExchangeResponseData.self, from: data!)
                    promise(.success(exchangeResponseData))
                } catch {
                    promise(.failure(.decodingError(error)))
                }
            }.resume()
        }
        .eraseToAnyPublisher()

        return publisher
    }
}
