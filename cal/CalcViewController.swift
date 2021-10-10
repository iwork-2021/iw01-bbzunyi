//
//  CalcViewController.swift
//  cal
//
//  Created by bb on 2021/9/28.
//

import UIKit


class CalcViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var Raddisplay: UILabel!
    @IBOutlet weak var Rad_button: UIButton!
    @IBOutlet weak var _2ndbutton: UIButton!
    @IBOutlet weak var button2_5: UIButton!
    @IBOutlet weak var button2_6: UIButton!
    @IBOutlet weak var button3_5: UIButton!
    @IBOutlet weak var button3_6: UIButton!
    @IBOutlet weak var button4_2: UIButton!
    @IBOutlet weak var button4_3: UIButton!
    @IBOutlet weak var button4_4: UIButton!
    @IBOutlet weak var button5_2: UIButton!
    @IBOutlet weak var button5_3: UIButton!
    @IBOutlet weak var button5_4: UIButton!
    @IBOutlet weak var button_C: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.display.text! = "0"
        self.Raddisplay.text! = "Rad"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        button_C.setTitle("C", for: [])
        print("Number \(sender.currentTitle!) touched")
        if inTypingmode{
            digitOnDisplay = digitOnDisplay + sender.currentTitle!
        }
        else{
            digitOnDisplay = sender.currentTitle!
            inTypingmode = true
        }
        if(digitOnDisplay == "inf"||digitOnDisplay == "-inf"||digitOnDisplay == "nan"){
            digitOnDisplay = "Error"
        }
    }
    
    let calculator = Calculator()

    func CorAC(title : String){
        if(title == "C"){
            button_C.setTitle("AC", for: [])
        }else if title == "AC"{
        }
    }
    
    func _2nd_pressed(button : Bool){
        let defaultcolor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        let highlightcolor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        if button == true{
            _2ndbutton.backgroundColor = highlightcolor
            button2_5.setTitle("y^x", for: [])
            button2_6.setTitle("2^x", for: [])
            button3_5.setTitle("logy", for: [])
            button3_6.setTitle("log2", for: [])
            button4_2.setTitle("sin^-1", for: [])
            button4_3.setTitle("cos^-1", for: [])
            button4_4.setTitle("tan^-1", for: [])
            button5_2.setTitle("sinh^-1", for: [])
            button5_3.setTitle("cosh^-1", for: [])
            button5_4.setTitle("tanh^-1", for: [])
        }else{
            _2ndbutton.backgroundColor = defaultcolor
            button2_5.setTitle("e^x", for: [])
            button2_6.setTitle("10^x", for: [])
            button3_5.setTitle("ln", for: [])
            button3_6.setTitle("log10", for: [])
            button4_2.setTitle("sin", for: [])
            button4_3.setTitle("cos", for: [])
            button4_4.setTitle("tan", for: [])
            button5_2.setTitle("sinh", for: [])
            button5_3.setTitle("cosh", for: [])
            button5_4.setTitle("tanh", for: [])
        }
    }
    
    @IBAction func operatorpressed(_ sender: UIButton) {
        print("Operator \(sender.currentTitle!) touched")
        button_C.setTitle("C", for: [])
        if sender.currentTitle! == "("{
            calculator.pendingOp1 = calculator.pendingOp
            return
        }else{
            if digitOnDisplay == "Error"{
                digitOnDisplay = "0"
            }
            var openum : Double = Double(digitOnDisplay)!
            if sender.currentTitle! == "Deg"{
                calculator.rad = false
                Raddisplay.text! = ""
                Rad_button.setTitle("Rad", for: [])
                return
            }else if sender.currentTitle! == "Rad"{
                calculator.rad = true
                Raddisplay.text! = "Rad"
                Rad_button.setTitle("Deg", for: [])
            }//Deg or Rad
            if (calculator.rad == false&&(sender.currentTitle! == "cos" || sender.currentTitle! == "sin"||sender.currentTitle! == "tan")){
                openum = (openum/180.0)*Double.pi
            }
            if sender.currentTitle! == "2nd"{
                calculator._2ndpressed = !calculator._2ndpressed
                _2nd_pressed(button: calculator._2ndpressed)
            }
            if let op = sender.currentTitle{
                if var result = calculator.performOperation(operation: op, operand:openum){
                    var z : Int
                    if (sender.currentTitle! == "cos^-1" || sender.currentTitle! == "sin^-1"||sender.currentTitle! == "tan^-1"){
                        result *= calculator.RadCorrect
                    }
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
        CorAC(title: sender.currentTitle!)
        if(digitOnDisplay == "inf"||digitOnDisplay == "-inf"||digitOnDisplay == "nan"){
            digitOnDisplay = "Error"
            
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
