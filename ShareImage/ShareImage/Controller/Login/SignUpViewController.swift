//
//  SignUpViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 20.10.2020.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var imageSelected = false

    // создаем кнопку для добавления фото в профиль
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_button").withRenderingMode(.alwaysOriginal), for: .normal)
        // добавление действия для кнопки
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        return button
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
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    // создаем текстовое поле для полного имени
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя и фамилия"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    // создаем текстовое поле для псевдонима пользователя
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Псевдоним пользователя"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
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
        button.isEnabled = false
        // добавление действия для кнопки
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
    
    // метод действия для регистрации
    @objc func handleSignUp() {
        // properties
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let nickname = nickNameTextField.text else { return }
        // set Profile image
        guard let profileImage = self.plusPhotoButton.imageView?.image else { return }
        
        // place image in firebase storage
        let profileImageUID = NSUUID().uuidString
        
        // create an instance of the Storage to store
        let storageRef = Storage.storage().reference().child("profile_images").child(profileImageUID)
        
        // convert selected image to jpeg since Firebase only accept that
        guard let uploadData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // обработка ошибки
            if let error = error {
                print("Failed to create user with error: \(error.localizedDescription)")
                return
            }
            
            // upload image to storage
            storageRef.putData(uploadData, metadata: nil) {(metaData, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                // download the imageURL string
                storageRef.downloadURL { (imageUrl, error) in
                    // profile image url
                    guard let profileImageURL = imageUrl?.absoluteString else { return }
                    
                    // user id
                    guard let uid = user?.user.uid else { return }
                    
                    let dictionaryValues = ["photo UID": profileImageUID,
                                            "profileImageUrl": profileImageURL,
                                            "email": email,
                                            "password": password,
                                            "fullname": fullName,
                                            "nickname": nickname]
                    
                    let values = [uid: dictionaryValues]
                    
                    // save user info to database
                    Database.database().reference().child("users").updateChildValues(values) { (error, ref) in
                        print("Пользователь создан!")
                    }
                }
                
            }
        }
    }
    
    // метод перехода к контроллеру входа
    @objc func handleShowLogin() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // проверка формы на валидность
    @objc func formValidation() {
        guard emailTextField.hasText,
              passwordTextField.hasText,
              fullNameTextField.hasText,
              nickNameTextField.hasText,
              imageSelected == true else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            return
        }
        
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
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

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // selected image
        guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        // set imageSelected to true
        imageSelected = true
        
        // configure plusPhotoButton with selected image
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.lightGray.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelectProfilePhoto() {
        // configure image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // present image picker
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
}
