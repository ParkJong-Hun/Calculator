//
//  ViewController.swift
//  Calculator
//
//  Created by 박종훈 on 2021/08/18.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var stack:[String] = []
    var history:[[String]] = []
    var new_num:Bool = false
    var big_num:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputNumber.text = "0"
        inputNumber.isUserInteractionEnabled = false
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
        if !(inputNumber.text!.contains(".")) {
            inputNumber.text! += "."
        }
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
        var dotCheck:Bool = false
        for i in inputNumber.text!.indices {
            if i == inputNumber.text!.index(inputNumber.text!.startIndex, offsetBy: 0) && inputNumber.text![i] == "-" {
                number += String(inputNumber.text![i])
            } else if inputNumber.text![i].isNumber {
                number += String(inputNumber.text![i])
            } else if inputNumber.text![i] == "." && !dotCheck {
                number += String(inputNumber.text![i])
                dotCheck = true
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
        stackNumber.text = stack.joined(separator: " ")
        stackNumber.isHidden = false
        new_num = true
        calculate()
    }
    //calculate
    func calculate() {
        print("TEST stack: \(stack.joined())")
        
        var count = 0
        var y:String = ""
        let x:String
        let oper:String
        var last:String = ""
        
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
                count += 2
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
            history.append(stack)
            print("\nHistory \(history)")
            
            x = stack.removeFirst()
            oper = stack.removeFirst()
            
            switch oper {
            case "1/x":
                inputNumber.text! = "\(1/Double(x)!)"
                break
            case "x^2":
                inputNumber.text! = "\(pow(Double(x)!,2))"
                break
            case "sqrt(x)":
                inputNumber.text! = "\(sqrt(Double(x)!))"
                break
            case "=":
                stackNumber.text! = stack.joined()
                break
            default:
                y = stack.removeFirst()
                
                switch oper {
                case "+":
                    inputNumber.text! = "\(Double(x)! + Double(y)!)"
                    break
                case "-":
                    inputNumber.text! = "\(Double(x)! - Double(y)!)"
                    break
                case "/":
                    if x != "0" && y != "0" {
                        inputNumber.text! = "\(Double(x)! / Double(y)!)"
                    } else {
                        stackNumber.text! = "Zero impossible to use this operation"
                    }
                    break
                case "*":
                    inputNumber.text! = "\(Double(x)! * Double(y)!)"
                    break
                case "%":
                    if x != "0" && y != "0" {
                        inputNumber.text! = "\(Int(x)! % Int(y)!)"
                    } else {
                        stackNumber.text! = "Zero impossible to use this operation"
                    }
                    break
                default:
                    print("ERROR CASE")
                    break
                }
                last = stack.removeLast()
            }
            
            stack.removeAll()
            
            if count != 3 && last != "" {
                stack.append(inputNumber.text!)
                stack.append(last)
                stackNumber.text! = stack.joined(separator: " ")
            }
            
            let doubleCmp = Double(inputNumber.text!)!
            let intCmp =  Int(doubleCmp)
            if doubleCmp - Double(intCmp) == 0 {
                inputNumber.text! = "\(intCmp)"
            }
            if inputNumber.text!.contains(".") {
                while inputNumber!.text!.count > 9{
                    inputNumber!.text!.removeLast()
                }
            } else if inputNumber.text!.count > 9 {
                big_num = true
                while inputNumber!.text!.count > 9{
                    inputNumber!.text!.removeLast()
                }
            }
            check_big_num()
        }
    }
    //check big_num
    func check_big_num() {
        if big_num {
            stackNumber.textColor = UIColor.red
            inputNumber.textColor = UIColor.red
            stackNumber.text! = "Big number. so, value isn't correct"
            big_num = false
        } else {
            stackNumber.textColor = UIColor.black
            inputNumber.textColor = UIColor.black
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
        
        check_big_num()
    }
    //clear error
    @IBAction func clicked_clear_error(_ sender: Any) {
        inputNumber.text = "0"
        
        if stackNumber.text!.contains("Big number. so, value isn't correct") {
            stackNumber.text = "0"
            stackNumber.isHidden = true
        }
        check_big_num()
    }
    
    
    
    
    
    //MARK: Go Past
    @IBAction func clicked_go_past(_ sender: Any) {
        if history.count > 1 {
            print("Done Time travel")
            stack.removeAll()
            history.removeLast()
            stack = history.removeLast()
            stackNumber.text = stack.joined(separator: " ")
            stackNumber.isHidden = false
            new_num = true
            calculate()
        } else {
            stackNumber.text! = "You don't have history"
        }
        
        check_big_num()
    }
}
