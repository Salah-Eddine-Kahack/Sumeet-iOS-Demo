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
    
    // MARK: - UI Components
    
    private lazy var avatarImageView: UIImageView = {
        
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = Constants.Sizes.ContactDetail.avatarCornerRadius
        avatarImageView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Sizes.ContactDetail.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Sizes.ContactDetail.avatarSize)
        ])
        
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = Constants.Colors.borderColor.cgColor
        
        return avatarImageView
    }()
    
    private lazy var actionsStackView: UIStackView = {
 
        let textButtonView = ButtonViews.LargeIconWithTitle(
            title: Constants.Texts.ContactDetail.textButton,
            icon: Constants.Icons.text
        ) { [unowned self] in
            self.viewModel.handleTextContact()
        }
        
        let callButtonView = ButtonViews.LargeIconWithTitle(
            title: Constants.Texts.ContactDetail.callButton,
            icon: Constants.Icons.phone
        ) { [unowned self] in
            self.viewModel.handleCallContact()
        }
        
        let emailButtonView = ButtonViews.LargeIconWithTitle(
            title: Constants.Texts.ContactDetail.emailButton,
            icon: Constants.Icons.email
        ) { [unowned self] in
            self.viewModel.handleEmailContact(viewController: self)
        }
        
        let actionViews = [textButtonView, callButtonView, emailButtonView]
        let stackView = UIStackView(arrangedSubviews: actionViews)
        
        stackView.axis = .horizontal
        stackView.spacing = Constants.Sizes.regularSpacing
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var headerView: UIView = {
        
        let avatarView = UIView()
        avatarView.addCenteredSubview(avatarImageView, minInsets:.zero, axis: .horizontal)
        
        let headerStackView = UIStackView()
        headerStackView.axis = .vertical
        headerStackView.spacing = Constants.Sizes.regularSpacing
        headerStackView.addArrangedSubview(avatarView)
        headerStackView.addArrangedSubview(actionsStackView)
        
        let headerView = UIView()
        headerView.addSubview(
            headerStackView,
            insets: UIEdgeInsets(
                top: .zero,
                left: .zero,
                bottom: Constants.Sizes.regularSpacing,
                right: .zero
            )
        )
        
        return headerView
    }()
    
    private lazy var tableView: UITableView = {

        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.contentInset = UIEdgeInsets(
            top: Constants.Sizes.regularSpacing,
            left: .zero,
            bottom: Constants.Sizes.regularSpacing,
            right: .zero
        )
        
        tableView.register(
            ContactDetailTableViewCell.self,
            forCellReuseIdentifier: Constants.CellIdentifiers.contactDetailCellIdentifier
        )
        
        tableView.backgroundColor = Constants.Colors.contentBackground
        tableView.layer.cornerRadius = Constants.Sizes.largeCornerRadius
        tableView.layer.masksToBounds = true
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = Constants.Colors.borderColor.cgColor

        return tableView
    }()
    
    private lazy var contentStackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .zero
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(tableView)
                
        return stackView
    }()
    
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
        title = viewModel.title
        
        // Setup view
        view.backgroundColor = Constants.Colors.background
        
        view.addSubviewUsingSafeArea(
            contentStackView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.regularSpacing,
                left: Constants.Sizes.mediumSpacing,
                bottom: Constants.Sizes.largeSpacing,
                right: Constants.Sizes.mediumSpacing
            ),
            ignoreBottomSafeArea: true
        )
        
        // Load avatar image
        avatarImageView.kf.setImage(with: viewModel.avatarURL)
        
        // Load the detail informations
        tableView.reloadData()
    }
}


// MARK: - UITableViewDataSource

extension ContactDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailItemRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.CellIdentifiers.contactDetailCellIdentifier,
            for: indexPath
        ) as? ContactDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let rowInformation = viewModel.detailItemRows[indexPath.row]
        cell.setup(contactDetailInformation: rowInformation)
        
        return cell
    }
}
