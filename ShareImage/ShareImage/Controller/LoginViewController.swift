//
//  LoginViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 18.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    // создаем контейнер view для логотипа
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "ShareImage_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil,
                             paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                             width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
        return view
    }()

    // создаем текстовое поле для email
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    // создаем текстовое поле для пароля
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    // создаем кнопку для входа в приложение
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255,
                                         green: 204/255,
                                         blue: 244/255,
                                         alpha: 1)
        // добавляем действие для кнопки
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        // радиус для кнопки
        button.layer.cornerRadius = 5
        return button
    }()
    
    // создаем кнопку для перехода регистрации
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "У вас нет учетной записи?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Войти", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        // добавление действия кнопке
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        // установка атрибута для заголовка
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // цвет фона
        view.backgroundColor = .white
        
        // скрываем navigation bar
        navigationController?.navigationBar.isHidden = true
        
        // добавляем logoContainerView на view
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                 bottom: nil, right: view.rightAnchor,
                                 paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                                 width: 0, height: 150)
        configureViewComponents()
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                                     paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                                     width: 0, height: 50)
    }
    
    // метод перехода на экран регистрации
    @objc func handleShowSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    // метод действия для входа
    @objc func handleSignIn() {
        print("Handle sign in ....")
    }
    
    // проверка формы на валидность
    @objc func formValidation() {
        // гарантирует, что поля почты и пароля содержат текст
        guard emailTextField.hasText, passwordTextField.hasText else {
            signInButton.isEnabled = false
            signInButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            return
        }
        // условия были выполнены
        signInButton.isEnabled = true
        signInButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    
    // метод конфигурации view-компонентов
    private func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
                         paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40,
                         width: 0, height: 140)
    }

}
