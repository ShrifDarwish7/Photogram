//
//  AuthService.swift
//  InstagramClone
//
//  Created by Sherif Darwish on 11/22/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD

class AuthService {
    static func signUp(username : String, email : String , password : String, imgData : Data , Success : @escaping (Bool) -> Void , Failure : @escaping (String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil{
                writeUserData(username: username, email: email, password: password , userID: (result?.user.uid)!, imgData: imgData)
                Success(true)
            }else{
                Failure((error?.localizedDescription)!)
            }
        }
    }
    static func signIn(email : String , password : String , success : @escaping ()->Void , failure : @escaping (String) -> Void ){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil{
                success()
            }else{
                failure((error?.localizedDescription)!)
            }
        }
    }
    static func writeUserData(username : String, email : String , password : String , userID : String, imgData : Data){
        let ref = Storage.storage().reference().child("Users").child(userID)
        let uploadTask = ref.putData(imgData, metadata: nil) { (metaData, error) in
            if error == nil {
                ref.downloadURL(completion: { (url, error) in
                    if error == nil{
                        let user : [String : String] = ["UserName" : username , "Email" : email , "Profile_Picture" : (url?.absoluteString)! ]
                        let ref = Database.database().reference().child("Users").child(userID)
                        ref.setValue(user)
                        SVProgressHUD.dismiss()
                    }
                })
            }else{
                print("error uploading task")
            }
        }
        uploadTask.resume()
    }
//    static func uploadProfilePicture(id : String, imgData : Data)-> String{
//        var imgUrl = " "
//        let ref = Storage.storage().reference().child("Users").child(id)
//        let uploadTask = ref.putData(imgData, metadata: nil) { (metaData, error) in
//            if error == nil {
//                ref.downloadURL(completion: { (url, error) in
//                    if error == nil{
//                        let user : [String : String] = ["UserName" : username , "Email" : email , "Profile_Picture" : (url?.absoluteString)! ]
//                        let ref = Database.database().reference().child("Users").child(userID)
//                        ref.setValue(user)
//                        SVProgressHUD.dismiss()
//                    }
//                })
//            }else{
//                print("error uploading task")
//            }
//        }
//        uploadTask.resume()
//        return imgUrl
//    }
}
