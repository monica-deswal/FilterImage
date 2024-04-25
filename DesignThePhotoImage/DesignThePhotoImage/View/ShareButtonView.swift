//
//  ShareButtonView.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 25/04/24.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Update the view controller if needed
    }
}
