//
//  ViewController.swift
//  PuzzleSample
//
//  Created by yonekan on 2020/01/13.
//  Copyright © 2020 yonekan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var image = UIImage(named: "cat")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = image!.resized(toWidth: 400)
        let pieceWidth = (image?.size.width)! / 4
        let pieceHeight = (image?.size.height)! / 4
     
        let pieces = makePieces()
        for i in 0...15 {
            let piece = pieces[i]
            let x = i / 4
            let y = i % 4
            
            let imageView = UIImageView(image: piece)
            imageView.frame = CGRect(x: CGFloat(x) * pieceWidth, y: CGFloat(y) * pieceHeight, width: pieceWidth + 10, height: pieceHeight + 10)
            self.view.addSubview(imageView)
        }
    }

    
    func makePieces() -> [UIImage] {
        image = image!.resized(toWidth: 400)
        
        let pieceWidth = (image?.size.width)! / 4
        let pieceHeight = (image?.size.height)! / 4
        
        var pieces: [UIImage] = []
        
        for i in 0...3 {
            
            for j in 0...3 {
                let piece = image?.cropToRect(rect: CGRect(x: CGFloat(i) * pieceWidth, y: CGFloat(j) * pieceHeight, width: pieceWidth, height: pieceHeight))
                
                pieces.append(piece!)
            }
            
        }
        
        return pieces
        
    }
}

extension UIImage {
    // Crops an input image (self) to a specified rect
    func cropToRect(rect: CGRect!) -> UIImage? {
        // Correct rect size based on the device screen scale
        let scaledRect = CGRect(x: rect.origin.x * self.scale, y: rect.origin.y * self.scale, width: rect.size.width * self.scale, height: rect.size.height * self.scale);
        // New CGImage reference based on the input image (self) and the specified rect
        let imageRef = self.cgImage!.cropping(to: scaledRect);
        // Gets an UIImage from the CGImage
        let result = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        // Returns the final image, or NULL on error
        return result;
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
