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
            UIColor.init(hexString: colorFilter)?.withAlphaComponent(0.5).setFill()
            UIRectFillUsingBlendMode(colorOverlayRect, .multiply)
        }
        
        completion(filteredImage)
    }
    
    func saveToPhotos(image: UIImage) {
        if let resizeImage = resizeImage(image: image, scaleFactor: 0.75) {
            
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else { return }
                
                PHPhotoLibrary.shared().performChanges {
                    let request = PHAssetChangeRequest.creationRequestForAsset(from: resizeImage)
                    request.creationDate = Date()
                } completionHandler: { success, error in
                    if success {
                        print("Image saved to Photos successfully.")
                        self.showingImagePicker = false
                    } else {
                         print("Error saving image to Photos: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        } else {
            print("Failed to resize image.")
        }
    }
    
    private func resizeImage(image: UIImage, scaleFactor: CGFloat) -> UIImage? {
        let newSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        // Set interpolation quality to high to ensure a smoother resizing
        context.interpolationQuality = .high
        
        image.draw(in: rect)
        
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return resizedImage
    }
}

