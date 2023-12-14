//
//  ExchangeRateViewController.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import Combine
import UIKit

final class ExchangeRateViewController: UIViewController {
    
    private var viewModel: ExchangeViewModel
    private let originView = ExchangeRateView()
    private let cancelBag = CancelBag()
    private var selectedNation = CurrentValueSubject<Nation, Never>(.KRW)
    private let viewDidLoadEvent = PassthroughSubject<Void, Never>()
    private let values = ["한국", "일본", "필리핀"]
    
    override func loadView() {
        self.view = originView
    }
    
    init(viewModel: ExchangeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignDelegation()
        self.bind()
    }
}

private extension ExchangeRateViewController {
    func assignDelegation() {
        self.originView.pickerView.delegate = self
        self.originView.pickerView.dataSource = self
    }
        
    func bind() {

        let input = ExchangeViewModel.Input(viewDidLoadEvent: viewDidLoadEvent.eraseToAnyPublisher(),
                                            nationIsSelected: selectedNation.eraseToAnyPublisher(),
                                            inputTextFieldText: self.originView.amountTextField.publisher)
        
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        viewDidLoadEvent.send(())

        output.selectedPrice
            .receive(on: RunLoop.main)
            .map { price in
                return price 
            }
            .assign(to: \.text, on: self.originView.exchangeRateLabel)
            .store(in: self.cancelBag)
        
        output.totalPriceInformation
            .receive(on: RunLoop.main)
            .map { price in
                return price
            }
            .assign(to: \.text, on: self.originView.priceInformationLabel)
            .store(in: self.cancelBag)
        
        output.showToastMessage
            .sink { data in
                self.showToast(message: data)
            }
            .store(in: self.cancelBag)
    }
}

extension ExchangeRateViewController: UIPickerViewDelegate {}

extension ExchangeRateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            self.selectedNation.send(.KRW)
        case 1:
            self.selectedNation.send(.JPY)
        case 2:
            self.selectedNation.send(.PHP)
        default:
            print("default")
        }
    }
}
