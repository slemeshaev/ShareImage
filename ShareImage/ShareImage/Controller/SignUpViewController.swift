//
//  SignUpViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 20.10.2020.
//

import UIKit

class SignUpViewController: UIViewController {

    // создаем кнопку для добавления фото в профиль
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_button").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    // создаем текстовое поле для email
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    // создаем текстовое поле для пароля
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    // создаем текстовое поле для полного имени
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя и фамилия"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    // создаем текстовое поле для псевдонима пользователя
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Псевдоним пользователя"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    // создаем кнопку для входа в приложение
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255,
                                         green: 204/255,
                                         blue: 244/255,
                                         alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // создаем кнопку для перехода на вход экрана
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "У вас уже есть учетная запись?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Войти", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        // добавление действия кнопке
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        // установка атрибута для заголовка
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // цвет фона
        view.backgroundColor = .white
        // добавление plusPhotoButton на view
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil,
                               paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                               width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // добавление конфигурации view-компонентов
        configureViewComponents()
        // добавление кнопки "вы уже зарегистрированы"
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                                        paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                                        width: 0, height: 50)
    }
    
    // метод перехода к контроллеру входа
    @objc func handleShowLogin() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // метод конфигурации view-компонентов
    private func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,
                                                       fullNameTextField, nickNameTextField, signUpButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
                         paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40,
                         width: 0, height: 240)
    }

}
