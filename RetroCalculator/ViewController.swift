//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Emil Møller Lind on 16/11/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Var and let
    var runningNumber: String = ""
    var leftHand: Double = 0.0
    var rightHand: Double = 0.0
    var currentOperation = Operation.Empty
    var result: Double = 0.0

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Clear = "Clear"
        case Equal = "Equal"
        case Empty = "Empty"
    }
    
    
    //IBOutlets
    
    @IBOutlet weak var label: UILabel!
    
    
    //IBActions
    
    @IBAction func clearBtn(_ sender: UIButton) {
        if label.text != "" {
            runningNumber = "0"
            leftHand = 0.0
            rightHand = 0.0
            currentOperation = .Empty
            result = 0.0
            updateUI()
        }
    }
    
    @IBAction func divideBtn(_ sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyBtn(_ sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtrackBtn(_ sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalBtn(_ sender: UIButton) {
        processOperation(operation: .Equal)
        
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        for tag in 0...9 {
            if sender.tag == tag {
                runningNumber.append(String(tag))
            }
            
            
        }
        print("number pressed with tag: \(sender.tag)")
        updateUI()
        
        
    }
    
    
    // Functions
    
    func updateUI() {
        if runningNumber != "" {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.numberStyle = .decimal
        let runningNSNumber = numberFormatter.number(from: runningNumber)
        if runningNumber.characters.count >= 20 {
            self.label.text = String(describing: runningNSNumber!)
        } else {
        self.label.text = numberFormatter.string(from: runningNSNumber!)
        }
        } else {
            self.label.text = ""
        }
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != .Empty {
        
            //if an operation has been set
            if runningNumber != "" {
            rightHand = Double(runningNumber)!
            }
            
            
            
            if operation == .Equal && currentOperation != .Equal || currentOperation == operation {
                if operation != .Equal {
                    currentOperation = operation
                }
                
                if currentOperation == .Add {
                    result = leftHand + rightHand
                } else if currentOperation == .Subtract {
                    result = leftHand - rightHand
                } else if currentOperation == .Multiply {
                    result = leftHand * rightHand
                } else if currentOperation == .Divide {
                    result = leftHand / rightHand
                }
                print("first test if being called")
                runningNumber = String(result)
                updateUI()
                runningNumber = ""
                leftHand = result
            } else if operation != .Equal && currentOperation != .Equal {
                currentOperation = operation
                
            }
            
        } else {
            
            //No operator has been set yet.
            leftHand = Double(runningNumber)!
            currentOperation = operation
            runningNumber = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
 


}

