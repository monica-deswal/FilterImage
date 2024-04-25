//
//  ImageEditViewExtension.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import PhotosUI
import SwiftUI

extension ImageEditView {
    
    typealias CompletionHandler = (UIImage) -> Void
    
    func applyFilter(to image: UIImage, completion: @escaping CompletionHandler) {
        // Apply your desired filter to the image
        // For demonstration purposes, we'll just add text and overlay a color
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let filteredImage = renderer.image { context in
            image.draw(at: .zero)
            
            // Add text on the image
            let text = caption
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            let textAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.paragraphStyle: textStyle
            ]
            let textSize = text.size(withAttributes: textAttributes)
            let textRect = CGRect(x: (image.size.width - textSize.width) / 2,
                                  y: image.size.height - textSize.height - 20,
                                  width: textSize.width,
                                  height: textSize.height)
            text.draw(in: textRect, withAttributes: textAttributes)
            
            // Add color overlay
            let colorOverlayRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
           // UIColor.init(hexString: colorFilter)?.withAlphaComponent(0.5).setFill()
            UIColor.blue.withAlphaComponent(0.5).setFill()
            UIRectFillUsingBlendMode(colorOverlayRect, .multiply)
        }
        
        completion(filteredImage)
    }
    
    func saveToPhotos(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }

            PHPhotoLibrary.shared().performChanges {
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                request.creationDate = Date()
            } completionHandler: { success, error in
                if success {
                    print("Image saved to Photos successfully.")
                } else {
                    print("Error saving image to Photos: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
}
