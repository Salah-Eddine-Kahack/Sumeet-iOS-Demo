//
//  ContactDetailViewController.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


class ContactDetailViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: ContactDetailViewModel!
    
    // MARK: - Lifecycle
    
    init(viewModel: ContactDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        
        // Setup navigatiom bar
        UIHelper.configureCustomNavigationBarFont(viewController: self)
        title = "Contact Detail" // TODO: Use proper title
        
        // Setup view
        view.backgroundColor = Constants.Colors.background
    }
}
