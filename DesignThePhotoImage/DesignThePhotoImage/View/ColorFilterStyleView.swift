//
//  ColorFilterStyle.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import SwiftUI

struct ColorFilterStyle: View {
    
    let capturedImage: UIImage?
    @Binding var colorFilter: String
    var model: ImagesColorModel?
    @State var selectedColor: String
    
    var body: some View {
//        ScrollView(.horizontal) {
//            HStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                              HStack(spacing: 20) {
                                  ForEach(imageColorCollection, id: \.self) { array in
                                      ZStack {
                                          Circle()
                                              .stroke()
                                              .frame(width: 38)
                                          Circle()
                                              .fill( Color(hex: array.hexColor).opacity(0.3))
                                              .frame(width: 30)
                                      }.onTapGesture {
                                          colorFilter = array.hexColor
                                      }
                                  }
                              }
                              .padding()
                }
//
//                }
//            .padding()
       // }
    }
}

struct ColorFilterStyle_Previews: PreviewProvider {
    static var previews: some View {
        ColorFilterStyle(capturedImage: UIImage(systemName: "image1")!
                         , colorFilter: .constant("FFFFFF"), model: imageColorCollection.first!, selectedColor: "")
    }
}
