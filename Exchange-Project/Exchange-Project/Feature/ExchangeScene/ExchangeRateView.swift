//
//  ExchangeRateView.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import UIKit

final class ExchangeRateView: UIView {
    // MARK: Properties
    
    private let titleLabel = MainLabel(title: "환율 계산")
    private let remittanceLabel = MainLabel(title: "송금국가 : 미국 (USD")
    private let receptionLabel = MainLabel(title: "수취국가 :")
    let receptionNationLabel = MainLabel(title: "한국 (KRW)")
    private let exchangeLabel = MainLabel(title: "환율 :")
    let exchangeRateLabel = MainLabel(title: "환율 가격")
    private let checkLabel = MainLabel(title: "조회시간")
    let checkTimeLabel = MainLabel(title: "\(Date().formattedTime)")
    private let remittanceAmountLabel = MainLabel(title: "송금액 :")
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.keyboardType = .numberPad
        textField.borderStyle = .line
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.addLeftPadding()
        return textField
    }()
    
    let usdLabel = MainLabel(title: "USD")
    let priceInformationLabel = MainLabel(title: "금액을 입력해주세요.")
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    // MARK: Initializing

    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setStyle()
        self.setLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Functions

private extension ExchangeRateView {
    func setStyle() {
        self.backgroundColor = .white
    }
    
    func setLayout() {
        [titleLabel, remittanceLabel,
         receptionLabel, receptionNationLabel,
         exchangeLabel, exchangeRateLabel,
         checkLabel, checkTimeLabel,
         remittanceAmountLabel, amountTextField, usdLabel, priceInformationLabel, pickerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
                                     titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([remittanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                                     remittanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([receptionLabel.topAnchor.constraint(equalTo: remittanceLabel.bottomAnchor, constant: 30),
                                     receptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([receptionNationLabel.topAnchor.constraint(equalTo: receptionLabel.topAnchor),
                                     receptionNationLabel.leadingAnchor.constraint(equalTo: receptionLabel.trailingAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([exchangeLabel.topAnchor.constraint(equalTo: receptionNationLabel.bottomAnchor, constant: 30),
                                     exchangeLabel.trailingAnchor.constraint(equalTo: receptionLabel.trailingAnchor)])
        
        NSLayoutConstraint.activate([exchangeRateLabel.topAnchor.constraint(equalTo: exchangeLabel.topAnchor),
                                     exchangeRateLabel.leadingAnchor.constraint(equalTo: exchangeLabel.trailingAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([checkLabel.topAnchor.constraint(equalTo: exchangeLabel.bottomAnchor, constant: 30),
                                     checkLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([checkTimeLabel.topAnchor.constraint(equalTo: checkLabel.topAnchor),
                                     checkTimeLabel.leadingAnchor.constraint(equalTo: checkLabel.trailingAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([remittanceAmountLabel.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 30),
                                     remittanceAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([amountTextField.centerYAnchor.constraint(equalTo: remittanceAmountLabel.centerYAnchor),
                                     amountTextField.leadingAnchor.constraint(equalTo: remittanceAmountLabel.trailingAnchor, constant: 3),
                                     amountTextField.heightAnchor.constraint(equalToConstant: 44),
                                     amountTextField.widthAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([usdLabel.topAnchor.constraint(equalTo: remittanceAmountLabel.topAnchor),
                                     usdLabel.leadingAnchor.constraint(equalTo: amountTextField.trailingAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([priceInformationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     priceInformationLabel.topAnchor.constraint(equalTo: usdLabel.bottomAnchor, constant: 30)])
        
        NSLayoutConstraint.activate([pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     pickerView.heightAnchor.constraint(equalToConstant: 300)])
    }
}
