//
//  UIHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


struct UIHelper {
    
    static func configureCustomNavigationBarFont(viewController: UIViewController) {
        
        guard let navigationController = viewController.navigationController else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        if let rubikFont = UIFont(name: "Rubik-Light_SemiBold", size: 34) {
            let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
            let scaledFont = fontMetrics.scaledFont(for: rubikFont)

            appearance.largeTitleTextAttributes = [
                .font: scaledFont,
                .foregroundColor: Constants.Colors.primary
            ]
        }

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.prefersLargeTitles = true
    }
}


extension UIView {
    
    func addSubview(_ view: UIView, insets: UIEdgeInsets) {
            
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let top = view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        let bottom = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        let left = view.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left)
        let right = view.rightAnchor.constraint(equalTo: rightAnchor, constant: -insets.right)
            
        NSLayoutConstraint.activate([top, bottom, left, right])
    }
    
    func addCenteredSubview(_ view: UIView, width: CGFloat, height: CGFloat) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let widthConstraint = view.widthAnchor.constraint(equalToConstant: width)
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
        let centerXConstraint = view.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerYConstraint = view.centerYAnchor.constraint(equalTo: centerYAnchor)

        NSLayoutConstraint.activate([widthConstraint, heightConstraint, centerXConstraint, centerYConstraint])
    }
    
    func addCenteredSubview(_ view: UIView, minInsets: UIEdgeInsets) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let centerXConstraint = view.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerYConstraint = view.centerYAnchor.constraint(equalTo: centerYAnchor)

        var constraints = [centerXConstraint, centerYConstraint]

        if minInsets.left > .zero {
            let leftConstraint = view.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: minInsets.left)
            constraints.append(leftConstraint)
        }

        if minInsets.right > .zero  {
            let rightConstraint = view.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -minInsets.right)
            constraints.append(rightConstraint)
        }

        if minInsets.top > .zero  {
            let topConstraint = view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: minInsets.top)
            constraints.append(topConstraint)
        }

        if minInsets.bottom > .zero  {
            let bottomConstraint = view.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -minInsets.bottom)
            constraints.append(bottomConstraint)
        }

        NSLayoutConstraint.activate(constraints)
    }
}
