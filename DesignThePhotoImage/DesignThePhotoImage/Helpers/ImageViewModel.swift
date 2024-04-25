//
//  ImagesColorModel.swift
//  DesignThePhotoImage
//
//  Created by Monica Deswal 1 on 24/04/24.
//

import Foundation

struct ImagesColorModel: Hashable, Observable {
    let id = UUID()
    let text: String
    let hexColor: String
    var isHidden: Bool = true
}

let imageColorCollection = [ImagesColorModel(text: "Original", hexColor: "#FEB07C")
                            , ImagesColorModel(text: "Vivid", hexColor: "#F9CE90")
                            , ImagesColorModel(text: "VividWarm", hexColor: "#F9F1DA")
                            , ImagesColorModel(text: "VividCool", hexColor: "#B8D1C0")
                            , ImagesColorModel(text: "DRAMATIC", hexColor: "#F5DDDD")
                            , ImagesColorModel(text: "DRAMATICWARM", hexColor: "#C2B2B4")]
