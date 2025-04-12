//
//  UIHelper.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


struct UIHelper {
    
    enum AnimationDuration: TimeInterval {
        case none = 0.0
        case short = 0.3
        case medium = 0.5
        case long = 0.7
    }
    
    static func animateUIChanges(duration: AnimationDuration,
                                 delay: TimeInterval = .zero,
                                 options: UIView.AnimationOptions = .curveEaseOut,
                                 animations: @escaping () -> Void,
                                 completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: duration.rawValue,
            delay: delay,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: .zero,
            options: options,
            animations: animations,
            completion: { _ in
                completion?()
            }
        )
    }
    
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
    
    static var safeAreaInsets: UIEdgeInsets {

        let window = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }

        guard let keyWindow = window
        else {
            Logger.log("Cannot find current app window!", level: .error)
            return .zero
        }

        return keyWindow.safeAreaInsets
    }
}
