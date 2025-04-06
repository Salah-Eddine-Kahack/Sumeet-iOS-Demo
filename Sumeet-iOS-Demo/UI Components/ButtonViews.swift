//
//  ButtonViews.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


// MARK: - Base ButtonView

struct ButtonViews {
    
    /// Works like an Abstract Class
    class BaseView: UIView {
        
        typealias ButtonActionCallback = () -> Void
        
        // MARK: - Properties
        
        private var buttonActionCallback: ButtonActionCallback?
        fileprivate let titleLabel = UILabel()
        private let tappableButton = UIButton(type: .custom)
        
        // MARK: - Life cycle
        
        init(title: String, action: ButtonActionCallback? = nil) {
            buttonActionCallback = action
            super.init(frame: .zero)
            setupView(title: title)
            setupButton()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Methods
        
        fileprivate func setupView(title: String) {
            fatalError("Implement in subclasses")
        }
        
        private func setupButton() {
            tappableButton.backgroundColor = .clear
            tappableButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
            tappableButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
            tappableButton.addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel, .touchDragExit, .touchDragOutside])
            addSubview(tappableButton, insets: .zero)
        }
        
        private func animateTouch(pressed: Bool) {
            
            let scale = pressed ? 0.97 : 1.0
            let alpha = pressed ? 0.7 : 1.0
            
            UIView.animate(
                withDuration: 0.25,
                delay: .zero,
                options: [.curveEaseOut, .allowUserInteraction],
                animations: {
                    // Apply changes
                    self.transform = CGAffineTransform(scaleX: scale, y: scale)
                    self.alpha = alpha
                    
                },
                completion: nil
            )
        }
        
        // MARK: - Actions
        
        @objc private func didTap() {
            buttonActionCallback?()
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
    final class Primary: BaseView {
        
        fileprivate override func setupView(title: String) {
            
            // Setup view
            backgroundColor = Constants.Colors.primary
            layer.cornerRadius = Constants.Sizes.cornerRadius
            clipsToBounds = true
            
            // Setup label
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.textColor = Constants.Colors.button
            titleLabel.font = UIFont(name: "Rubik-Light_SemiBold", size: Constants.Sizes.defaultFontSize)

            // Add label
            addSubview(titleLabel, insets: Constants.Sizes.buttonEdgeInsets)
        }
    }
}
