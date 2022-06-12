//
//  CollageView.swift
//  Vincent
//
//  Created by Nada on 09/06/2022.
//

import UIKit

class CollageView: UIView {
    
    var rightPath = UIBezierPath()
    var leftPath = UIBezierPath()
    var rightImageView: UIImageView!
    var leftImageView: UIImageView!
    
    func createRightImageView(frame: CGRect) {
        guard let image = UIImage(named: "irises") else { return }
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        addSubview(imageView)
        rightImageView = imageView
    }
    
    func createLeftImageView(frame: CGRect) {
        guard let image = UIImage(named: "sunflowers") else { return }
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        addSubview(imageView)
        leftImageView = imageView
    }
    
    func createRightPath() {
        let rect = bounds.zoom(by: 0.9)
        rightPath.move(to: CGPoint(x: (rect.midX + (rect.width * 0.16) + 1.5), y: rect.minY))
        rightPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        rightPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        rightPath.addLine(to: CGPoint(x: (rect.midX - (rect.width * 0.16) + 1.5), y: rect.maxY))
        rightPath.close()
        rightPath.addClip()
    }
    
    func createLeftPath() {
        let rect = bounds.zoom(by: 0.9)
        leftPath.move(to: CGPoint(x: (rect.midX + (rect.width * 0.16) - 1.5), y: rect.minY))
        leftPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        leftPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        leftPath.addLine(to: CGPoint(x: (rect.midX - (rect.width * 0.16) - 1.5), y: rect.maxY))
        leftPath.close()
        leftPath.addClip()
    }
    override func draw(_ rect: CGRect) {
        createRightPath()
        createRightImageView(frame: bounds)
        
        let rightLayer = CAShapeLayer()
        rightLayer.path = rightPath.cgPath
        rightImageView.layer.mask = rightLayer
        
        createLeftPath()
        createLeftImageView(frame: bounds)
        
        let leftLayer = CAShapeLayer()
        leftLayer.path = leftPath.cgPath
        leftImageView.layer.mask = leftLayer
    }
    
}

extension CGRect {
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}
