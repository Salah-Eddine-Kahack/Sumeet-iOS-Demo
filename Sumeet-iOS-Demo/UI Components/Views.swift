//
//  Views.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 07/04/2025.
//

import UIKit
import MapKit


struct Views {
    
    /// Acts like an abstract class
    class BaseLabel: UIView {
        
        // UI Components
        
        private lazy var titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.font = .preferredFont(forTextStyle: .subheadline)
            return titleLabel
        }()
        
        private lazy var valueLabel: UILabel = {
            let valueLabel = UILabel()
            valueLabel.textColor = Constants.Colors.secondary
            valueLabel.numberOfLines = .zero
            return valueLabel
        }()
        
        fileprivate lazy var stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
            stackView.axis = .vertical
            stackView.spacing = Constants.Sizes.tinySpacing
            return stackView
        }()
        
        // Life cycle
        
        init(title: String, value: String) {
            super.init(frame: .zero)
            setupUI(title: title, value: value)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods
        
        fileprivate func setupUI(title: String, value: String) {
            backgroundColor = .clear
            titleLabel.text = title
            valueLabel.text = value
        }
    }
}


// MARK: - SingleLabel

extension Views {
    
    class SingleLabel: BaseLabel {
        
        // Methods
        
        fileprivate override func setupUI(title: String, value: String) {
            super.setupUI(title: title, value: value)
            
            addSubview(
                stackView,
                insets: UIEdgeInsets(
                    top: Constants.Sizes.tinySpacing,
                    left: Constants.Sizes.smallSpacing,
                    bottom: Constants.Sizes.tinySpacing,
                    right: Constants.Sizes.smallSpacing
                )
            )
        }
    }
}


// MARK: - DoubleLabel

extension Views {
    
    class DoubleLabel: UIView {
        
        // Life cycle
        
        init(firstTitle: String, firstValue: String,
             secondTitle: String, secondValue: String) {

            super.init(frame: .zero)
            
            setupUI(
                firstTitle: firstTitle, firstValue: firstValue,
                secondTitle: secondTitle, secondValue: secondValue
            )
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods
        
        private func setupUI(firstTitle: String, firstValue: String,
                             secondTitle: String, secondValue: String) {
            
            backgroundColor = .clear
            
            let firstLabel = BaseLabel(title: firstTitle, value: firstValue)
            let secondLabel = BaseLabel(title: secondTitle, value: secondValue)
            
            let doubleLabelStackView = UIStackView()
            doubleLabelStackView.axis = .horizontal
            doubleLabelStackView.distribution = .fillEqually
            doubleLabelStackView.spacing = Constants.Sizes.regularSpacing
            doubleLabelStackView.addArrangedSubview(firstLabel.stackView)
            doubleLabelStackView.addArrangedSubview(secondLabel.stackView)
            
            addSubview(
                doubleLabelStackView,
                insets: UIEdgeInsets(
                    top: Constants.Sizes.tinySpacing,
                    left: Constants.Sizes.smallSpacing,
                    bottom: Constants.Sizes.tinySpacing,
                    right: Constants.Sizes.smallSpacing
                )
            )
        }
    }
}


// MARK: - Map View

extension Views {
    
    class Map: UIView {
        
        // Life cycle
        
        init(coordinates: CLLocationCoordinate2D) {
            super.init(frame: .zero)
            setupUI(coordinates: coordinates)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods
        
        private func setupUI(coordinates: CLLocationCoordinate2D) {
            
            // Setup layout
            let mapView = MKMapView()
            
            addSubview(
                mapView,
                insets: UIEdgeInsets(
                    top: Constants.Sizes.tinySpacing,
                    left: Constants.Sizes.smallSpacing,
                    bottom: Constants.Sizes.tinySpacing,
                    right: Constants.Sizes.smallSpacing
                )
            )

            NSLayoutConstraint.activate([
                mapView.heightAnchor.constraint(equalToConstant: Constants.Sizes.mapViewHeight)
            ])
            
            // Set GPS coordinates
            mapView.setRegion(
                MKCoordinateRegion(
                    center: coordinates,
                    latitudinalMeters: 100000,
                    longitudinalMeters: 100000
                ),
                animated: false
            )
            
            // Add styling
            mapView.layer.cornerRadius = Constants.Sizes.cornerRadius
            mapView.layer.masksToBounds = true
        }
    }
}
