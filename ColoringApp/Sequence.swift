//
//  Sequence.swift
//  ColoringApp
//
//  Created by Vinícius Arcoverde on 5/22/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

import UIKit

    var pageImages = [UIImage]()


 class Sequence: NSObject
{

    //armazena as possíveis imagens iniciais em um array
//    var initialImages = [UIImage(named:"test_draw.gif"), UIImage(named: "angry.jpg")]
    
    var imagesLimit: Int = 30
    static var initialImages:[UIImage?] = [
        UIImage(named: "alien"),
        UIImage(named: "kid"),
        UIImage(named: "Hibiscus")
    ]
    
    var progresImages = [UIImage]()
    var persistedImage = UIImage()

    
    
    

    
    //adiciona Imagens em uma sequencia respeitando o limite 
    
    
    
    
    
    
//    //Insere Imagem Inicial
//    func addInitialImage (initialImage : UIImage){
//        pageImages.insert(initialImage, atIndex: 0)
//        pageImages.append(initialImage)
//    }
//    
    
//    //arranja as imagens no array para ser uma animação flúida
//    func addingProgessImages (progressImages : [UIImage]) ->Bool{
//        
//        if (pageImages.count >= imagesLimit ) {
//            
//            pageImages.append(progresImages)
//            return false
//        }
//        
//    
//        
//        return true
//    }
    
    
}
