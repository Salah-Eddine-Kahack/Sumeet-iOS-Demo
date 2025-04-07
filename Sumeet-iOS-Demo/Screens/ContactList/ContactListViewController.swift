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
    
    private lazy var errorMessageLabel: UILabel = {
        
        let errorMessageLabel = UILabel()
        errorMessageLabel.numberOfLines = .zero
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = Constants.Colors.criticalText // TODO: Handle error/warning message types
        errorMessageLabel.font = .preferredFont(forTextStyle: .footnote)
        
        return errorMessageLabel
    }()
    
    private lazy var errorMessageView: UIView = {
        
        let errorMessageLabelContainerView = UIView()
        errorMessageLabelContainerView.backgroundColor = Constants.Colors.criticalBackground
        
        errorMessageLabelContainerView.addSubview(
            errorMessageLabel,
            insets: Constants.Sizes.buttonEdgeInsets
        )
        
        errorMessageLabelContainerView.layer.cornerRadius = Constants.Sizes.cornerRadius
        errorMessageLabelContainerView.layer.masksToBounds = true
        
        let errorMessageView = UIView()
        errorMessageView.isHidden = viewModel.errorMessage == nil || viewModel.errorMessage!.isEmpty
        
        errorMessageView.addSubview(
            errorMessageLabelContainerView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.regularSpacing,
                left: Constants.Sizes.mediumSpacing,
                bottom: Constants.Sizes.regularSpacing,
                right: Constants.Sizes.mediumSpacing
            )
        )
        
        return errorMessageView
    }()
    
    private lazy var emptyView: UIView = {
        
        let iconView = UIImageView(image: Constants.Icons.noContacts)
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Constants.Colors.secondary
        
        let emptyMessageLabel = UILabel()
        emptyMessageLabel.text = Constants.Texts.ContactList.emptyMessage
        emptyMessageLabel.numberOfLines = .zero
        emptyMessageLabel.textColor = Constants.Colors.secondary
        emptyMessageLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        let loadButton = ButtonViews.Primary(
            title: Constants.Texts.ContactList.loadContactsButtonTitle,
            action: {
                self.viewModel.loadContacts()
            }
        )
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = Constants.Sizes.regularSpacing
        infoStackView.addArrangedSubview(iconView)
        infoStackView.addArrangedSubview(emptyMessageLabel)
        
        let emptyStackView = UIStackView()
        emptyStackView.axis = .vertical
        emptyStackView.alignment = .center
        emptyStackView.spacing = Constants.Sizes.largeSpacing
        emptyStackView.addArrangedSubview(infoStackView)
        emptyStackView.addArrangedSubview(loadButton)
        
        let emptyView = UIView()
        emptyView.addCenteredSubview(
            emptyStackView,
            minInsets: UIEdgeInsets(
                top: Constants.Sizes.mediumSpacing,
                left: Constants.Sizes.mediumSpacing,
                bottom: Constants.Sizes.mediumSpacing,
                right: Constants.Sizes.mediumSpacing
            )
        )
        return emptyView
    }()
    
    private lazy var tableView: UITableView = {

        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(
            ContactListTableViewCell.self,
            forCellReuseIdentifier: Constants.CellIdentifiers.contactListCellIdentifier
        )
        
        return tableView
    }()
    
    private lazy var contentStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizes.regularSpacing
        
        stackView.addArrangedSubview(errorMessageView)
        // TODO: Handle toggling between emptyView and TableView
//        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(tableView)
        
        return stackView
    }()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.loadContacts()
        tableView.reloadData()
    }

    // MARK: - Methods
    
    private func setupUI() {
        
        // Setup navigatiom bar
        UIHelper.configureCustomNavigationBarFont(viewController: self)
        title = Constants.Texts.ContactList.title
        
        // Setup view
        view.backgroundColor = Constants.Colors.background
        
        view.addSubviewUsingSafeArea(
            contentStackView,
            insets: .zero,
            ignoreBottomSafeArea: true
        )
    }
    
    // MARK: - Actions
    
}

// MARK: - UITableViewDataSource

extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.CellIdentifiers.contactListCellIdentifier,
            for: indexPath
        ) as? ContactListTableViewCell else {
            return UITableViewCell()
        }
        
        let contact = viewModel.contacts[indexPath.row]
        cell.setup(contact: contact)
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let contact = viewModel.contacts[indexPath.row]
        viewModel.handleContactSelection(selectedContactItem: contact)
    }
}
