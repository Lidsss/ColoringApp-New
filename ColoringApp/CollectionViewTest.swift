//
//  CollectionViewTest.swift
//  ColoringApp
//
//  Created by Vinícius Arcoverde on 5/29/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

import UIKit

var rowOfGlory: Int?


class CollectionViewTest: UICollectionViewController {
    
    
    
    var sequence = [Sequence]()
    var selectedIndexPath = [] 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sequence.initialImages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
    var cellImg = cell.viewWithTag(1) as! UIImageView
        
        
        cellImg.layer.cornerRadius = cellImg.frame.size.width / 2
        cellImg.clipsToBounds = true
    
        
        
    cellImg.image = Sequence.initialImages[indexPath.row]
        
    return cell
    
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        println("You selected cell #\(indexPath.row)!")

        rowOfGlory = indexPath.row
        
        
        
//        var nextController = self.storyboard?.instantiateViewControllerWithIdentifier("nextController") as! PaintingViewController
//        nextController.chosenImage = UIImageView(image: Sequence.initialImages[indexPath.row])
//        selectedIndexPath =
//        self.navigationController?.pushViewController(nextController, animated: false)
        //self.presentViewController(nextController, animated: false, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "itemSegue"{
//            let selectedPage = collectionView?.indexPathsForSelectedItems()
//            var pageImage = UIImageView()
//            var controller = self.storyboard?.instantiateViewControllerWithIdentifier("nextController") as! PaintingViewController
//            pageImage.image = controller.chosenImage.image
            
            
//            let indexPath = collectionView!.indexPathForCell((sender as? UICollectionViewCell)!)

//            var nextController = self.storyboard?.instantiateViewControllerWithIdentifier("nextController") as! PaintingViewController
//            nextController.chosenImage = UIImageView(image: Sequence.initialImages[indexPath.row])

            
//            let vc = segue.destinationViewController as! PaintingViewController
        }
   }
}
    

    
    

    





