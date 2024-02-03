//
//  ImagePickerView.swift
//  BemLembrado
//
//  Created by Vinicius Wessner on 18/01/24.
//

import Foundation
import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool

    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerViewCordinator {
        return ImagePickerViewCordinator(image: $image, imageData: $imageData, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let pickerController = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType){
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = sourceType
        }
        
        pickerController.delegate = context.coordinator
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


class ImagePickerViewCordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: Image?
    @Binding var imageData: Data?
    @Binding var isPresented: Bool
    
    init(image: Binding<Image?>,imageData: Binding<Data?> ,isPresented: Binding<Bool>) {
        self._image = image
        self._imageData = imageData
        self._isPresented = isPresented
    
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            //redimensionando a imagem
            let width: CGFloat = 420.0
            let canvas = CGSize(width: width, height: CGFloat(ceil(width / image.size.width * image.size.height)))
            
            let imgResized = UIGraphicsImageRenderer(size: canvas, format: image.imageRendererFormat).image { _ in
                image.draw(in: CGRect(origin: .zero, size: canvas))
            }
            
            self.image = Image(uiImage: imgResized)
            self.imageData = imgResized.jpegData(compressionQuality: 0.2)
            
        }
        
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
