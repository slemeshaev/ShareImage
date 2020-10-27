//
//  FeedCollectionViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 26.10.2020.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // configure logout button
        configureLogoutButton()
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    // MARK: - Handles
    func configureLogoutButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        // создаем alert controller
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // добавление действия для alert
        alertController.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { (_) in
            do {
                // попытка разлогиниться
                try Auth.auth().signOut()
                // представление login controller
                let loginViewController = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
                print("Успешное разлогинивание user'a...")
            } catch {
                // обработка ошибки
                print("Не удалось выйти!")
            }
        }))
        // добавление действия отмены
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
