//
//  Constansts.swift
//  Flash Chat iOS13
//
//  Created by Berkin Koca on 28.01.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

struct K {
     static let appName = "FlashChat⚡️"
     static let cellIdentifier = "ReusableCell"
     static let cellNibName = "MessageCell"
     static let registerSegue = "RegisterToChat"
     static let loginSegue = "LoginToChat"
     
     struct BrandColors {
          static let purple = "BrandPurple"
          static let lightPurple = "BrandLightPurple"
          static let blue = "BrandBlue"
          static let lightBlue = "BrandLightBlue"
          static let yellow = "Yellow"
     }
     
     struct FStore {
          static let collectionName = "messages"
          static let senderField = "sender"
          static let bodyField = "body"
          static let dateField = "date"
     }
}
