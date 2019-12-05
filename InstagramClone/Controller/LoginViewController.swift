//
//  ViewController.swift
//  InstagramClone
//
//  Created by Sherif Darwish on 10/19/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        
        logInBtn.isEnabled = false
        logInBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        emailTxtField.addTarget(self, action: #selector(LoginViewController.handleInvalidInputs), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(LoginViewController.handleInvalidInputs), for: .editingChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            SVProgressHUD.show(UIImage(), status: "Loging ... ")
            performSegue(withIdentifier: "goToMain", sender: self)
        }
        SVProgressHUD.dismiss()
    }
    
    @objc func handleInvalidInputs(){
        guard let email = emailTxtField.text , !email.isEmpty , let password = passwordTxtField.text , !password.isEmpty else {
            return
        }
        logInBtn.isEnabled = true
        logInBtn.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.8012895976)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func login(_ sender: UIButton) {
        SVProgressHUD.show()
        AuthService.signIn(email: emailTxtField.text!, password: passwordTxtField.text!, success: {
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "goToMain", sender: self)
        }) { (error) in
            SVProgressHUD.dismiss()
            self.popUpMsg(title: "Error", message: error)
        }
        
    }
    

}

