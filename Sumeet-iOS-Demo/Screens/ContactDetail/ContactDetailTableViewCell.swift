//
//  ContactDetailTableViewCell.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 07/04/2025.
//

import UIKit


class ContactDetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var informationView = UIView()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        informationView = UIView()
        informationView.removeFromSuperview()
    }
    
    // MARK: - Methods
    
    func setup(contactDetailInformation: ContactDetailItem.Row) {
        
        switch contactDetailInformation {
                
            case .singleInformation(label: let label, value: let value):
                informationView = Views.SingleLabel(title: label, value: value)
                
            case .doubleInformation(
                firstLabel: let firstLabel, firstValue: let firstValue,
                secondLabel: let secondLabel, secondValue: let secondValue
            ):
                informationView = Views.DoubleLabel(
                    firstTitle: firstLabel, firstValue: firstValue,
                    secondTitle: secondLabel, secondValue: secondValue
                )
                
            case .mapCoordinates(coordinates: let coordinates):
                informationView = Views.Map(coordinates: coordinates)
        }
        
        contentView.addSubview(
            informationView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.smallSpacing,
                left: Constants.Sizes.regularSpacing,
                bottom: Constants.Sizes.smallSpacing,
                right: Constants.Sizes.regularSpacing
            )
        )
    }
}
