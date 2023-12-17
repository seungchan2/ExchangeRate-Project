//
//  Exchange_ProjectTests.swift
//  Exchange-ProjectTests
//
//  Created by 김승찬 on 2023/12/12.
//

import XCTest
import Combine
@testable import Exchange_Project

final class Exchange_ProjectTests: XCTestCase {
    
    var viewModel: ExchangeViewModel!
    var cancelBag: CancelBag!
    
    override func setUpWithError() throws {
        viewModel = ExchangeViewModel(networkProvider: ExchangeRateService())
        cancelBag = CancelBag()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        cancelBag = nil
    }
    
    func test_앱시작시_한국금액으로시작() throws {
        let viewDidLoadEvent = PassthroughSubject<Void, Never>()
        let nationIsSelected = PassthroughSubject<Nation, Never>()
        let inputText = PassthroughSubject<String, Never>()
        
        let input = ExchangeViewModel.Input(viewDidLoadEvent: viewDidLoadEvent.eraseToAnyPublisher(), nationIsSelected: nationIsSelected.eraseToAnyPublisher(), inputTextFieldText: inputText.eraseToAnyPublisher())
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        let expectation = false
        var krwContainsBoolean = true
        output.selectedPrice
            .sink { _ in }
            receiveValue: { price in
                if price.contains("KRW") {
                    krwContainsBoolean = true
                } else {
                    krwContainsBoolean = false
                }
            }
            .store(in: self.cancelBag)
        
        XCTAssertEqual(expectation, krwContainsBoolean)
    }
    
    func test_PickerView_한국선택() throws {
        let viewDidLoadEvent = PassthroughSubject<Void, Never>()
        let nationIsSelected = CurrentValueSubject<Nation, Never>(.KRW)
        let inputText = PassthroughSubject<String, Never>()
        
        let input = ExchangeViewModel.Input(viewDidLoadEvent: viewDidLoadEvent.eraseToAnyPublisher(), nationIsSelected: nationIsSelected.eraseToAnyPublisher(), inputTextFieldText: inputText.eraseToAnyPublisher())
        
        let output = viewModel.transform(from: input, cancelBag: cancelBag)
        var krwExpectation = Nation.KRW.rawValue
        var jpyExpectation = Nation.JPY.rawValue
        var phpExpectation = Nation.PHP.rawValue
        
        let expectation = false
        var krwContainsBoolean = true
        output.totalPriceInformation
            .sink { _ in }
            receiveValue: { price in
                if price == "금액을 입력해주세요." {
                    krwContainsBoolean = false
                } else {
                    krwContainsBoolean = true
                }
            }
            .store(in: self.cancelBag)
        
        XCTAssertEqual(expectation, krwContainsBoolean)
    }
}
