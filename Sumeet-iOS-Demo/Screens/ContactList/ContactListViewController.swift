//
//  ContactListViewController.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit


class ContactListViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: ContactListViewModel!
    
    // MARK: - UI Components
    
    private lazy var tableView: UITableView = {
        // TODO: Properly setup tableview
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isHidden = isEmpty // TODO: Adjust behavior
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        
        let iconView = UIImageView(image: Constants.Icons.noContacts)
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Constants.Colors.secondary
        
        let messageLabel = UILabel()
        messageLabel.text = Constants.Texts.ContactList.emptyMessage
        messageLabel.numberOfLines = 0
        messageLabel.textColor = Constants.Colors.secondary
        messageLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        let loadButton = ButtonViews.Primary(
            title: Constants.Texts.ContactList.loadContactsButtonTitle,
            action: {
                self.viewModel.loadContacts()
            }
        )
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = Constants.Sizes.spacing
        infoStackView.addArrangedSubview(iconView)
        infoStackView.addArrangedSubview(messageLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.Sizes.largeSpacing
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(loadButton)
        
        let emptyMessageView = UIView()
        emptyMessageView.addSubview(
            stackView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.insets,
                left: Constants.Sizes.insets,
                bottom: Constants.Sizes.insets,
                right: Constants.Sizes.insets
            )
        )
        
        let emptyView = UIView()
        emptyView.addCenteredSubview(
            emptyMessageView,
            minInsets: UIEdgeInsets(
                top: Constants.Sizes.insets,
                left: Constants.Sizes.insets,
                bottom: Constants.Sizes.insets,
                right: Constants.Sizes.insets
            )
        )
        
        return emptyView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizes.spacing
        
        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(tableView)
        // TODO: Properly switch between empty and filled view
        
        return stackView
    }()
    
    // MARK: - Getters
    
    private var isEmpty: Bool {
        // TODO: Implement or remove
        return true
    }
    
    // MARK: - Lifecycle
    
    init(viewModel: ContactListViewModel) {
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
        title = Constants.Texts.ContactList.title
        
        // Setup view
        view.backgroundColor = Constants.Colors.background
        view.addSubview(contentStackView, insets: .zero)
    }
    
    // MARK: - Actions
    
}
