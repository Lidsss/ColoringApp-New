//
//  DAO.swift
//  ColoringApp
//
//  Created by Vinícius Arcoverde on 5/22/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

import UIKit

var allSequences = [Sequence]()

class DAO: NSObject
{
    
    //Esse metodo retorna uma sequence de um numero especifico
    func getSequence(pageNumber : Int) -> Sequence
    {
        
        
    return allSequences[pageNumber]
    }
    
    //Esse metódo adiciona sequencias ao array de sequencias
//    func addSequence (var sequence : Sequence )
//    {
//        
//        allSequences.append(sequence)
//    }
    
}
