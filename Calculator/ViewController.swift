//
//  ViewController.swift
//  Calculator
//
//  Created by 박종훈 on 2021/08/18.
//

import UIKit

class ViewController: UIViewController {
    
    var stack:[String] = []
    
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
        inputNumber.text! += num
        if inputNumber.text! == "0\(num)" {
            inputNumber.text!.removeFirst()
        }
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
        push_input()
        stack.append("/")
    }
    //×
    @IBAction func clicked_multiply(_ sender: Any) {
        push_input()
        stack.append("*")
    }
    //-
    @IBAction func clicked_minus(_ sender: Any) {
        push_input()
        stack.append("-")
    }
    //+
    @IBAction func clicked_plus(_ sender: Any) {
        push_input()
        stack.append("+")
    }
    //%
    @IBAction func clicked_remainder(_ sender: Any) {
        push_input()
        stack.append("%")
    }
    
    
    
    
    //MARK: Recall
    //=
    @IBAction func clicked_recall(_ sender: Any) {
        stack.append("=")
    }
    
    
    
    
    
    //MARK: Math
    //1⁄x
    @IBAction func clicked_fraction(_ sender: Any) {
        push_input()
    }
    //x^2
    @IBAction func clicked_pow(_ sender: Any) {
        push_input()
    }
    //√x
    @IBAction func clicked_sqrt(_ sender: Any) {
        push_input()
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
