//
//  ButtonViews.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


// MARK: - Base ButtonView

struct ButtonViews {
    
    typealias ButtonActionCallback = () -> Void

    /// Acts like an abstract class
    class Base: UIView {
        
        // Properties
        
        private var action: ButtonActionCallback?
        private let tappableButton = UIButton(type: .custom)
        
        // Life cycle
        
        init(action: ButtonActionCallback?) {
            self.action = action
            super.init(frame: .zero)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods

        /// Needs to be called in subclasses after setting UI
        fileprivate func setupTappableButton() {
            tappableButton.backgroundColor = .clear
            tappableButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
            tappableButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
            tappableButton.addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel, .touchDragExit, .touchDragOutside])
            addSubview(tappableButton, insets: .zero)
        }

        private func animateTouch(pressed: Bool) {
            let transform = pressed ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
            let alpha: CGFloat = pressed ? 0.7 : 1.0
            
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: [.curveEaseOut, .allowUserInteraction],
                animations: {
                    self.transform = transform
                    self.alpha = alpha
                }
            )
        }

        // Actions
        
        @objc private func didTap() {
            action?()
        }

        @objc private func touchDown() {
            animateTouch(pressed: true)
        }

        @objc private func touchUp() {
            animateTouch(pressed: false)
        }
    }
}


// MARK: - Primary ButtonView

extension ButtonViews {
    
    /// Works like a UIButton
    final class Primary: Base {
        
        // Properties
        
        private let titleLabel = UILabel()
        
        // Life cycle
        
        init(title: String, action: ButtonActionCallback? = nil) {
            super.init(action: action)
            setupView(title: title)
            setupTappableButton()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods
        
        private func setupView(title: String) {
            
            // Setup view
            backgroundColor = Constants.Colors.primary
            layer.cornerRadius = Constants.Sizes.cornerRadius
            clipsToBounds = true
            
            // Setup label
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.textColor = Constants.Colors.buttonTitle
            titleLabel.font = UIFont(name: "Rubik-Light_SemiBold", size: Constants.Sizes.defaultFontSize)

            // Add label
            addSubview(titleLabel, insets: Constants.Sizes.buttonEdgeInsets)
        }
    }
}


// MARK: - LargeIcon ButtonView

extension ButtonViews {
    
    final class LargeIcon: Base {
        
        // Properties
        
        private let iconImageView = UIImageView()
        private let titleLabel = UILabel()
        
        // Life cycle
        
        init(title: String, icon: UIImage, action: ButtonActionCallback? = nil) {
            super.init(action: action)
            setupView(title: title, icon: icon)
            setupTappableButton()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods
        
        private func setupView(title: String, icon: UIImage) {
            iconImageView.image = icon
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = Constants.Colors.primary
            
            titleLabel.text = title
            titleLabel.textColor = Constants.Colors.primary
            titleLabel.font = .preferredFont(forTextStyle: .callout)
            
            let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
            stackView.axis = .vertical
            stackView.spacing = Constants.Sizes.smallSpacing
            stackView.alignment = .center
            
            addSubview(stackView, insets: UIEdgeInsets(
                top: Constants.Sizes.smallSpacing,
                left: Constants.Sizes.smallSpacing,
                bottom: Constants.Sizes.smallSpacing,
                right: Constants.Sizes.smallSpacing
            ))
        }
    }
}

