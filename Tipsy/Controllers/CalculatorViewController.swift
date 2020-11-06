//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
       /*
        if sender.currentTitle == "0%"{
            sumTips = 0.0
        }else if sender.currentTitle == "10%"{
            sumTips = 0.1
        }else{
            sumTips = 0.2
        }
 */
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        billTotal = buttonTitleAsANumber / 100
        
    }
    
    @IBAction func stepperValueChanges(_ sender: UIStepper) {
        numPeople = Int(sender.value)//numPeople = Int(String(format: "%0.f", sender.value)) ?? 2 (mine :( )
        splitNumberLabel.text = String(format: "%0.f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" { // !!!!!!!!!!!!!!!!!!! и ниже
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numPeople)
            finalResult = String(format: "%.2f", result)
        }
        print("result = \(finalResult)")
        performSegue(withIdentifier: "goToResult", sender: self)
        //print(billTextField.text!)
        //print(numPeople)
        //print(tip)
        //print()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
            //destinationVC.totalLabel.text = result
            print(finalResult)
           // let res: String = String(format: "%0.f", result)
            //print(res)
            //destinationVC.totalLabel.text = String(format: "%2.f", result)
            
            destinationVC.result = finalResult//!!!!!!!!!! и ниже
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numPeople
        }
       }

}
