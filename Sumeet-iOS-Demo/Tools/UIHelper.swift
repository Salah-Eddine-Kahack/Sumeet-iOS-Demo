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
                .foregroundColor: Constants.Colors.primary,
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
        addSubviewUsingSafeArea(
            view,
            insets: insets,
            ignoreTopSafeArea: true,
            ignoreBottomSafeArea: true,
            ignoreLeftSafeArea: true,
            ignoreRightSafeArea: true
        )
    }

    func addSubviewUsingSafeArea(
        _ view: UIView,
        insets: UIEdgeInsets,
        ignoreTopSafeArea: Bool = false,
        ignoreBottomSafeArea: Bool = false,
        ignoreLeftSafeArea: Bool = false,
        ignoreRightSafeArea: Bool = false
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: (ignoreTopSafeArea ? topAnchor : safeAreaLayoutGuide.topAnchor), constant: insets.top),
            view.bottomAnchor.constraint(equalTo: (ignoreBottomSafeArea ? bottomAnchor : safeAreaLayoutGuide.bottomAnchor), constant: -insets.bottom),
            view.leftAnchor.constraint(equalTo: (ignoreLeftSafeArea ? leftAnchor : safeAreaLayoutGuide.leftAnchor), constant: insets.left),
            view.rightAnchor.constraint(equalTo: (ignoreRightSafeArea ? rightAnchor : safeAreaLayoutGuide.rightAnchor), constant: -insets.right)
        ])
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
    
    func addCenteredSubview(
        _ view: UIView,
        minInsets: UIEdgeInsets,
        axis: NSLayoutConstraint.Axis? = nil
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        var constraints: [NSLayoutConstraint] = []

        switch axis {
            case .horizontal:
                // Center horizontally
                constraints.append(view.centerXAnchor.constraint(equalTo: centerXAnchor))
                // Pin top and bottom exactly
                constraints.append(view.topAnchor.constraint(equalTo: topAnchor, constant: minInsets.top))
                constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -minInsets.bottom))
                // Add safety insets if needed
                constraints.append(view.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: minInsets.left))
                constraints.append(view.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -minInsets.right))
                
            case .vertical:
                // Center vertically
                constraints.append(view.centerYAnchor.constraint(equalTo: centerYAnchor))
                // Pin leading and trailing exactly
                constraints.append(view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: minInsets.left))
                constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -minInsets.right))
                // Add safety insets if needed
                constraints.append(view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: minInsets.top))
                constraints.append(view.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -minInsets.bottom))
                
            case .none, .some:
                // Center both
                constraints.append(view.centerXAnchor.constraint(equalTo: centerXAnchor))
                constraints.append(view.centerYAnchor.constraint(equalTo: centerYAnchor))
                // Apply min insets with greater/less-than-or-equal
                constraints.append(view.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: minInsets.left))
                constraints.append(view.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -minInsets.right))
                constraints.append(view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: minInsets.top))
                constraints.append(view.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -minInsets.bottom))
        }

        NSLayoutConstraint.activate(constraints)
    }
}
