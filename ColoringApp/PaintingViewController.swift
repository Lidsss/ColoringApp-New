//
//  PaintingViewController.swift
//  ColoringApp
//
//  Created by Lidiane Souza on 5/26/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

import UIKit



class PaintingViewController: UIViewController, UIScrollViewDelegate {

  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var tempImageView: UIImageView!
    
    @IBOutlet var toolView: UIView!
    @IBOutlet var illustrationImageView: UIImageView!
    
    
    
  var lastPoint = CGPoint.zeroPoint
  var red: CGFloat = 0.0
  var green: CGFloat = 0.0
  var blue: CGFloat = 0.0
  var brushWidth: CGFloat = 10.0
  var opacity: CGFloat = 1.0
  var swiped = false
  var imageIndex:Int = 0
  var sizeRect = UIScreen.mainScreen().applicationFrame
  
  let colors: [(CGFloat, CGFloat, CGFloat)] = [
    (0, 0, 0),
    (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
    (1.0, 0, 0),
    (0, 0, 1.0),
    (51.0 / 255.0, 204.0 / 255.0, 1.0),
    (102.0 / 255.0, 204.0 / 255.0, 0),
    (102.0 / 255.0, 1.0, 0),
    (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
    (1.0, 102.0 / 255.0, 0),
    (1.0, 1.0, 0),
    (1.0, 1.0, 1.0),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    chosenImage.image = 
    self.imageIndex = 0
//    chosenImage =  UIImageView(frame: CGRectMake(0, 0, sizeRect.size.width/2, sizeRect.size.width/2))
    
 //   illustrationImageView.image = Sequence.initialImages[rowOfGlory!]
    
    illustrationImageView.image = UIImage(named: "Hibiscus.png")
    println(rowOfGlory)
    println(illustrationImageView.image)

    
    //self.toolView.backgroundColor = UIColor(patternImage: UIImage(named: "tabBar.png")!)
    

    
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Actions

  @IBAction func reset(sender: AnyObject) {
    mainImageView.image = nil
  }

  @IBAction func share(sender: AnyObject) {
    UIGraphicsBeginImageContext(mainImageView.bounds.size)
    mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, 
      width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
     
    let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    presentViewController(activity, animated: true, completion: nil)
  }
  
  @IBAction func pencilPressed(sender: AnyObject) {
    
    var index = sender.tag ?? 0
    if index < 0 || index >= colors.count {
      index = 0
    }
    
    (red, green, blue) = colors[index]
    
    if index == colors.count - 1 {
      opacity = 1.0
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    swiped = false
    if let touch = touches.first as? UITouch {
      lastPoint = touch.locationInView(self.view)
    }
  }
  
  func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
    
    // 1
    UIGraphicsBeginImageContext(view.frame.size)
    let context = UIGraphicsGetCurrentContext()
    tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
    
    // 2
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
    
    // 3
    CGContextSetLineCap(context, kCGLineCapRound)
    CGContextSetLineWidth(context, brushWidth)
    CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
    CGContextSetBlendMode(context, kCGBlendModeNormal)
    
    // 4
    CGContextStrokePath(context)
    
    // 5
    tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
    tempImageView.alpha = opacity
    UIGraphicsEndImageContext()
    
  }

    
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    // 6
    swiped = true
    if let touch = touches.first as? UITouch {
      let currentPoint = touch.locationInView(view)
      drawLineFrom(lastPoint, toPoint: currentPoint)
      
      // 7
      lastPoint = currentPoint
    }
  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {

    if !swiped {
      // draw a single point
      drawLineFrom(lastPoint, toPoint: lastPoint)
    }
    
    // Merge tempImageView into mainImageView
    UIGraphicsBeginImageContext(mainImageView.frame.size)
    mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
    tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
    mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    tempImageView.image = nil
    
    captureLastImage()
    
    }
    
    func captureLastImage ()
    {
    
        //Send last image
        
        //Create the UIImage
        UIGraphicsBeginImageContext(mainImageView.frame.size)
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
        println(getImagePath)
        
//        test_image.image = savedImg
    
        //var path: String = paths.stringByAppendingPathComponent("DaoAudio.plist")
        
        
        // Se o arquivo nao existir
//        if (!fileManager.fileExistsAtPath(getImagePath)) {
//            
//            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
//            fileManager.copyItemAtPath(sourcePath, toPath: getImagePath, error: nil)
//        }
//        
       // return paths
    }
    
    
    
    
//    class func getAllAudioGames() -> [Sequence] {
//        
//        var rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        let path : String = getPlistPath(rootPath)
//        var audioGameArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
//        
//        if audioGameArray == nil || audioGameArray.count == 0 {
//            
//            return []
//        }
//        
//        var audioGames : [Sequence] = []
//        
//        for var i = 0; i < Sequence.initialImages.count; i++ {
//            
//            let dict : NSDictionary = audioGameArray[i] as! NSDictionary
//            var title : String = dict.valueForKey("gameAudioTitle") as! String
//            var audioName : String = dict.valueForKey("audioName") as! String
//            
//            //Sequence.initialImages.append(title, audioName: audioName)
//        }
//        
//        return audioGames
//    }
//
  

    //    @IBOutlet weak var test_image: UIImageView!
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let settingsViewController = segue.destinationViewController as! SettingsViewController
    settingsViewController.delegate = self
    settingsViewController.brush = brushWidth
    settingsViewController.opacity = opacity
    settingsViewController.red = red
    settingsViewController.green = green
    settingsViewController.blue = blue
  }
  
}

extension PaintingViewController: SettingsViewControllerDelegate {
  func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
    self.brushWidth = settingsViewController.brush
    self.opacity = settingsViewController.opacity
    self.red = settingsViewController.red
    self.green = settingsViewController.green
    self.blue = settingsViewController.blue
  }

    
    func setToolViewVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (toolViewIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.toolView?.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.toolView?.frame = CGRectOffset(frame!, 0, offsetY!)
                return
            }
        }
    }        @IBAction func tapped(sender: AnyObject) {
        setToolViewVisible(!toolViewIsVisible(), animated: true)
    }
    
    func toolViewIsVisible() -> Bool {
        return self.toolView?.frame.origin.y < UIScreen.mainScreen().bounds.height
    }
}

