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
    @State var selectedText: String
    
    var body: some View {
        VStack {
            Text(selectedText)
                .padding(.horizontal, 30)
                .font(.title3)
                .foregroundColor(.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(imageColorCollection, id: \.self) { imageValue in
                        ZStack {
                            Circle()
                                .stroke()
                                .frame(width: 38)
                            Circle()
                                .fill( Color(hex: imageValue.hexColor).opacity(0.3))
                                .frame(width: 30)
                        }.onTapGesture {
                            colorFilter = imageValue.hexColor
                            selectedText = imageValue.text
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ColorFilterStyle_Previews: PreviewProvider {
    static var previews: some View {
        ColorFilterStyle(capturedImage: UIImage(systemName: "image1")!
                         , colorFilter: .constant("FFFFFF")
                         , model: imageColorCollection.first!
                         , selectedColor: ""
                         , selectedText: "")
    }
}
