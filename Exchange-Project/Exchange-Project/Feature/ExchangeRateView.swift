//
//  ExchangeRateView.swift
//  Exchange-Project
//
//  Created by 김승찬 on 2023/12/12.
//

import UIKit

final class ExchangeRateView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "환율 계산"
        return label
    }()
    
    private let remittanceLabel: UILabel = {
        let label = UILabel()
        label.text = "송금국가 : 미국 (USD)"
        return label
    }()
    
    private let receptionLabel: UILabel = {
        let label = UILabel()
        label.text = "수취국가 :"
        return label
    }()
    
    let receptionNationLabel: UILabel = {
        let label = UILabel()
        label.text = "한국 (KRW)"
        return label
    }()
    
    let exchangeLabel: UILabel = {
        let label = UILabel()
        label.text = "환율 :"
        return label
    }()
    
    let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "11111"
        return label
    }()
    
    let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "조회시간"
        return label
    }()
    
    let checkTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Date())"
        return label
    }()

    let remittanceAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "송금액 :"
        return label
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .yellow
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let usdLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        return label
    }()
    
    lazy var priceInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "가격은"
        return label
    }()
    
    let pickerView: UIPickerView = {
       let picker = UIPickerView()
        return picker
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.setStyle()
        self.setLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
