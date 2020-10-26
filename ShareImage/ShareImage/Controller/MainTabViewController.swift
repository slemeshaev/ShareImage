//
//  MainTabViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 26.10.2020.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        self.delegate = self
        
        // configure view controllers
        configureViewControllers()
    }
    
    // функция для создания контроллера представления
    // который существует в контроллере панели вкладок
    func configureViewControllers() {
        
        // home feed controller
        let feedVC = constructNavController(unselectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: FeedCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        // search feed controller
        let searchVC = constructNavController(unselectedImage: UIImage(systemName: "magnifyingglass.circle")!, selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!, rootViewController: SearchTableViewController())
        // post controller
        let uploadPostVC = constructNavController(unselectedImage: UIImage(systemName: "icloud.and.arrow.up")!, selectedImage: UIImage(systemName: "icloud.and.arrow.up.fill")!, rootViewController: UploadPostViewController())
        // notification controller
        let notificationVC = constructNavController(unselectedImage: UIImage(systemName: "heart")!, selectedImage: UIImage(systemName: "heart.fill")!, rootViewController: NotificationTableViewController())
        
        // profile controller
        let userProfileVC = constructNavController(unselectedImage: UIImage(systemName: "person.circle")!, selectedImage: UIImage(systemName: "person.circle.fill")!, rootViewController: UserProfileCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // view controller должен быть добавлен в tabbar controller
        viewControllers = [feedVC, searchVC, uploadPostVC, notificationVC, userProfileVC]
        
        // tab bar tint color
        tabBar.tintColor = .black
    }
    
    // создать navigation controllers
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // создаем navigation controller
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.navigationBar.tintColor = .black
        
        // возвращаем navigation controller
        return navigationController
    }

}
