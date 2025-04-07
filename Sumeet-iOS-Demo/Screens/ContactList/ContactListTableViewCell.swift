//
//  ContactListTableViewCell.swift
//  Sumeet-iOS-Demo
//
//  Created by Salah Eddine KAHACK on 06/04/2025.
//

import UIKit
import Kingfisher


class ContactListTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private lazy var avatarImageView: UIImageView = {
        
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = Constants.Sizes.ContactList.thumbnailCornerRadius
        avatarImageView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Sizes.ContactList.thumbnailSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Sizes.ContactList.thumbnailSize)
        ])
        
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = Constants.Colors.borderColor.cgColor
        
        return avatarImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.numberOfLines = 1
        return nameLabel
    }()
    
    private lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.font = .preferredFont(forTextStyle: .subheadline)
        phoneLabel.numberOfLines = 1
        return phoneLabel
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.font = .preferredFont(forTextStyle: .footnote)
        emailLabel.numberOfLines = 1
        emailLabel.textColor = Constants.Colors.secondary
        return emailLabel
    }()
        
    private lazy var contentStackView: UIStackView = {
        
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.spacing = Constants.Sizes.tinySpacing
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(phoneLabel)
        textStackView.addArrangedSubview(emailLabel)
        
        let textView = UIView()
        textView.addCenteredSubview(textStackView, minInsets: .zero, axis: .vertical)
        
        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.spacing = Constants.Sizes.regularSpacing
        contentStackView.addArrangedSubview(avatarImageView)
        contentStackView.addArrangedSubview(textView)
        
        return contentStackView
    }()
    
    private lazy var containerView: UIView = {
        
        let containerView = UIView()
        
        containerView.addSubview(
            contentStackView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.regularSpacing,
                left: Constants.Sizes.regularSpacing,
                bottom: Constants.Sizes.regularSpacing,
                right: Constants.Sizes.regularSpacing
            )
        )
        
        containerView.backgroundColor = Constants.Colors.contentBackground
        containerView.layer.cornerRadius = Constants.Sizes.cornerRadius
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = Constants.Colors.borderColor.cgColor
        
        return containerView
    }()
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(
            containerView,
            insets: UIEdgeInsets(
                top: Constants.Sizes.tinySpacing,
                left: Constants.Sizes.regularSpacing,
                bottom: Constants.Sizes.tinySpacing,
                right: Constants.Sizes.regularSpacing
            )
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        nameLabel.text = nil
        phoneLabel.text = nil
        emailLabel.text = nil
    }
    
    // MARK: - Methods
    
    func setup(contact: ContactListItem) {
        
        avatarImageView.kf.setImage(with: contact.thumbnailURL)
        nameLabel.text = contact.fullname
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
    }
    
    // MARK: - Actions
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            
            UIView.animate(
                withDuration: 0.25,
                delay: .zero,
                options: [.curveEaseOut, .allowUserInteraction],
                animations: {
                    self.contentView.alpha = 0.7
                    self.transform = CGAffineTransform(scaleX: 0.99, y: 0.98)
                },
                completion: { _ in
                    UIView.animate(
                        withDuration: 0.25,
                        delay: .zero,
                        options: [.curveEaseOut, .allowUserInteraction],
                        animations: {
                            self.contentView.alpha = 1
                            self.transform = .identity
                        },
                        completion: nil
                    )
                }
            )
        }
    }
}
