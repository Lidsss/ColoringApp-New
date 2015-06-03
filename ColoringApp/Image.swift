//
//  Image.swift
//  ColoringApp
//
//  Created by Vinícius Arcoverde on 5/28/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

import UIKit

class Image: UIImage {
    
    //Send last image
    
    //Create the UIImage
    UIGraphicsBeginImageContext(view.frame.size)
    view.layer.renderInContext(UIGraphicsGetCurrentContext())
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    //Save it to the camera roll
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    
    
    let fileManager = NSFileManager.defaultManager()
    
    var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
    
    var filePathToWrite = "\(paths)/SaveFile\(self.imageIndex).png"
    
    var imageData: NSData = UIImagePNGRepresentation(image)
    
    fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
    
    self.imageIndex++
    
    var savedData: NSData? = fileManager.contentsAtPath(filePathToWrite)
    
    var savedImg : UIImage = UIImage(data: savedData!)!
    
    var getImagePath = paths.stringByAppendingPathComponent("SaveFile\(self.imageIndex).png")
    
    test_image.image = savedImg


}
