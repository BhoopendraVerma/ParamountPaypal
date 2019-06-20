//
//  CurrencyConvertVC.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 29/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit

class CurrencyConvertVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var historyTbleView: UITableView!
    var dictoo: NSDictionary?
    var myArrayOfDict: NSArray?
    var currencyArr = [String: String]()
    var dataArray = [String]()
    
    var service = ServerHandler()
    var appd = AppDelegate()
     var countrySymble = String()
    
    let currencyConverter = CurrencyConverter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
        
        myArrayOfDict = [
            ["countryCode": "AUD", "countryName": "Australian Dollar", "countrySymble":"$"],
            ["countryCode": "BRL", "countryName": "Brazilian Real", "countrySymble":"R$"],
            //  ["countryCode": "BGN", "countryName": "Bulgarian lev", "countrySymble":"Лв"],
            ["countryCode": "CAD", "countryName": "Canadian dollar", "countrySymble":"$"],
            ["countryCode": "CHF", "countryName": "Switzerland", "countrySymble":"Fr."],
            //  ["countryCode": "CNY", "countryName": "China, Zimbabwe", "countrySymble":"¥"],
            ["countryCode": "CZK", "countryName": "Czechia", "countrySymble":"Kč"],
            ["countryCode": "DKK", "countryName": "Denmark", "countrySymble":"Kr."],
            ["countryCode": "EUR", "countryName": "Germany, France", "countrySymble":"€"],
            ["countryCode": "GBP", "countryName": "United Kingdom, England", "countrySymble":"£"],
            ["countryCode": "HKD", "countryName": "Hong Kong dollar", "countrySymble":"$"],
            //    ["countryCode": "HRK", "countryName": "Europe", "countrySymble":"kn"],
            ["countryCode": "HUF", "countryName": "Hungary", "countrySymble":"Ft"],
            //    ["countryCode": "IDR", "countryName": "Indonesia", "countrySymble":"Rp"],
            ["countryCode": "ILS", "countryName": "Israel, Palestine, Palestinian territories", "countrySymble":"₪"],
              ["countryCode": "INR", "countryName": "India, Bhutan, Zimbabwe, Tibet", "countrySymble":"₹"],
            //    ["countryCode": "ISK", "countryName": "Iceland", "countrySymble":"kr"],
            ["countryCode": "JPY", "countryName": "Japan", "countrySymble":"¥"],
            //   ["countryCode": "KRW", "countryName": "South Korea, Korea", "countrySymble":"₩"],
            ["countryCode": "MXN", "countryName": "Mexico", "countrySymble":"$"],
            ["countryCode": "MYR", "countryName": "Malaysia", "countrySymble":"RM"],
            ["countryCode": "NOK", "countryName": "Norway, Quisling regime", "countrySymble":"kr"],
            ["countryCode": "NZD", "countryName": "New Zealand, Cook Islands, Niue, Pitcairn Islands, Tokelau", "countrySymble":"$"],
            ["countryCode": "PHP", "countryName": "Philippines", "countrySymble":"₱"],
            ["countryCode": "PLN", "countryName": "Poland", "countrySymble":"zł"],
            //    ["countryCode": "RON", "countryName": "Romania", "countrySymble":"RON"],
            ["countryCode": "RUB", "countryName": "Russian", "countrySymble":"₱"],
            ["countryCode": "SEK", "countryName": "Sweden", "countrySymble":"kr"],
            ["countryCode": "SGD", "countryName": "Singapore", "countrySymble":"$"],
            ["countryCode": "THB", "countryName": "Thailand", "countrySymble":"฿"],
            ["countryCode": "TRY", "countryName": "Turkey", "countrySymble":"₺"],
            ["countryCode": "USD", "countryName": "United States, Netherlands", "countrySymble":"$"],
            //    ["countryCode": "ZAR", "countryName": "South Africa, Zimbabwe", "countrySymble":"R"],
            
        ]//Not to be confused with ₱. Germany, France, Italy, Spain, Portugal, Greece, MORE
        
        
        // Do any additional setup after loading the view.
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   return images.count
        return myArrayOfDict!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTbleView.dequeueReusableCell(withIdentifier: "Cell")!  as! CustomTableViewCell
        
        var countryCode = String()
        countryCode = (myArrayOfDict![indexPath.row] as AnyObject).value(forKey: "countryCode") as! String
        var countryName = String()
        countryName = (myArrayOfDict![indexPath.row] as AnyObject).value(forKey: "countryName") as! String
        var countrySymble = String()
        countrySymble = (myArrayOfDict![indexPath.row] as AnyObject).value(forKey: "countrySymble") as! String
        
        var completeStr = String()
        completeStr = String(format: "%@    %@", countrySymble,countryCode)
        
        cell.currencyLbl.text = completeStr
        cell.countryCodeLbl.text = countryName
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        appd.toCurrencyStr = (myArrayOfDict![indexPath.row] as AnyObject).value(forKey: "countryCode") as! String
        print(appd.toCurrencyStr)
        print(appd.formCurrencyStr)
        
        countrySymble =  (myArrayOfDict![indexPath.row] as AnyObject).value(forKey: "countrySymble") as! String
        print(countrySymble)
        
        oldCurrencyData()
    //    newCurencyData()
    }
    
    func newCurencyData()
    {
        var rateDict = [String: Any]()
        rateDict = (UserDefaults.standard .value(forKey: "currencyRate") as! NSDictionary) as! [String : Any]
        let results = rateDict.compactMap { (key, value) in key.uppercased().contains(self.appd.toCurrencyStr) ? value : nil }
        print(results)
        print(results.first ?? "Not Found")
        var currencyNew = Double()
        currencyNew = results.first as! Double
        print(currencyNew)
        
        let ssss = String(format: "%.3f", currencyNew)
        
        var str2 = String()
        str2 = self.getConvertCurrencyAmount(currency: ssss, toCurrency: self.appd.amountCurrency)
        
        let userInfo = [ "currency" : str2 ,"symble":countrySymble,"countryCode":self.appd.toCurrencyStr]
        
        NotificationCenter.default.post(name: .myNotificationKey, object: nil, userInfo: userInfo)
        
        DispatchQueue.main.async
            {
                self.navigationController?.popViewController(animated: true)
        }
    }
    
    func oldCurrencyData()  {
        currencyConverter.updateExchangeRates(completion: {
            
            var str2 = String()
            let formattedResult = self.currencyConverter.convertAndFormat(Double(self.appd.amountCurrency), valueCurrency: self.appd.formCurrencyStr, outputCurrency: self.appd.toCurrencyStr, numberStyle: .decimal, decimalPlaces: 3)
            print(formattedResult as Any)
            
            str2 = formattedResult ?? "No Convert Currency"
            let userInfo = [ "currency" : str2 ,"symble":self.countrySymble,"countryCode":self.appd.toCurrencyStr]
            
            NotificationCenter.default.post(name: .myNotificationKey, object: nil, userInfo: userInfo)
            
            DispatchQueue.main.async
                {
                    self.navigationController?.popViewController(animated: true)
            }
            
        })
    }
    
    func getConvertCurrencyAmount(currency: String, toCurrency: Double)  -> String {
        
        var amount = Double()
        amount = Double(currency) ?? 1
        let tax = Double(amount) * toCurrency
        print(tax)
        let ssss = String(format: "%.2f", tax)
        
        return ssss
    }
    @IBAction func backBTN(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension Notification.Name {
    public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
}


