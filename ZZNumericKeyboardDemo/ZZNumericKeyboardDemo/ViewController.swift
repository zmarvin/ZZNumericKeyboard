//
//  ViewController.swift
//  ZZNumericKeyboardDemo
//
//  Created by zz on 15/7/30.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit



extension String {
    
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
}



class ViewController: UIViewController, ZZNumericKeyboardDelegate{

    @IBOutlet weak var textField: UITextField!
    var doneButton:UIButton?
//    var textField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let keyboard = ZZNumericKeyboard(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 216))
        self.textField?.inputView = keyboard
        keyboard.delegate = self
        
        
    }

    
    func stringKeyboardInput(str: String) {
        let textStr = self.textField?.text
        let isContain = textStr?.contains(".")
        if  isContain == true || textStr == nil {
            return
        }
        self.textField?.text = (textStr)! + str
        
    }
    
    func numberKeyboardInput(number: NSInteger) {
        let str = self.textField?.text
        self.textField?.text = (str)! + "\(number)"
        
    }
    func numberKeyboardBackspace() {
        let length = self.textField?.text?.lengthOfBytes(using: String.Encoding.utf8)
        if  length != 0{
            let str = self.textField?.text
            
            self.textField?.text = (str! as NSString ).substring(to: length! - 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

}

