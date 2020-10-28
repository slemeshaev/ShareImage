//
//  UserProfileHeader.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 28.10.2020.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    // аватарка пользователя
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    // nickname пользователя
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Станислав Лемешаев"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "105\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "Публикации", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "315К\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "Подписчики", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "5\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "Подписки", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Редактировать профиль", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.grid.3x3"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "list.star"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // добавление аватарки на слой
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil,
                                paddingTop: 16, paddingLeft: 12, paddingBottom: 0, paddingRight: 0,
                                width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        // добавление никнейма на слой
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil,
                         paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 0)
        configureUserStats()
        // добавление кнопки редактирования профиля
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: self.rightAnchor,
                                 paddingTop: 12, paddingLeft: 5, paddingBottom: 0, paddingRight: 12,
                                 width: 0, height: 30)
        configureBottomToolBar()
    }
    
    // конфигурация нижней панели инструментов
    func configureBottomToolBar() {
        // вид верхнего разделителя
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        // вид нижнего разделителя
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 0.5)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                         paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                         width: 0, height: 0.5)
    }
    
    // конфигурация статистики пользователей
    func configureUserStats() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.axis = .horizontal
        //stackView.spacing = 5
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor,
                         paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 10,
                         width: 0, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
