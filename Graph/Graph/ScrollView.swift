//
//  ScrollView.swift
//  Graph
//
//  Created by Mac House on 7/1/19.
//  Copyright © 2019 myself. All rights reserved.
//

import UIKit
import Darwin

//Hàm tự tạo
@objc extension NSNumber {
    func sin() -> NSNumber {
        return NSNumber(value: Darwin.sin(self.doubleValue))
    }
    func cos() -> NSNumber {
        return NSNumber(value: Darwin.cos(self.doubleValue))
    }
}

class ScrollView: UIScrollView {
    //Khởi tạo cái view mà sẽ vẽ các thứ lên, view này có origin ở chính giữa ScrollView để tiện vẽ
    let a = UIView(frame: CGRect.zero)
    
    //Mảng chứa các điểm x, y trên hệ trục toạ độ
    var xArr: [CGFloat] = []
    var yArr: [CGFloat] = []
    
    //Hệ số để vẽ các thứ với các độ zoom khác nhau
    var modX: CGFloat = 9
    var modY: CGFloat = 9
    
    //Biến sẽ dùng để chứa biểu thức trước khi được tính
    var stringExpression: String = ""
    
    //Kích thước ScrollView
    var width: CGFloat = 3000
    var height: CGFloat = 3000
    
    convenience init() {
        self.init(frame: CGRect.zero)
        //Kích thước nội dung xem được
        self.contentSize = CGSize(width: width, height: height)
        //Điểm gốc của khung ScrollView mà lúc bắt đầu mình nhìn thấy luôn
        self.contentOffset = CGPoint(x: self.contentSize.width/2 - UIScreen.main.bounds.width/2, y: self.contentSize.height/2 - UIScreen.main.bounds.height/2)
        //Thêm view a
        self.addSubview(a)
        a.frame = CGRect(x: self.contentSize.width/2, y: self.contentSize.height/2, width: 0, height: 0)
        //Nhận cử chỉ Pinch
        self.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(interact(sender:))))
    }
    
    //Hàm chạy khi có cử chỉ Pinch
    @objc func interact(sender: UIGestureRecognizer) {
        if let pinch = sender as? UIPinchGestureRecognizer {
            //Thuộc tính scale = (khoảng cách 2 ngón tay sau)/(khoảng cách 2 ngón tay trước)
            if pinch.scale > 1 { zoomIn() }
            else if pinch.scale < 1 { zoomOut() }
            else { print("?") }
        }
    }
    
    //Các hàm zoom
    @objc func zoomIn() {
        modX += 0.1
        modY += 0.1
        if modX <= 10 && modY <= 10 {
            redraw()
        }
        else {
            modX -= 0.1
            modY -= 0.1
        }
    }
    
    @objc func zoomOut() {
        modX -= 0.1
        modY -= 0.1
        if modX >= 0.1 && modY >= 0.1 {
            redraw()
        }
        else {
            modX += 0.1
            modY += 0.1
        }
    }
    
    @objc func stretchX() {
        modX += 0.1
        if modX <= 10 {
            redraw()
        }
        else { modX -= 0.1 }
    }
    
    @objc func compressX() {
        modX -= 0.1
        if modX >= 0.1 {
            redraw()
        }
        else { modX += 0.1 }
    }
    
    @objc func stretchY() {
        modY += 0.1
        if modY <= 10 {
            redraw()
        }
        else { modY -= 0.1 }
    }
    
    @objc func compressY() {
        modY -= 0.1
        if modY >= 0.1 {
            redraw()
        }
        else { modY += 0.1 }
    }
    
    @objc func returnDefault() {
        modX = 9
        modY = 9
        redraw()
    }
    
    //Hàm vẽ lại trục, số trên trục và đồ thị
    func redraw() {
        a.layer.sublayers = nil
        drawAxes()
        drawOnXAxis()
        drawOnYAxis()
        redrawGraph()
    }
    
    //Vẽ trục
    func drawAxes() {
        drawLine(start: CGPoint(x: 0, y: -self.contentSize.height), end: CGPoint(x: 0, y: self.contentSize.height), ofColor: .black, inView: a)
        drawLine(start: CGPoint(x: -self.contentSize.width, y: 0), end: CGPoint(x: self.contentSize.width, y: 0), ofColor: .black, inView: a)
    }
    
    //Vẽ đường thẳng
    func drawLine(start: CGPoint, end: CGPoint, ofColor: UIColor, inView: UIView) {
        //Đường thẳng
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        //Tạo layer và cho đường thẳng vào layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = ofColor.cgColor
        shapeLayer.lineWidth = 1.0
        //Thêm layer vào view
        inView.layer.addSublayer(shapeLayer)
    }
    
    //Vẽ chữ
    func drawText(content: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, fontSize: CGFloat, inView: UIView) {
        let label = UILabel(frame: CGRect.zero)
        label.frame = CGRect(x: x-width/2, y: y-height/2, width: width, height: height)
        inView.addSubview(label)
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.text = content
    }
    
    //Tạo 1 array các CGFloat
    func gen(from: CGFloat, to: CGFloat, numofstep: Int) -> [CGFloat] {
        var arr: [CGFloat] = []
        let step = (to - from)/(CGFloat(numofstep))
        for i in 0...numofstep {
            arr.append(from+step * CGFloat(i))
        }
        return arr
    }
    
    //Vẽ lại đồ thị
    func redrawGraph() {
        if xArr.count != 0 && yArr.count != 0 {
            for i in 0...xArr.count - 2 {
                drawLine(start: CGPoint(x: xArr[i]*modX, y: -yArr[i]*modY), end: CGPoint(x: xArr[i+1]*modX, y: -yArr[i+1]*modY), ofColor: .blue, inView: a)
            }
        }
    }
    
    //Vẽ đồ thị
    func drawGraph(function: String, color: UIColor) -> String {
        //Mảng chứa các hoành độ
        xArr = gen(from: -1000, to: 1000, numofstep: 8000)
        //Mảng chứa các tung độ
        yArr = []
        var chars = Array<String>()
        for char in function {
            chars.append(String(char))
        }
        let c = chars.count
        if c == 0 { return "Error" }
        for i in 0...c-1 {
            let char = chars[i]
            if char == "x" {
                if i+1 <= c-1 { if Float(chars[i+1]) != nil { return "Error" } }
                if i-1 >= 0 { if Float(chars[i-1]) != nil { return "Error" } }
            }
        }
        do {
            try solveExpression.try({
                for x in self.xArr {
                    self.stringExpression = (function.replacingOccurrences(of: "x", with: String(Double(x))))
                    let expr = NSExpression(format: self.stringExpression)
                    if (expr.expressionValue(with: nil, context: nil) as? NSNumber) != nil {
                        self.yArr.append(expr.expressionValue(with: nil, context: nil) as! CGFloat)
                    }
                    else {
                        _ = NSExpression(format: "x+")
                    }
                }
            })
        } catch {
            print("Caught")
            xArr = []
            return "Error"
        }
        
        
        if yArr.count != 0 {
            for i in 0...self.xArr.count - 2 {
                self.drawLine(start: CGPoint(x: self.xArr[i]*self.modX, y: -self.yArr[i]*self.modY), end: CGPoint(x: self.xArr[i+1]*self.modX, y: -self.yArr[i+1]*self.modY), ofColor: color, inView: self.a)
            }
        }
        return "a"
    }
    
    //Đánh số lên trục x
    func drawOnXAxis() {
        //Mảng các số sẽ được viết
        var temp: [CGFloat] = []
        
        var peak = 0
        var dis = 0
        
        //Tuỳ độ zoom mà chọn khoảng cách giữa các mốc đánh số và số mốc
        if modX <= 10 && modX > 8.2 {
            peak = 44
            dis = 5
        }
        else if modX <= 8.2 && modX > 6.4 {
            peak = 28
            dis = 10
        }
        else if modX <= 6.4 && modX > 4.6 {
            peak = 20
            dis = 20
        }
        else if modX <= 4.6 && modX > 2.8 {
            peak = 13
            dis = 50
        }
        else if modX <= 2.8 && modX > 1.2 {
            peak = 15
            dis = 100
        }
        else if modX <= 1.2 && modX > 0.6 {
            peak = 15
            dis = 200
        }
        else {
            peak = 36
            dis = 500
        }
        //Thêm dữ liệu vào mảng nội dung
        for i in -peak...peak {
            temp.append(CGFloat(i*dis))
        }
        //Đánh số lên trục x
        for i in 0...temp.count-1{
            drawText(content: String(Int(temp[i])), x: temp[i]*modX, y: 8, width: 32, height: 10, fontSize: 10, inView: a)
        }
    }
    
    //Đánh số lên trục y
    func drawOnYAxis() {
        //Mảng các số sẽ được viết
        var temp: [CGFloat] = []
        var peak = 0
        var dis = 0
        
        //Tuỳ độ zoom mà chọn khoảng cách giữa các mốc đánh số và số mốc
        if modY <= 10 && modY > 8.2 {
            peak = 44
            dis = 5
        }
        else if modY <= 8.2 && modY > 6.4 {
            peak = 28
            dis = 10
        }
        else if modY <= 6.4 && modY > 4.6 {
            peak = 20
            dis = 20
        }
        else if modY <= 4.6 && modY > 2.8 {
            peak = 13
            dis = 50
        }
        else if modY <= 2.8 && modY > 1.2 {
            peak = 15
            dis = 100
        }
        else if modY <= 1.2 && modY > 0.6 {
            peak = 15
            dis = 200
        }
        else {
            peak = 36
            dis = 500
        }
        //Thêm dữ liệu vào mảng nội dung
        for i in (-peak)...(-1) {
            temp.append(CGFloat(i*dis))
        }
        for i in 1...peak {
            temp.append(CGFloat(i*dis))
        }
        //Đánh số lên trục y
        for i in 0...temp.count-1 {
            drawText(content: String(-Int(temp[i])), x: -18, y: temp[i]*modY, width: 32, height: 10, fontSize: 10, inView: a)
        }
    }
    
}
