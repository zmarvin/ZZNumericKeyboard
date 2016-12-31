//
//  ZZNumericKeyboard.swift
//  ZZNumericKeyboardDemo
//
//  Created by zz on 15/7/30.
//  Copyright (c) 2015年 zz. All rights reserved.
//

import UIKit

@objc(ZZNumericKeyboardDelegate)
protocol ZZNumericKeyboardDelegate {
    func numberKeyboardInput(number : NSInteger) ->()
    func stringKeyboardInput(str : String) ->()
    func numberKeyboardBackspace()->()
}

let str : NSString = "123"
class ZZNumericKeyboard: UIView {
    
    open weak var delegate : ZZNumericKeyboardDelegate?
    open var numFont : UIFont = UIFont.systemFont(ofSize: 27)
    
    fileprivate let arrLetter = ["ABC","DEF","GHI","JKL","MNO","PQRS","TUV","WXYZ"]
    fileprivate let lineWidth : CGFloat = 1
    fileprivate var screenW = UIScreen.main.bounds.size.width
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bounds = CGRect(x: 0, y: 0, width: screenW, height: 216)

        for  i in 0 ..< 4  {
            for j in 0  ..< 3  {
                let button = self.creatButton(x: i, y: j)
                self.addSubview(button)
            }
        }
        
        let color : UIColor = UIColor(red: 188/255.0, green: 192/255.0, blue: 199/255.0, alpha: 1)
        let w = screenW/3.0
        let line1 = UIView(frame: CGRect(x: w - lineWidth, y: 0,width: lineWidth, height: 216))
        line1.backgroundColor = color
        self.addSubview(line1)

        let line2 = UIView(frame: CGRect(x: 2*w+1, y: 0, width: lineWidth,height:216))
        line2.backgroundColor = color
        self.addSubview(line2)
        
        for i in 0 ..< 3  {
            let line:UIView = UIView(frame: CGRect(x:0.0, y:54.0*CGFloat(i+1), width:screenW, height:lineWidth))
            line.backgroundColor = color
            self.addSubview(line)
        }
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func creatButton(x:NSInteger,y:NSInteger) ->(UIButton){
        let button = UIButton()
        
        let w = UIScreen.main.bounds.width/3.0
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
        let frameY : CGFloat = 54 * CGFloat(x)

        button.frame = CGRect.init(x:frameX!, y: frameY, width: frameW!, height: 54)

        
        let num : NSInteger = y + 3*x + 1;
        button.tag = num
        button.addTarget(self, action:#selector(self.clickButton(btn:)), for: UIControlEvents.touchUpInside)
        
        var colorNormal : UIColor = UIColor(red: 252/255.0, green: 252/255.0, blue: 252/255.0, alpha: 1)
        var colorHightlighted : UIColor = UIColor(red: 186.0/255, green: 189.0/255, blue: 194.0/255, alpha: 1.0)
        
        if num == 10 || num == 12{
            let colorTemp = colorNormal
            colorNormal = colorHightlighted
            colorHightlighted = colorTemp
        }
        button.backgroundColor = colorNormal
        
        let imageSize :CGSize = CGSize(width: frameW!, height: 54);
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        colorHightlighted.set()

        UIRectFill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        let pressedColorImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        button.setImage(pressedColorImg, for: UIControlState.highlighted)
        
        if num < 10{
            let labelNum:UILabel = UILabel(frame: CGRect(x: 0, y: 5, width: frameW!, height: 28))
            labelNum.text = "\(num)"
            labelNum.textColor = UIColor.black
            labelNum.textAlignment = NSTextAlignment.center
            labelNum.font = numFont
            button.addSubview(labelNum)
            
            if num != 1 {
                let labelLetter : UILabel = UILabel(frame: CGRect(x: 0, y: 33, width: frameW!, height: 16))
                labelLetter.text = arrLetter[num - 2]
                labelLetter.textColor = UIColor.black
                labelLetter.textAlignment = NSTextAlignment.center;
                button.addSubview(labelLetter)
            }
            
        }else if num == 11
        {
            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 15, width: frameW!, height: 28))
            label.text = "0"
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            label.font = numFont
            button.addSubview(label)
        }else if num == 10
        {
            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 15, width: frameW!, height: 28))
            label.text = "."
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            
            button.addSubview(label)
        }else
        {
            let arrow:UIImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: frameW!, height: 28))
            
            if UIScreen.main.bounds.size.width > 320 {
                let arrowX : CGFloat = 375/320.0 * 42
                let arrowW : CGFloat = 375/320.0 * 22
                
                arrow.frame = CGRect(x: arrowX, y: 19, width: arrowW, height: 17)
                
            }
            
            arrow.image = UIImage(named: "arrowInKeyboard")
            button.addSubview(arrow)
        }
        
        return button;
    }
    
    
    func clickButton(btn : UIButton){
        
        switch btn.tag{
            case 10:
                self.delegate?.stringKeyboardInput(str: ".")
            case 12:
                self.delegate?.numberKeyboardBackspace()
            default:
                var num = btn.tag
                if num == 11 {
                    num = 0
                }
                self.delegate?.numberKeyboardInput(number: num)
            break
            
        }
        
    }
    
}

















