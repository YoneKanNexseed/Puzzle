//
//  ViewController.swift
//  PuzzleSample
//
//  Created by yonekan on 2020/01/13.
//  Copyright © 2020 yonekan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let DIVISOR = CGFloat(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImage(named: "cat")
        image = image!.resized(toWidth: 400)
        
        createPuzzle(image: image!, divisor: DIVISOR)

    }

    
    func makePieces(image: UIImage, divisor: CGFloat) -> [UIImage] {
        
        let pieceWidth = (image.size.width) / divisor
        let pieceHeight = (image.size.height) / divisor
        
        var pieces: [UIImage] = []
        
        for i in 0..<Int(divisor) {
            
            for j in 0..<Int(divisor) {
                let piece = image.cropToRect(rect: CGRect(x: CGFloat(i) * pieceWidth, y: CGFloat(j) * pieceHeight, width: pieceWidth, height: pieceHeight))
                
                pieces.append(piece!)
            }
            
        }
        
        return pieces
        
    }
    
    func createPuzzle(image: UIImage, divisor: CGFloat) {
        let pieces = makePieces(image: image, divisor: divisor)
        let maxCount = Int(divisor) * Int(divisor)
        
        let pieceWidth = (image.size.width) / divisor
        let pieceHeight = (image.size.height) / divisor
        
        for i in 0..<maxCount {
            let piece = pieces[i]
            let x = i / Int(divisor)
            let y = i % Int(divisor)
            
            let imageView = UIImageView(image: piece)
            imageView.frame = CGRect(x: CGFloat(x) * pieceWidth, y: CGFloat(y) * pieceHeight, width: pieceWidth + 10, height: pieceHeight + 10)
            self.view.addSubview(imageView)
        }
    }
}
