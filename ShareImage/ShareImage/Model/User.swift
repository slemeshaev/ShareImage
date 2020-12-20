//
//  User.swift
//  ShareImage
//
//  Created by Станислав Лемешаев on 29.10.2020.
//

import Firebase

class User {
    // атрибуты
    var username: String!
    var name: String!
    var profileImageUrl: String!
    var isFollowed = false
    var uid: String!
    
    init(uid: String, dictionary: Dictionary<String, AnyObject>) {
        self.uid = uid
        
        if let username = dictionary["username"] as? String {
            self.username = username
        }
        
        if let name = dictionary["fullname"] as? String {
            self.name = name
        }
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = profileImageUrl
        }
        
    }
    
    // метод подписки
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        // получить такой uid для работы с обновлением
        guard let uid = uid else { return }
        
        // установить подписку в значение true
        self.isFollowed = true
        
        // добавить подписавшегося пользователя к текущей структуре пользователь-подписавшийся
        USER_FOLLOWING_REF.child(currentUid).updateChildValues([uid: 1])
        
        // добавить текущего пользователя к структуре пользователь-подписчик
        USER_FOLLOWER_REF.child(uid).updateChildValues([currentUid: 1])
        
        // загрузка уведомления подписки на сервер
        uploadFollowNotificationToServer()
        
        // добавление постов подписавшихся пользователей к текущей ленте пользователя
        USER_POST_REF.child(uid).observe(.childAdded) {(snapshot) in
            let postId = snapshot.key
            USER_FEED_REF.child(currentUid).updateChildValues([postId: 1])
        }
    }
    
}
