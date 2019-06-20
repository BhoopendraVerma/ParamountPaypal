//
//  ViewController.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 27/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit
//import SVProgressHUD

class ViewController: UIViewController,UITextFieldDelegate {
    var service = ServerHandler()
    var appd = AppDelegate()
    
    
    @IBOutlet var phoneNmbrView: UIView!
    @IBOutlet var pinView: UIView!
    @IBOutlet var mobileTF: UITextField!
    @IBOutlet var pinTF: UITextField!
    @IBOutlet var loginBTN: UIButton!
    @IBOutlet var forgetBTN: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
       
        forgetBTN .isHidden = true
        self.setButton(button: loginBTN, width: 0, radius: loginBTN.frame.height/2, borderColor: UIColor.clear)
        setDoneOnKeyboard()
      //  self.serviceGetNewData()
    }
    
    @IBAction func loginBTN(_ sender: UIButton)
    {
        guard let phone = mobileTF.text, phone != "" else {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Please enter your phone number.")
            return
        }
        guard let pin = pinTF.text, pin != "" else {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Please enter your 4 digit pin.")
            return
        }
        if mobileTF.text?.isValidContact ?? true {
            self.coonectiionCheck()
        }
        else
        {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Please enter your valid mobile number.")
        }
    }
    
    func coonectiionCheck()
    {
        if ConnectionCheck.isConnectedToNetwork()
        {
            UserDefaults.standard .setValue("UserLogin", forKey: "checkLogin")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Internet Connection not Available!")
        }
    }
    
    @IBAction func forgetPasswordBTN(_ sender: UIButton) {
      
    }
    
 // textField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("IPHONE 5,5S,5C")
                if textField==mobileTF
                {
                    animateViewMoving(up: true, moveValue: 120)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: true, moveValue: 150)//125
                }
            case 1334:
                print("IPHONE 6,7,8 IPHONE 6S,7S,8S ")
                if textField==mobileTF
                {
                    animateViewMoving(up: true, moveValue: 90)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: true, moveValue: 140)//125
                }
            case 1920, 2208:
                print("IPHONE 6PLUS, 6SPLUS, 7PLUS, 8PLUS")
                if textField==mobileTF
                {
                    animateViewMoving(up: true, moveValue: 80)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: true, moveValue: 130)//125
                }
            case 2436:
                print("IPHONE X, IPHONE XS")
                
                if textField==mobileTF
                {
                    animateViewMoving(up: true, moveValue: 130)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: true, moveValue: 190)//125
                }
            case 2688:
                print("IPHONE XS_MAX")
                if textField==mobileTF
                {
                    animateViewMoving(up: true, moveValue: 130)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: true, moveValue: 190)//125
                }
            case 1792:
                print("IPHONE XR")
            default:
                if textField==mobileTF
                {
                    animateViewMoving(up: true, moveValue: 130)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: true, moveValue: 190)//125
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("IPHONE 5,5S,5C")
                if textField==mobileTF
                {
                    animateViewMoving(up: false, moveValue: 120)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: false, moveValue: 150)//125
                }
            case 1334:
                print("IPHONE 6,7,8 IPHONE 6S,7S,8S ")
                if textField==mobileTF
                {
                    animateViewMoving(up: false, moveValue: 90)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: false, moveValue: 140)//125
                }
            case 1920, 2208:
                print("IPHONE 6PLUS, 6SPLUS, 7PLUS, 8PLUS")
                if textField==mobileTF
                {
                    animateViewMoving(up: false, moveValue: 80)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: false, moveValue: 130)//125
                }
            case 2436:
                print("IPHONE X, IPHONE XS")
                if textField==mobileTF
                {
                    animateViewMoving(up: false, moveValue: 130)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: false, moveValue: 190)//125
                }
            case 2688:
                print("IPHONE XS_MAX")
                if textField==mobileTF
                {
                    animateViewMoving(up: false, moveValue: 130)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: false, moveValue: 190)//125
                }
            case 1792:
                print("IPHONE XR")
            default:
                print("UNDETERMINED")
                if textField==mobileTF
                {
                    animateViewMoving(up: false, moveValue: 130)
                }
                else if textField==pinTF
                {
                    animateViewMoving(up: false, moveValue: 190)//125
                }
            }
        }
    }
    
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pinTF {
            let textstring = (pinTF.text! as NSString).replacingCharacters(in: range, with: string)
            let length = textstring.count
            if length > 4 {
                pinTF .resignFirstResponder()
                return false
            }
        }
        else if (textField == mobileTF)
        {
            let textstring = (mobileTF.text! as NSString).replacingCharacters(in: range, with: string)
            let length = textstring.count
            if length > 10 {
                mobileTF .resignFirstResponder()
                return false
            }
        }
        return true
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        mobileTF.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func serviceGetNewData()  {
        let service = ServerHandler()
        service .serviceRequest(withInfo: nil, serviceType: ServiceTypeGetCurrency, params: nil) { (response, errror) in
            print(response as Any)
            var dicto = NSDictionary()
            var dict = NSDictionary()
            dicto = response as! NSDictionary
            dict = dicto .value(forKey: "rates") as! NSDictionary
            print(dict)
        UserDefaults.standard .setValue(dict, forKey: "currencyRate")
            
        }
    }
}

extension  UIViewController
{
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}

