//
//  ProfileViewViewController.swift
//  InstagramClone
//
//  Created by Sherif Darwish on 11/21/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SDWebImage

class ProfileViewViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserInfo()
    }

    func setUserInfo(){
        if let currentUser = Auth.auth().currentUser {
            let ref = Database.database().reference().child("Users").child(currentUser.uid)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                let values = snapshot.value as! Dictionary<String, Any>
                let url = values["Profile_Picture"] as! URL
                self.profilePic!.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "man-user"))
                self.username.text = (values["Username"] as! String)
            }
        }
    }
    
    @IBAction func editProfile(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileVC")
        present(vc, animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: UIButton) {
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        SVProgressHUD.show()
        do{
            try Auth.auth().signOut()
            SVProgressHUD.dismiss()
            let storyboard = UIStoryboard.init(name: "Start", bundle: nil)
            let signinVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
            present(signinVC, animated: true, completion: nil)
        }catch let error {
            SVProgressHUD.dismiss()
            self.popUpMsg(title: "Logout Failed", message: error.localizedDescription)
        }
    }
    
}
