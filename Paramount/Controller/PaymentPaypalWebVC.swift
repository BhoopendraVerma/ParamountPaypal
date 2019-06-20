//
//  PaymentPaypalWebVC.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 05/06/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit

class PaymentPaypalWebVC: UIViewController,UIWebViewDelegate,UITextFieldDelegate {
    @IBOutlet var paypalWebview: UIWebView!
    
    var check = String()
    var cardNumber = String()
    var expireDate = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        check = "none"

        
        let url = NSURL (string: "http://rafflticket.co.uk/webroot/paypal_integration_php/products.php");
        let request = NSURLRequest(url: url! as URL);
        paypalWebview.loadRequest(request as URLRequest);
        paypalWebview.keyboardDisplayRequiresUserAction = true
        
        let name = "12345678901234"
        var js = "var textfield = document.getElementById('cc');\n"
        js += "textfield.value = '" + name + "';"
        
        paypalWebview.stringByEvaluatingJavaScript(from: js)
        
        paypalWebview.stringByEvaluatingJavaScript(from: "document.getElementById('expiry_value').value = '12/25'")
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
        self,
        selector: #selector(textFieldTextChanged(_:)),
        name:UITextField.textDidChangeNotification,
        object: nil
        )
        
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(keyboardWillShowNotification(_:)),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(keyboardWillHideNotification(_:)),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
        let name2 = "yyyyyyyy"
        var js2 = "var textfield = document.getElementById('cc');\n"
        js2 += "textfield.value = '" + name2 + "';"
        self.paypalWebview.stringByEvaluatingJavaScript(from: js2)

    }
    
    @objc func showSpinningWheel(_ notification: NSNotification)
    {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary?
        {
        print(dict)
        }
    }
    @objc
    func keyboardWillShowNotification(_ notification: NSNotification) {
    
        self.getCardData()
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: NSNotification) {
        print("HIDE")
    }
  
    func getCardData()  {
        let service = ServerHandler()
        service .serviceRequest(withInfo: nil, serviceType: ServiceTypeGetCardDetails, params: nil) { (response, error) in
            print(response as Any)
            
            var dict = NSDictionary()
            dict = response as! NSDictionary
            print(dict)

            //   let name = "12345678901234"
            var nameStr = String()
            nameStr = dict .value(forKey: "card_number") as! String
            
            if nameStr == ""
            {
                print("DATA NOT FOUND")
            }
            else
            {
                let name = nameStr
              //  let name = "4335 8778 6426 0400"

                var js = "var textfield = document.getElementById('cc');\n"
                js += "textfield.value = '" + name + "';"
                self.paypalWebview.stringByEvaluatingJavaScript(from: js)
            }
            
            var expireStr = String()
            expireStr = dict .value(forKey: "expiry_date") as! String
            if expireStr == ""
            {
                print("DATA NOT FOUND")
            }
            else
            {
                let expireDate = expireStr
                var js1 = "var textfield = document.getElementById('expiry_value');\n"
                js1 += "textfield.value = '" + expireDate + "';"
                self.paypalWebview.stringByEvaluatingJavaScript(from: js1)
            }
        }
        
    }
    
    
    @objc
    func textFieldTextChanged(_ notification: NSNotification) {
        print("TEXT FIELD")

        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
    }
    func textFieldDidChange(_ textField: Notification) {
        //your code
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        let script = "document.documentElement.style.webkitUserSelect='none'"
        if let returnedString = paypalWebview.stringByEvaluatingJavaScript(from: script) {
            print("the result is \(returnedString)")
        }
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if request.url?.scheme == "none" {
            print("NONE")
            if request.url?.host == "home" {
                // do something
            }
        }
                return true
    }

       @IBAction func backBTN(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
