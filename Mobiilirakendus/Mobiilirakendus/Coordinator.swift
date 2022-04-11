//
//  Coordinator.swift
//  Mobiilirakendus
//
//  Created by Johannes Kollist on 04.04.2022.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

class Coordinator: NSEntityDescription, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    @Environment(\.managedObjectContext) private var viewContext
    
    init(picker: ImagePickerView) {
        self.picker = picker
        super.init()
    }
    
    /*init(viewContext: NSManagedObjectContext) {
        self.isValid = true
        //self.viewContext = viewContext
    }*/
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        let pngImageData = selectedImage.pngData()
        let entityName = NSEntityDescription.entity(forEntityName: "Picture", in: viewContext)!
        let image = NSManagedObject(entity: entityName, insertInto: viewContext)
        image.setValue(pngImageData, forKeyPath: "binaryImg")
        do {
          try viewContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
        
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}
