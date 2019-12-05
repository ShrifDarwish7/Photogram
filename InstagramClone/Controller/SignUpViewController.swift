//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Sherif Darwish on 10/19/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignUpViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate,UITextFieldDelegate{

    @IBOutlet weak var ProfilePicImgView: UIImageView!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTxtField.delegate = self
        emailTxtField.delegate = self
        passwordTxtField.delegate = self

        ProfilePicImgView.layer.cornerRadius = 50
        signUpBtn.layer.cornerRadius = 5
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(handleGesture))
        ProfilePicImgView.addGestureRecognizer(gesture)
        
        signUpBtn.isEnabled = false
        signUpBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        usernameTxtField.addTarget(self, action: #selector(SignUpViewController.handleInvalidInputs), for: .editingChanged)
        emailTxtField.addTarget(self, action: #selector(SignUpViewController.handleInvalidInputs), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(SignUpViewController.handleInvalidInputs), for: .editingChanged)
    }
    
    @objc func handleInvalidInputs(){
        guard let name = usernameTxtField.text , !name.isEmpty , let email = emailTxtField.text , !email.isEmpty , let password = passwordTxtField.text , !password.isEmpty else {
            return
        }
        signUpBtn.isEnabled = true
        signUpBtn.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.8012895976)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTxtField.resignFirstResponder()
        emailTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        
        return true
    }

    @objc func handleGesture(){
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true, completion: nil)
    }
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        self.ProfilePicImgView.image = (info[UIImagePickerControllerEditedImage] as! UIImage)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        SVProgressHUD.show()
        let imgData = UIImagePNGRepresentation(ProfilePicImgView.image!)
        AuthService.signUp(username: usernameTxtField.text!, email: emailTxtField.text!, password: passwordTxtField.text!, imgData: imgData!, Success: {
            (success) in
            if success{
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
                print("Successful Signing up")
            }
        }) { (errorMsg) in
            SVProgressHUD.dismiss()
            self.popUpMsg(title: "Error", message: errorMsg)
        }
    }
}











