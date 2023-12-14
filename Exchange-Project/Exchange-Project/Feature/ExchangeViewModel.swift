//
//  ExchangeViewModel.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Combine
import Foundation

@frozen
enum Nation: String {
    case KRW = "USDKRW"
    case JPY = "USDJPY"
    case PHP = "USDPHP"
}

struct Quote {
    let currencyCode: String
    let exchangeRate: Double
}

final class ExchangeViewModel: ViewModelType {
    private var networkProvider: ExchangeRateServiceType
    private var cancelBag = CancelBag()
    private var quote: [Quote] = []
    private var selectedNation = CurrentValueSubject<Nation, Never>(.KRW)
    
    init(networkProvider: ExchangeRateServiceType) {
        self.networkProvider = networkProvider
    }
    
    struct Input {
        let viewDidLoadEvent: AnyPublisher<Void, Never>
        let nationIsSelected: AnyPublisher<Nation, Never>
        let inputTextFieldText: AnyPublisher<String, Never>
    }
    
    struct Output {
        let selectedPrice: AnyPublisher<String, Never>
        let totalPriceInformation: AnyPublisher<String, Never>
        let showToastMessage: AnyPublisher<ErrorMessage, Never>
    }
    
    func transform(from input: Input, cancelBag: CancelBag) -> Output {
        lazy var price = PassthroughSubject<Double, Never>()
        lazy var priceAmount = PassthroughSubject<String, Never>()
        lazy var totalPriceAmount = PassthroughSubject<String, Never>()
        lazy var showToastCase = PassthroughSubject<ErrorMessage, Never>()

        let output = Output(selectedPrice: priceAmount.eraseToAnyPublisher(),
                            totalPriceInformation: totalPriceAmount.eraseToAnyPublisher(), showToastMessage: showToastCase.eraseToAnyPublisher())
        
        input.viewDidLoadEvent
            .flatMap { _ in
                return self.networkProvider.getExchangeRates()
                    .catch { error in
                        return Empty<ExchangeResponseData, Never>().eraseToAnyPublisher()
                    }
            }
            .sink(receiveValue: { [weak self] responseData in
                guard let self else { return }
                self.quote = responseData.quoteObjects
                print(responseData)
                if let koreaExchangeRate = self.quote.first(where: { $0.currencyCode == "USDKRW" }) {
                    priceAmount.send("\(koreaExchangeRate.exchangeRate.formattedString()) KRW / USD")
                    price.send(koreaExchangeRate.exchangeRate)
                }
            })
            .store(in: cancelBag)
        
        input.nationIsSelected
            .flatMap { data -> AnyPublisher<Quote?, Never> in
                self.selectedNation.send(data)
                guard let currentCurrencyCode = Nation(rawValue: data.rawValue) else {
                    return Just(nil).eraseToAnyPublisher()
                }
                return Just(self.quote.first { $0.currencyCode == currentCurrencyCode.rawValue })
                    .eraseToAnyPublisher()
            }
            .sink { quote in
                if let quote {
                    switch quote.currencyCode {
                    case "USDKRW":
                        priceAmount.send("\(quote.exchangeRate.formattedString()) KRW / USD")
                    case "USDJPY":
                        priceAmount.send("\(quote.exchangeRate.formattedString()) JPY / USD")
                    case "USDPHP":
                        priceAmount.send("\(quote.exchangeRate.formattedString()) PHP / USD")
                    default:
                        print("default")
                    }
                }
            }
            .store(in: self.cancelBag)
        
        input.inputTextFieldText
            .compactMap { Double($0) }
            .combineLatest(price)
            .map { input, price in
                if input > 10000 {
                    showToastCase.send(.overTenThousands)
                } else if input < 0 {
                    showToastCase.send(.lessZero)
                }
                return input * price
            }
            .sink { resultValue in
               
                
                switch self.selectedNation.value {
                case .KRW:
                    totalPriceAmount.send("수취금액은 \(resultValue.formattedString()) KRW 입니다")
                case .JPY:
                    totalPriceAmount.send("수취금액은 \(resultValue.formattedString()) JPY 입니다")
                case .PHP:
                    totalPriceAmount.send("수취금액은 \(resultValue.formattedString()) PHP 입니다")
                }
            }
            .store(in: self.cancelBag)
        
        return output
    }
}
