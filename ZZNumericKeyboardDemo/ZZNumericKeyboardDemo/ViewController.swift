//
//  ViewController.swift
//  ZZNumericKeyboardDemo
//
//  Created by zz on 15/7/30.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit



extension String {
    
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
}



class ViewController: UIViewController, ZZNumericKeyboardDelegate{

    @IBOutlet weak var textField: UITextField!
    var doneButton:UIButton?
//    var textField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var keyboard = ZZNumericKeyboard(frame: CGRectMake(0, 200, UIScreen.mainScreen().bounds.width, 216))
        self.textField?.inputView = keyboard
        keyboard.delegate = self
        
        
    }

    
    func stringKeyboardInput(str: String) {
        var textStr = self.textField?.text
        var isContain = textStr?.contains(".")
        if  isContain == true || textStr == nil {
            return
        }
        self.textField?.text = textStr?.stringByAppendingString(str)
        
    }
    
    func numberKeyboardInput(number: NSInteger) {
        var str = self.textField?.text
        self.textField?.text = str?.stringByAppendingString("\(number)")
        
    }
    func numberKeyboardBackspace() {
        var length = self.textField?.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        if  length != 0{
            var str = self.textField?.text
            
            self.textField?.text = (str! as NSString ).substringToIndex(length! - 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

}

