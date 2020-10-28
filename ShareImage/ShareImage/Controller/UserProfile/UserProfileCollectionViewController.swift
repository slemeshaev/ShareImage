//
//  UserProfileCollectionViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 26.10.2020.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let headerIdentifier = "UserProfileHeader"

class UserProfileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Свойства
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        // background color
        self.collectionView?.backgroundColor = .white
        
        // запрос данных пользователя
        fetchCurrentUserData()
    }

    // MARK: - UICollectionView

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // объявление header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
        // возращение заголовка
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: - API
    func fetchCurrentUserData() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUid).child("nickname").observeSingleEvent(of: .value) { (snapshot) in
            guard let nickname = snapshot.value as? String else { return }
            self.navigationItem.title = nickname
        }
    }



}
