//
//  SetCardView.swift
//  ViewTest
//
//  Created by Zeqiang on 2018/2/5.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    var shape: Shape = .squiggles { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var color: Color = .purple { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var number: Number = .three { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shading: Shading = .striped { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isSelected = false { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var borderColor = UIColor.black { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private func drawOvals() -> [UIBezierPath] {
        var paths = [UIBezierPath]()
        
        for i in 0..<number.rawValue+1 {
            let rect = CGRect(x: X[number.rawValue][i], y: Y[number.rawValue][i], width: widthOfShape, height: heightOfShape)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadiusOfShape)
            
            shapeColor.setStroke()
            path.lineWidth = lineWidthOfShape
            path.stroke()
            paths.append(path)
        }
        return paths
    }
    
    private func drawSquiggles() -> [UIBezierPath] {
        var paths = [UIBezierPath]()
        
        for i in 0..<number.rawValue+1 {
            let path = UIBezierPath()
            let ox = X[number.rawValue][i], oy = Y[number.rawValue][i]
            path.move(to: CGPoint(x: ox+0.16*widthOfShape/216, y: oy+66.9*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+30.21*widthOfShape/216, y: oy+15.29*heightOfShape/108),
                              controlPoint: CGPoint(x: ox+3.93*widthOfShape/216, y: oy+36.25*heightOfShape/108))
            
            path.addCurve(to: CGPoint(x: ox+78.07*widthOfShape/216, y: oy+4.78*heightOfShape/100),
                          controlPoint1: CGPoint(x: ox+42.89*widthOfShape/216, y: oy+5.19*heightOfShape/108),
                          controlPoint2: CGPoint(x: ox+55.55*widthOfShape/216, y: oy+2.91*heightOfShape/108))
            
            path.addCurve(to: CGPoint(x: ox+132.81*widthOfShape/216, y: oy+23.83*heightOfShape/108),
                          controlPoint1: CGPoint(x: ox+106.85*widthOfShape/216, y: oy+7.18*heightOfShape/108),
                          controlPoint2: CGPoint(x: ox+111.5*widthOfShape/216, y: oy+25.69*heightOfShape/108))
            
            path.addCurve(to: CGPoint(x: ox+194.66*widthOfShape/216, y: oy+0.99*heightOfShape/108),
                          controlPoint1: CGPoint(x: ox+164.47*widthOfShape/216, y: oy+21.07*heightOfShape/108),
                          controlPoint2: CGPoint(x: ox+178.14*widthOfShape/216, y: oy-5.4*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+210.78*widthOfShape/216, y: oy+54.99*heightOfShape/108),
                              controlPoint: CGPoint(x: ox+218.43*widthOfShape/216, y: oy+10.18*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+174.23*widthOfShape/216, y: oy+100.2*heightOfShape/108),
                              controlPoint: CGPoint(x: ox+204.34*widthOfShape/216, y: oy+86.92*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+120.74*widthOfShape/216, y: oy+89.65*heightOfShape/108),
                              controlPoint: CGPoint(x: ox+157.58*widthOfShape/216, y: oy+107.54*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+120.74*widthOfShape/216, y: oy+89.65*heightOfShape/108),
                              controlPoint: CGPoint(x: ox+157.58*widthOfShape/216, y: oy+107.54*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+73.55*widthOfShape/216, y: oy+81.71*heightOfShape/108),
                              controlPoint: CGPoint(x: ox+95.32*widthOfShape/216, y: oy+79.73*heightOfShape/108))
            
            path.addCurve(to: CGPoint(x: ox+18.09*widthOfShape/216, y: oy+105.47*heightOfShape/108),
                          controlPoint1: CGPoint(x: ox+44.43*widthOfShape/216, y: oy+84.36*heightOfShape/108),
                          controlPoint2: CGPoint(x: ox+34.02*widthOfShape/216, y: oy+110.07*heightOfShape/108))
            
            path.addQuadCurve(to: CGPoint(x: ox+0.16*widthOfShape/216, y: oy+66.9*heightOfShape/108),
                              controlPoint: CGPoint(x: ox-1.68*widthOfShape/216, y: oy+99.75*heightOfShape/108))
            
            shapeColor.setStroke()
            path.lineWidth = lineWidthOfShape
            path.stroke()
            paths.append(path)
        }
        return paths
    }
    
    private func drawDiamonds() -> [UIBezierPath] {
        var paths = [UIBezierPath]()
        
        for i in 0..<number.rawValue+1 {
            let path = UIBezierPath()
            let x = X[number.rawValue][i]
            let y = Y[number.rawValue][i]
            path.move(to: CGPoint(x: x + widthOfShape/2, y: y))
            path.addLine(to: CGPoint(x: x + widthOfShape, y: y + heightOfShape/2))
            path.addLine(to: CGPoint(x: x + widthOfShape/2, y: y + heightOfShape))
            path.addLine(to: CGPoint(x: x, y: y + heightOfShape/2))
            path.close()
            
            shapeColor.setStroke()
            path.lineWidth = lineWidthOfShape
            path.stroke()
            paths.append(path)
        }
        return paths
    }
    
    private func drawBackground() {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        borderColor.setStroke()
        UIColor.white.setFill()
        roundRect.lineWidth = lineWidthOfRect
        if isSelected {
            roundRect.lineWidth = lineWidthOfRect*2
        } else {
            UIColor.black.setStroke()
        }
        roundRect.addClip()
        roundRect.fill()
        roundRect.stroke()
    }
    
    private func drawShadingSolid(_ paths: [UIBezierPath]) {
        for path in paths {
            shapeColor.setFill()
            path.fill()
        }
    }
    
    private func drawShadingStriped(_ paths: [UIBezierPath]) {
        let lines = UIBezierPath()
        for path in paths {
            path.addClip()
            for i in 0..<numberOfStripe {
                let x = path.bounds.minX + path.bounds.size.width/CGFloat(numberOfStripe) * CGFloat(i)
                lines.move(to: CGPoint(x: x, y: path.bounds.minY))
                lines.addLine(to: CGPoint(x: x, y: path.bounds.maxY))
            }
            shapeColor.setStroke()
            lines.stroke()
            UIGraphicsGetCurrentContext()?.resetClip()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawBackground()
        
        var paths = [UIBezierPath]()
        
        switch shape{
        case .ovals:
            paths = drawOvals()
        case .squiggles:
            paths = drawSquiggles()
        case .diamonds:
            paths = drawDiamonds()
        }
        
        switch shading {
        case .solid:
            drawShadingSolid(paths)
        case .striped:
            drawShadingStriped(paths)
        case .outlined:
            break
        }
    }
    
    enum Shape {
        case ovals
        case squiggles
        case diamonds
    }
    
    enum Color {
        case red
        case purple
        case green
    }
    
    enum Number: Int {
        case one = 0
        case two
        case three
    }
    
    enum Shading {
        case solid
        case striped
        case outlined
    }
}

extension SetCardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.15
        static let cornerRadiusToShapesWidth: CGFloat = 0.3
        //        static let widthToHeight: CGFloat = 0.63
        static let gapToBoundsHeight: CGFloat = 0.1
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerRadiusOfShape: CGFloat {
        return SizeRatio.cornerRadiusToShapesWidth * widthOfShape
    }
    private var lineWidthOfRect: CGFloat {
        return CGFloat(3)
    }
    private var lineWidthOfShape: CGFloat {
        return CGFloat(2)
    }
    private var gapOfShape: CGFloat {
        return bounds.size.height * SizeRatio.gapToBoundsHeight
    }
    private var widthOfShape: CGFloat {
        return bounds.width * 2/3
    }
    private var heightOfShape: CGFloat {
        return bounds.height / 5
    }
    private var X: [[CGFloat]] {
        var temp = [[CGFloat]]()
        temp = [[bounds.midX - widthOfShape/2],
                [bounds.midX - widthOfShape/2, bounds.midX - widthOfShape/2],
                [bounds.midX - widthOfShape/2, bounds.midX - widthOfShape/2, bounds.midX - widthOfShape/2]]
        return temp
    }
    private var Y: [[CGFloat]] {
        let Y1 = [bounds.midY - heightOfShape/2]
        let Y2 = [bounds.midY - heightOfShape - gapOfShape/2, bounds.midY + gapOfShape/2]
        let Y3 = [bounds.midY - heightOfShape*3/2 - gapOfShape,
                  bounds.midY - heightOfShape/2,
                  bounds.midY + heightOfShape/2 + gapOfShape]
        return [Y1,Y2,Y3]
    }
    private var numberOfStripe: Int {
        return 10
    }
    private var shapeColor: UIColor {
        switch color {
        case .green:
            return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case .purple:
            return UIColor.purple
        case .red:
            return #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }
    }
}
