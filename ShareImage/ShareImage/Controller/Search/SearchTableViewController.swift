//
//  SearchTableViewController.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 26.10.2020.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"

class SearchTableViewController: UITableViewController {
    
    // MARK: - Свойства
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // регистрация ячейки класса
        tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // вставка разделителя
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        
        // конфигурация контроллера навигаций
        configureNavController()
        
        // запрос юзеров
        fetchUsers()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        print("Username is \(user.username)")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    // MARK: - Обработчики
    func configureNavController() {
        navigationItem.title = "Поиск"
    }
    
    // MARK: - API
    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            // uid
            let uid = snapshot.key
            // кастим значение snapshot как словарь
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            // конструктор пользователя
            let user = User(uid: uid, dictionary: dictionary)
            // добавление пользователей в массив
            self.users.append(user)
            // обновление таблицы
            self.tableView.reloadData()
        }
    }

}
