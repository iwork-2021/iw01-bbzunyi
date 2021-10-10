//
//  CalcViewController.swift
//  cal
//
//  Created by bb on 2021/9/28.
//

import UIKit

class CalcViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.display.text! = "0"
        // Do any additional setup after loading the view.
    }

    var digitOnDisplay : String{
        get{
            return self.display.text!
        }
        set{
            self.display.text! = newValue
        }
    }
    
    var inTypingmode = false
    
    @IBAction func numberpressed(_ sender: UIButton) {
        print("Number \(sender.currentTitle!) touched")
        if inTypingmode{
            digitOnDisplay = digitOnDisplay + sender.currentTitle!
        }
        else{
            digitOnDisplay = sender.currentTitle!
            inTypingmode = true
        }
        
    }
    
    let calculator = Calculator()
    @IBAction func operatorpressed(_ sender: UIButton) {
        print("Operator \(sender.currentTitle!) touched")
        if sender.currentTitle! == "("{
            calculator.pendingOp1 = calculator.pendingOp
        }else{
            if let op = sender.currentTitle{
                if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                    var z : Int
                    if fmod(result, 1) == 0{
                        z = Int(result)
                        digitOnDisplay = String(z)
                    }else{
                        digitOnDisplay = String(result)
                    }
                }
                inTypingmode = false
            }
        }
    
        if sender.currentTitle == ")"{
            calculator.pendingOp = calculator.pendingOp1
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
