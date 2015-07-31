//
//  ZZNumericKeyboard.swift
//  ZZNumericKeyboardDemo
//
//  Created by zz on 15/7/30.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit

protocol ZZNumericKeyboardDelegate {
    func numberKeyboardInput(number : NSInteger) ->()
    func stringKeyboardInput(str : String) ->()
    func numberKeyboardBackspace()->()
}

let str : NSString = "123"
class ZZNumericKeyboard: UIView {
    
    var delegate : ZZNumericKeyboardDelegate?
    var numFont : UIFont = UIFont.systemFontOfSize(27)
    let arrLetter = ["ABC","DEF","GHI","JKL","MNO","PQRS","TUV","WXYZ"]
    let lineWidth : CGFloat = 1
    var screenW = UIScreen.mainScreen().bounds.size.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bounds = CGRectMake(0, 0, screenW, 216)
        
        for  var i = 0; i < 4 ; i++ {
            for var j = 0 ; j<3 ; j++ {
                var button = self.creatButton(i, y: j)
                self.addSubview(button)
            }
        }
        
        var color : UIColor = UIColor(red: 188/255.0, green: 192/255.0, blue: 199/255.0, alpha: 1)
        
        let w = screenW/3.0
        var line1 = UIView(frame: CGRectMake(w - lineWidth, 0, lineWidth, 216))
        line1.backgroundColor = color
        self.addSubview(line1)
        
        
        var line2 = UIView(frame: CGRectMake( 2*w+1 , 0, lineWidth, 216))
        line2.backgroundColor = color
        self.addSubview(line2)
        
        for var i = 0; i < 3 ; i++ {
            var line:UIView = UIView(frame: CGRectMake(0.0, 54.0*CGFloat(i+1), screenW, lineWidth))
            line.backgroundColor = color
            self.addSubview(line)
        }
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func creatButton(x:NSInteger,y:NSInteger) ->(UIButton){
        var button : UIButton?
        
        var w = UIScreen.mainScreen().bounds.width/3.0
        var frameX : CGFloat?
        var frameW : CGFloat?
        
        switch y{
            case 0:
                frameX = 0.0
                frameW = w
            case 1:
                frameX = w - lineWidth
                frameW = w + lineWidth
            case 2:
                frameX = 2*w
                frameW = w
            default:
                break
        }
        var frameY : CGFloat = 54 * CGFloat(x)
        
        button = UIButton(frame: CGRectMake(frameX!, frameY, frameW!, 54))
        
        
        var num : NSInteger = y + 3*x + 1;
        button?.tag = num
        button?.addTarget(self, action:Selector("clickButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        var colorNormal : UIColor = UIColor(red: 252/255.0, green: 252/255.0, blue: 252/255.0, alpha: 1)
        var colorHightlighted : UIColor = UIColor(red: 186.0/255, green: 189.0/255, blue: 194.0/255, alpha: 1.0)
        
        if num == 10 || num == 12{
            var colorTemp = colorNormal
            colorNormal = colorHightlighted
            colorHightlighted = colorTemp
        }
        button?.backgroundColor = colorNormal
        
        var imageSize :CGSize = CGSizeMake(frameW!, 54);
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.mainScreen().scale)
        colorHightlighted.set()
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height))
        
        var pressedColorImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        button?.setImage(pressedColorImg, forState: UIControlState.Highlighted)
        
        if num < 10{
            var labelNum:UILabel = UILabel(frame: CGRectMake(0, 5, frameW!, 28))
            labelNum.text = "\(num)"
            labelNum.textColor = UIColor.blackColor()
            labelNum.textAlignment = NSTextAlignment.Center
            labelNum.font = numFont
            button?.addSubview(labelNum)
            
            if num != 1 {
                var labelLetter : UILabel = UILabel(frame: CGRectMake(0, 33, frameW!, 16))
                labelLetter.text = arrLetter[num - 2]
                labelLetter.textColor = UIColor.blackColor()
                labelLetter.textAlignment = NSTextAlignment.Center;
                button?.addSubview(labelLetter)
            }
            
        }else if num == 11
        {
            var label:UILabel = UILabel(frame: CGRectMake(0, 15, frameW!, 28))
            label.text = "0"
            label.textColor = UIColor.blackColor()
            label.textAlignment = NSTextAlignment.Center
            label.font = numFont
            button?.addSubview(label)
        }else if num == 10
        {
            var label:UILabel = UILabel(frame: CGRectMake(0, 15, frameW!, 28))
            label.text = "."
            label.textColor = UIColor.blackColor()
            label.textAlignment = NSTextAlignment.Center
            
            button?.addSubview(label)
        }else
        {
            var arrow:UIImageView = UIImageView(frame: CGRectMake(0, 15, frameW!, 28))
            
            if UIScreen.mainScreen().bounds.size.width > 320 {
                var arrowX : CGFloat = 375/320.0 * 42
                var arrowW : CGFloat = 375/320.0 * 22
                arrow.frame = CGRectMake(arrowX, 19, arrowW, 17)
                
            }
            
            arrow.image = UIImage(named: "arrowInKeyboard")
            button?.addSubview(arrow)
        }
        
        return button!;
    }
    
    
    func clickButton(btn : UIButton){
        
        switch btn.tag{
            case 10:
                self.delegate?.stringKeyboardInput(".")
            case 12:
                self.delegate?.numberKeyboardBackspace()
            default:
                var num = btn.tag
                if num == 11 {
                    num = 0
                }
                self.delegate?.numberKeyboardInput(num)
            break
            
        }
        
    }
    
}

















