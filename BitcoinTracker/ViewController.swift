//
//  ViewController.swift
//  BitcoinTracker
//
//  Created by Rahul Krishnan on 25/4/19.
//  Copyright © 2019 Rahul Krishnan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var priceValue: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let baseURL = "https://apiv2.bitcoinaverage.com/constants/exchangerates/global"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var json : JSON = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if json == "" {
            SVProgressHUD.show(withStatus: "Loading")
            getBitcoinPrice()
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return currencyArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currency = currencyArray[row]
        let value = json["rates"][currency]["rate"].stringValue
        priceValue.text = value
        
    }
    
    //    //MARK: - Networking
    //    /***************************************************************/
    
    func getBitcoinPrice() {
        
        Alamofire.request(baseURL).responseJSON {
            response in
            
            if response.result.isSuccess {
                self.json = JSON(response.result.value!)
                print(self.json)
                SVProgressHUD.dismiss()
                
            } else {
                
                print("Something went wrong")
            }
        }
        
    }

    

}

