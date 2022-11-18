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
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true,completion: nil)
            }else{
                //(2. adım)
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD:\(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF:\(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP:\(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY:\(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD:\(usd)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY:\(tr)"
                                }
                            }
                            
                        }
                    }catch{
                    }
                }
            }
        }
        task.resume() // task içindeki işlemlerin başlaması için kullanılır
        
    }
}

