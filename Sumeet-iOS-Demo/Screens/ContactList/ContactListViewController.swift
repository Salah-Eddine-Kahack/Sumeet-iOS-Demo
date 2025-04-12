//
//  ContactListViewController.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit
import Combine


class ContactListViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: ContactListViewModel
    private var cancellables = Set<AnyCancellable>()
    private var isViewVisible: Bool = false
    
    // MARK: - UI Components
    
    private lazy var refreshLoader: ButtonViews.LoaderWithIcon = {
        ButtonViews.LoaderWithIcon { [weak self] in
            guard let self else { return }
            self.viewModel.loadContacts(.refresh)
        }
    }()
    
    private lazy var errorLabel: UILabel = {
        
        let errorLabel = UILabel()
        errorLabel.numberOfLines = .zero
        errorLabel.textAlignment = .center
        errorLabel.textColor = Constants.Colors.criticalText
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        
        return errorLabel
    }()
    
    private lazy var errorView: UIView = {
        
        let errorLabelContainerView = UIView()
        errorLabelContainerView.backgroundColor = Constants.Colors.criticalBackground
        
        errorLabelContainerView.addSubview(
            errorLabel,
            insets: Constants.Sizes.buttonEdgeInsets
        )
        
        errorLabelContainerView.layer.cornerRadius = Constants.Sizes.cornerRadius
        errorLabelContainerView.layer.masksToBounds = true
        
        let errorView = UIView()
        errorView.isHidden = true // Hide by default
        
        errorView.addSubview(
            errorLabelContainerView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.smallSpacing,
                left: Constants.Sizes.mediumSpacing,
                bottom: Constants.Sizes.regularSpacing,
                right: Constants.Sizes.mediumSpacing
            )
        )
        
        return errorView
    }()
    
    private lazy var loadButton: ButtonViews.LoaderWithTitle = {
        
        let loadButton = ButtonViews.LoaderWithTitle(
            title: Constants.Texts.ContactList.loadContactsButtonTitle,
            action: { [weak self] in
                guard let self else { return }
                self.viewModel.loadContacts(.initial)
            }
        )
        
        NSLayoutConstraint.activate([
            loadButton.widthAnchor.constraint(equalToConstant: Constants.Sizes.ContactList.loadButtonWidth),
        ])
        
        return loadButton
    }()
    
    private lazy var emptyView: UIView = {
        
        let iconView = UIImageView(image: Constants.Icons.noContacts)
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Constants.Colors.secondary
        
        let emptyLabel = UILabel()
        emptyLabel.text = Constants.Texts.ContactList.emptyMessage
        emptyLabel.numberOfLines = .zero
        emptyLabel.textColor = Constants.Colors.secondary
        emptyLabel.font = .preferredFont(forTextStyle: .subheadline)
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = Constants.Sizes.regularSpacing
        infoStackView.addArrangedSubview(iconView)
        infoStackView.addArrangedSubview(emptyLabel)
        
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
        stackView.spacing = .zero
    
        stackView.addArrangedSubview(errorView)
        stackView.addArrangedSubview(emptyView)
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
        setupObservers()
        viewModel.loadCache()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isViewVisible = true
        updateUI(for: viewModel.state, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isViewVisible = false
        refreshLoader.alpha = .zero
        refreshLoader.isHidden = true
    }

    // MARK: - Methods
    
    private func setupUI() {
        
        // Setup navigatiom bar
        UIHelper.configureCustomNavigationBarFont(viewController: self)
        title = Constants.Texts.ContactList.title
        setupRefreshNavigationBarButton()
        
        // Setup view
        view.backgroundColor = Constants.Colors.background
        
        // Setup content
        view.addSubviewUsingSafeArea(
            contentStackView,
            insets: .zero,
            ignoreBottomSafeArea: true
        )
    }
    
    /// Adds a custom view that works like a UIBarButtonItem
    private func setupRefreshNavigationBarButton() {
        
        guard let navigationBar = navigationController?.navigationBar
        else {
            Logger.log("Navigation bar not found", level: .warning)
            return
        }
        
        refreshLoader.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(refreshLoader)

        NSLayoutConstraint.activate([
            // Set custon size
            refreshLoader.widthAnchor.constraint(equalToConstant: Constants.Sizes.NavigationBar.customButtonIcon),
            refreshLoader.heightAnchor.constraint(equalToConstant: Constants.Sizes.NavigationBar.customButtonIcon),
            // Set custom insets
            refreshLoader.topAnchor.constraint(
                equalTo: navigationBar.topAnchor,
                constant: Constants.Sizes.NavigationBar.customButtonTopSpacing
            ),
            refreshLoader.trailingAnchor.constraint(
                equalTo: navigationBar.trailingAnchor,
                constant: -Constants.Sizes.NavigationBar.customButtonPadding
            ),
        ])
    }
    
    private func setupObservers() {
        
        // Listen to content changes combined with state updates
        Publishers.CombineLatest(
            viewModel.$contactItems,
            viewModel.$state
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] contacts, state in
            
            guard let self else { return }

            // Determine reloading behavior
            let shouldReloadWithoutAnimations: Bool = {
                switch state {
                    case .loading, .error:  return true
                    case .ready(let source) where source == .infiniteScroll: return true
                    default: return false
                }
            }()

            // Reload the list
            if shouldReloadWithoutAnimations {
                tableView.reloadData()
            }
            else if !contacts.isEmpty {
                
                tableView.reloadSections([.zero], with: .fade)
                
                tableView.scrollToRow(
                    at: IndexPath(row: .zero, section: .zero),
                    at: .top,
                    animated: true
                )
            }
        }
        .store(in: &cancellables)
        
    
        // Listen to state changes only
        viewModel.$state
        .receive(on: DispatchQueue.main)
        .sink { [weak self] state in
            guard let self else { return }
            self.updateUI(for: state, animated: true)
        }
        .store(in: &cancellables)
    }
    
    private func updateUI(for state: ContactListState, animated: Bool) {
        
        // Handle loaders
        if case .loading(let type) = state {
            switch type {
                case .initial: loadButton.toggleLoading(on: true)
                case .refresh: refreshLoader.toggleLoading(on: true)
                default: break
            }
        }
        else {
            loadButton.toggleLoading(on: false)
            refreshLoader.toggleLoading(on: false)
        }
        
        // Handle visibility
        switch state {
                
            case .loading(let type):
                refreshLoader.isHidden = !isViewVisible || type == .initial
                tableView.isHidden = type == .initial
                emptyView.isHidden = type != .initial

            case .ready:
                refreshLoader.isHidden = !isViewVisible
                errorView.isHidden = true
                tableView.isHidden = viewModel.contactItems.isEmpty
                emptyView.isHidden = !viewModel.contactItems.isEmpty

            case .empty:
                refreshLoader.isHidden = true
                errorView.isHidden = true
                tableView.isHidden = true
                emptyView.isHidden = false

            case .error(let source, let message):
                refreshLoader.isHidden = !isViewVisible || source == .initial
                errorView.isHidden = false
                errorLabel.text = message
        }
                
        // Animate changes
        UIHelper.animateUIChanges(duration: animated ? .medium : .none) {
            self.contentStackView.layoutIfNeeded()
            self.errorView.alpha = self.errorView.isHidden ? .zero : 1.0
            self.emptyView.alpha = self.emptyView.isHidden ? .zero : 1.0
            self.tableView.alpha = self.tableView.isHidden ? .zero : 1.0
            self.refreshLoader.alpha = self.refreshLoader.isHidden ? .zero : 1.0
        }
    }
}

// MARK: - UITableViewDataSource

extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contactItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.CellIdentifiers.contactListCellIdentifier,
            for: indexPath
        ) as? ContactListTableViewCell else {
            return UITableViewCell()
        }
        
        let contact = viewModel.contactItems[indexPath.row]
        cell.setup(contact: contact)
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let contact = viewModel.contactItems[indexPath.row]
        viewModel.handleContactSelection(selectedContactItem: contact)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Calculate distance from the bottom of the list
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.size.height
        let distanceFromBottom = contentHeight - contentOffsetY - visibleHeight

        // Load when getting close to the bottom and not already loading
        if distanceFromBottom < Constants.Sizes.ContactList.infiniteScrollThreshold {
            viewModel.loadContacts(.infiniteScroll)
        }
    }
}
