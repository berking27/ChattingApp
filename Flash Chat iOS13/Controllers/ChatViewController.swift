//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
     
     @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var messageTextfield: UITextField!
     
     let db = Firestore.firestore()
     
     var messages : [Message] = []
     
     override func viewDidLoad() {
          super.viewDidLoad()
          NavigationDesign().navigationSetting(naviController: self)
          
          tableView.dataSource = self
          title = K.appName
          navigationItem.hidesBackButton = true //You can hide back button
          
          tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)//Go to MessageCell-> Identifier and name it to use here as a identifier.
          
          loadMessages()
          
     }
     
     func loadMessages(){
          //Instead of AddSnapshotListener we can use getDocumnets but it will only retrieve data once it wont remain updated
          db.collection(K.FStore.collectionName)
               .order(by: K.FStore.dateField) //Order the messages by their sending date
               .addSnapshotListener { [self] (querySnapshot, error) in
                    
                    messages = [] //I declare inside the addSnapshotListener otherwise when ı try to add new message it will show me all messages again and again.
                    
                    if let e = error{
                         print("There is a issue retrieving data from firestore \(e)")
                    }else{
                         if let snapshotDocumnets = querySnapshot?.documents{
                              for doc in snapshotDocumnets {
                                   let data = doc.data()
                                   //I use as? because ı want to change my data type any to String.
                                   if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                        let newMessage = Message(sender: messageSender, body: messageBody)
                                        self.messages.append(newMessage)
                                        
                                        DispatchQueue.main.async {//When you try to update View Don't forget use DispatchQueue
                                             self.tableView.reloadData()
                                             
                                             
                                             let indexPath = IndexPath(row: self.messages.count - 1 , section: 0)
                                             
                                             self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                        }
                                        
                                   }
                                   
                                   
                              }
                         }
                    }
               }
     }
     
     @IBAction func sendPressed(_ sender: UIButton) {
          
          if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email {
               db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender,
                                                                         K.FStore.bodyField: messageBody,
                                                                         K.FStore.dateField:Date().timeIntervalSince1970
                                                                        ]) { (error) in
                    if let e = error{
                         print("There was a mistake Saving data to firestore \(e)")
                    }else{
                         print("Succesfully saved data.")
                         
                         DispatchQueue.main.async {
                              self.messageTextfield.text = ""
                         }
                         
                    }
               }
          }
          
          
     }
     
     @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
          do {
               try Auth.auth().signOut()
               navigationController?.popToRootViewController(animated: true) //When you press Log out it will direct you to main page of your App
          } catch let signOutError as NSError {
               print("Error signing out: %@", signOutError)
          }
          
     }
     
}

extension ChatViewController : UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return messages.count
     } //How many cell it needs
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let message = messages[indexPath.row]
          
          let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
          as! MessageCell
          cell.label.text = message.body
          
          //This is a message from the current user
          if message.sender == Auth.auth().currentUser?.email{
               cell.leftImageView.isHidden = true
               cell.rightImageView.isHidden = false
               cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
               cell.label.textColor = UIColor(named: K.BrandColors.yellow)
          }
          //This is a message from a diff user
          else{
               cell.leftImageView.isHidden = false
               cell.rightImageView.isHidden = true
               cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
               cell.label.textColor = UIColor(named: K.BrandColors.yellow)
          }
          
          
          return cell
     }
}


