//
//  PopUpMsg.swift
//  InstagramClone
//
//  Created by Sherif Darwish on 11/12/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func popUpMsg(title : String , message : String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Dissmiss", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
   
}
