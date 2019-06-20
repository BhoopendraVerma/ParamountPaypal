//
//  PaymentHistoryVC.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 04/06/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit

class PaymentHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var myArrayOfDict: NSArray?

    @IBOutlet var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   return images.count
        return myArrayOfDict!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "Cell")!  as! CustomTableViewCell
       
        return cell
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
