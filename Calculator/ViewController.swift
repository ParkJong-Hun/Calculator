//
//  ViewController.swift
//  Calculator
//
//  Created by 박종훈 on 2021/08/18.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var stack:[String] = []
    var new_num:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputNumber.addTarget(self, action: #selector(self.changed_number_to_edit(_:)), for: .editingChanged)
        self.inputNumber.addTarget(self, action: #selector(self.changed_number_to_edit(_:)), for: .valueChanged)
        inputNumber.text = "0"
    }
    
    
    
    
    
    //MARK: Input Number
    @IBOutlet weak var inputNumber: UITextField!
    func checking() {
        if inputNumber.text!.count > 1 {
            let firstIndex = inputNumber.text!.startIndex
            if inputNumber.text![firstIndex] == "0" {
                inputNumber.text!.removeFirst()
            } else if inputNumber.text![firstIndex] == "-" {
                let secondIndex = inputNumber.text?.index(after: firstIndex)
                if inputNumber.text![secondIndex!] == "0" {
                    inputNumber.text!.remove(at: secondIndex!)
                }
            }
        }
        if inputNumber.text?.count == 0 {
            inputNumber.text! += "0"
        }
    }
    //end edit
    @IBAction func changed_number(_ sender: UITextField) {
        checking()
    }
    //editing
    @objc func changed_number_to_edit(_ sender: Any) {
        checking()
        limit_length(textField: inputNumber, maxLength: 9)
    }
    //limit text length
    func limit_length(textField:UITextField, maxLength:Int) {
        if textField.text!.count > maxLength {
            textField.text!.removeLast()
        }
    }
    
    
    
    //MARK: Stack Number
    @IBOutlet weak var stackNumber: UILabel!
    
    
    
    
    
    //MARK: Digit
    //0
    @IBAction func clicked_0(_ sender: Any) {
        button_clicked("0")
    }
    //1
    @IBAction func clicked_1(_ sender: Any) {
        button_clicked("1")
    }
    //2
    @IBAction func clicked_2(_ sender: Any) {
        button_clicked("2")
    }
    //3
    @IBAction func clicked_3(_ sender: Any) {
        button_clicked("3")
    }
    //4
    @IBAction func clicked_4(_ sender: Any) {
        button_clicked("4")
    }
    //5
    @IBAction func clicked_5(_ sender: Any) {
        button_clicked("5")
    }
    //6
    @IBAction func clicked_6(_ sender: Any) {
        button_clicked("6")
    }
    //7
    @IBAction func clicked_7(_ sender: Any) {
        button_clicked("7")
    }
    //8
    @IBAction func clicked_8(_ sender: Any) {
        button_clicked("8")
    }
    //9
    @IBAction func clicked_9(_ sender: Any) {
        button_clicked("9")
    }
    //button click
    func button_clicked(_ num:String) {
        if new_num {
            new_num = false
            inputNumber.text! = ""
        }
        inputNumber.text! += num
        if inputNumber.text! == "0\(num)" {
            inputNumber.text!.removeFirst()
        }
        limit_length(textField: inputNumber, maxLength: 9)
    }
    
    
    
    
    //MARK: Dot, Toggle
    //.
    @IBAction func clicked_dot(_ sender: Any) {
        inputNumber.text! += "."
    }
    //+/-
    @IBAction func clicked_toggle(_ sender: Any) {
        let firstIndex = inputNumber.text?.startIndex
        if inputNumber.text![firstIndex!] == "-" {
            inputNumber.text?.removeFirst()
        } else {
            if inputNumber.text! != "0" {
                inputNumber.text?.insert("-", at: firstIndex!)
            }
        }
    }
    
    
    
    
    
    //MARK: Backspace
    //↩︎
    @IBAction func clicked_backspace(_ sender: Any) {
        inputNumber.text?.removeLast()
        if inputNumber.text?.count == 0 {
            inputNumber.text! += "0"
        }
    }
    
    
    
    
    
    //push input number
    func push_input() {
        var number:String = ""
        for i in inputNumber.text!.indices {
            if i == inputNumber.text!.index(inputNumber.text!.startIndex, offsetBy: 0) && inputNumber.text![i] == "-" {
                number += String(inputNumber.text![i])
            } else if inputNumber.text![i].isNumber {
                number += String(inputNumber.text![i])
            }
        }
        stack.append(number)
    }
    
    
    
    
    //MARK: Operator
    //÷
    @IBAction func clicked_division(_ sender: Any) {
        process_operator("/")
    }
    //×
    @IBAction func clicked_multiply(_ sender: Any) {
        process_operator("*")
    }
    //-
    @IBAction func clicked_minus(_ sender: Any) {
        process_operator("-")
    }
    //+
    @IBAction func clicked_plus(_ sender: Any) {
        process_operator("+")
    }
    //%
    @IBAction func clicked_remainder(_ sender: Any) {
        process_operator("%")
    }
    //process operator
    func process_operator(_ oper:String) {
        push_input()
        stack.append(oper)
        stackNumber.text = stack.joined()
        stackNumber.isHidden = false
        new_num = true
        calculate()
    }
    //calculate
    func calculate() {
        var count = 0
        for i in stack {
            switch i {
            case "+":
                count += 1
                break
            case "-":
                count += 1
                break
            case "/":
                count += 1
                break
            case "*":
                count += 1
                break
            case "=":
                count += 1
                break
            case "%":
                count += 1
                break
            case "1/x":
                count += 2
                break
            case "x^2":
                count += 2
                break
            case "sqrt(x)":
                count += 2
                break
            default:
                break
            }
        }
        if count >= 2 {
            let x = stack.removeFirst()
            let oper = stack.removeFirst()
            var y:String = ""
            switch oper {
            case "1/x":
                stack.removeAll()
                stack.insert("\(1/Double(x)!)", at: 0)
                inputNumber.text! = stack[0]
                return
            case "x^2":
                stack.removeAll()
                stack.insert("\(pow(Double(x)!, 2))", at: 0)
                inputNumber.text! = stack[0]
                return
            case "sqrt(x)":
                stack.removeAll()
                stack.insert("\(sqrt(Double(x)!))", at: 0)
                inputNumber.text! = stack[0]
                return
            default:
                y = stack.removeFirst()
                break
            }
            switch oper {
            case "+":
                stack.insert("\(Double(x)! + Double(y)!)", at: 0)
                inputNumber.text! = stack[0]
                return
            case "-":
                stack.insert("\(Double(x)! - Double(y)!)", at: 0)
                inputNumber.text! = stack[0]
                return
            case "/":
                stack.insert("\(Double(x)! / Double(y)!)", at: 0)
                inputNumber.text! = stack[0]
                return
            case "*":
                stack.insert("\(Double(x)! * Double(y)!)", at: 0)
                inputNumber.text! = stack[0]
                return
            case "%":
                stack.insert("\(Int(x)! % Int(y)!)", at: 0)
                inputNumber.text! = stack[0]
                return
            default:
                print("Stack Error")
            }
            if oper == "=" {
                stack.removeAll()
                stackNumber.text! = stack.joined()
            }
        }
    }
    
    
    
    
    //MARK: Recall
    //=
    @IBAction func clicked_recall(_ sender: Any) {
        process_operator("=")
    }
    
    
    
    
    
    //MARK: Math
    //1⁄x
    @IBAction func clicked_fraction(_ sender: Any) {
        process_operator("1/x")
    }
    //x^2
    @IBAction func clicked_pow(_ sender: Any) {
        process_operator("x^2")
    }
    //√x
    @IBAction func clicked_sqrt(_ sender: Any) {
        process_operator("sqrt(x)")
    }
    
    
    
    
    
    //MARK: Clear
    //normal clear
    @IBAction func clicked_clear(_ sender: Any) {
        stack.removeAll()
        stackNumber.text = "0"
        stackNumber.isHidden = true
        inputNumber.text = "0"
    }
    //clear error
    @IBAction func clicked_clear_error(_ sender: Any) {
        inputNumber.text = "0"
    }
    
}
