//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Büşra Özkan on 18.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }


    @IBAction func getRatesButton(_ sender: Any) {
        // 1)Request & Session -> internetten veriye gitmek, istek göndermek
        // 2)Response & Data -> Bu isteğe cevap almak, datayı almak
        // 3)Parsing & JSON Serialization -> Bu datayı işlemek
        
        // URL tanımlamak (1. adım)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared  //istediğiniz ağa gidip ordan veri alışverişi yapmak için kullanılır.
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
                //(2. adım)
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        DispatchQueue.main.async {
                            print(jsonResponse)
                        }
                    }catch{
                    }
                }
            }
        }
        task.resume() // task içindeki işlemlerin başlaması için kullanılır
        
    }
}

