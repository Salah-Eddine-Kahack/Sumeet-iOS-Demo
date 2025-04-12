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
        
        private var buttonAction: ButtonActionCallback
        private let tappableButton = UIButton(type: .custom)
        
        // Life cycle
        
        init(action: @escaping ButtonActionCallback) {
            self.buttonAction = action
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
            
            UIHelper.animateUIChanges(duration: .short, options: [.curveEaseOut, .allowUserInteraction]) {
                self.transform = transform
                self.alpha = alpha
            }
        }

        // Actions
        
        @objc private func didTap() {
            buttonAction()
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
        
        init(title: String, action: @escaping ButtonActionCallback) {
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
            titleLabel.lineBreakMode = .byTruncatingMiddle
            titleLabel.textColor = Constants.Colors.buttonTitle
            titleLabel.font = UIFont(name: "Rubik-Light_SemiBold", size: Constants.Sizes.defaultFontSize)

            // Add label
            addSubview(titleLabel, insets: Constants.Sizes.buttonEdgeInsets)
        }
    }
}

// MARK: - Loading ButtonView

extension ButtonViews {
    
    /// Works like a UIButton
    final class LoaderWithTitle: Base {
        
        // Properties
        
        private let titleLabel = UILabel()
        private let loadingLabel = UILabel()
        
        // UI Components
        
        private lazy var loadingBackgroundView: UIView = {
            let loadingBackgroundView = UIView()
            loadingBackgroundView.backgroundColor = Constants.Colors.loadingBackground
            return loadingBackgroundView
        }()
        
        // Life cycle
        
        init(title: String, action: @escaping ButtonActionCallback) {
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
            
            // Setup loading background
            loadingBackgroundView.alpha = .zero
            addSubview(loadingBackgroundView, insets: .zero)
            
            // Setup labels
            loadingLabel.alpha = .zero
            configureLabel(titleLabel, withText: title)
            configureLabel(loadingLabel, withText: Constants.Texts.loadingButtonTitle)
            addSubview(titleLabel, insets: Constants.Sizes.buttonEdgeInsets)
            addSubview(loadingLabel, insets: Constants.Sizes.buttonEdgeInsets)
        }

        private func configureLabel(_ label: UILabel, withText text: String) {
            
            label.text = text
            label.textAlignment = .center
            label.lineBreakMode = .byTruncatingMiddle
            label.textColor = Constants.Colors.buttonTitle
            
            label.font = UIFont(
                name: "Rubik-Light_SemiBold",
                size: Constants.Sizes.defaultFontSize
            )
        }
        
        internal func toggleLoading(on: Bool) {
            
            let fadeDuration = UIHelper.AnimationDuration.short
            let slideDuration = UIHelper.AnimationDuration.long
            let delay = fadeDuration.rawValue / 2.0
            
            // Animate the title change
            UIHelper.animateUIChanges(duration: fadeDuration, delay: on ? .zero : delay) {
                self.titleLabel.alpha = on ? .zero : 1.0
            }
            
            UIHelper.animateUIChanges(duration: fadeDuration, delay: on ? delay : .zero) {
                self.loadingLabel.alpha = on ? 1.0 : .zero
            }
            
            // Animate the loading
            if on {
                loadingBackgroundView.transform = CGAffineTransform(scaleX: .zero, y: 1.0)
                loadingBackgroundView.transform = CGAffineTransform(translationX: -loadingBackgroundView.bounds.width, y: .zero)
                loadingBackgroundView.alpha = 1.0
                
                UIHelper.animateUIChanges(duration: slideDuration) {
                    self.loadingBackgroundView.transform = .identity
                }
            }
            else {
                UIHelper.animateUIChanges(duration: fadeDuration) {
                    self.loadingBackgroundView.alpha = .zero
                }
            }
        }
    }
}


// MARK: - LargeIcon ButtonView

extension ButtonViews {
    
    /// Works like a UIButton
    final class LargeIconWithTitle: Base {
        
        // Properties
        
        private let iconImageView = UIImageView()
        private let titleLabel = UILabel()
        
        // Life cycle
        
        init(title: String, icon: UIImage, action: @escaping ButtonActionCallback) {
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

// MARK: - LoadingIcon ButtonView

extension ButtonViews {
    
    /// Works like a UIButton
    final class LoaderWithIcon: Base {
        
        // Properties
        
        private let iconImageView = UIImageView()
        
        // Life cycle
        
        override init(action: @escaping ButtonActionCallback) {
            super.init(action: action)
            setupView()
            setupTappableButton()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Methods
        
        private func setupView() {
            
            iconImageView.image = Constants.Icons.refresh
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = Constants.Colors.primary
            
            addSubview(iconImageView, insets: UIEdgeInsets(
                top: Constants.Sizes.smallSpacing,
                left: Constants.Sizes.smallSpacing,
                bottom: Constants.Sizes.smallSpacing,
                right: Constants.Sizes.smallSpacing
            ))
        }
        
        func toggleLoading(on: Bool) {
            
            let animationKey = "rotateAnimation"

            if on {
                // If animation already exists, do nothing
                if iconImageView.layer.animation(forKey: animationKey) != nil { return }

                let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotation.toValue = -CGFloat.pi * 2.0 // Counter-clockwise
                rotation.duration = 1.0 // 1 second per rotation
                rotation.isCumulative = true
                rotation.repeatCount = .infinity
                rotation.timingFunction = CAMediaTimingFunction(name: .linear)

                iconImageView.layer.add(rotation, forKey: animationKey)
            }
            else {
                // Animate to stop rotation smoothly
                if let pressentation = iconImageView.layer.presentation() {
                    
                    let currentRotation = pressentation.value(forKeyPath: "transform.rotation.z") as? CGFloat ?? .zero

                    iconImageView.layer.removeAnimation(forKey: animationKey)
                    
                    // Snap to current rotation to prevent jump
                    iconImageView.layer.transform = CATransform3DMakeRotation(currentRotation, .zero, .zero, 1.0)
                    
                    // Animate back to 0 for a smooth reset (optional)
                    UIHelper.animateUIChanges(duration: .short) {
                        self.iconImageView.transform = .identity
                    }
                }
                else {
                    // Fallback in case there's no presentation layer
                    iconImageView.layer.removeAnimation(forKey: animationKey)
                    iconImageView.transform = .identity
                }
            }
        }
    }
}

