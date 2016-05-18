//
//  InterpolationViewController.swift
//  ParallaxEffect
//
//  Created by Vishal Mishra, Gagan on 14/10/15.
//  Copyright (c) 2015 Vishal Mishra, Gagan. All rights reserved.
//

import UIKit
let cellIdentifierInterpolation = "CellIdentifierInterpolation"
class InterpolationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //TableView object for showing images on cell
    @IBOutlet weak var customTableView: UITableView!
    //Arry to hold images with name
    var arrayOfContents  : [String] = Array ()
    //Dictionary to detect which cell has motion effect applied
    var dictionaryOfAddedMotionEffect = Dictionary<String, String>()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Motiion Effect"

        //run loop & Add images name from image assets to array
        for var i=1 ; i<=12 ; i++
        {
            self.arrayOfContents.append("img\(i)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Add motion effect on table cell
    func interPolationMotionEffectAtCell (MyCell cell : CustomTableViewCell , image : UIImage)
    {
        var min = -image.size.height
        var max = image.size.height
        max = max - cell.frame.size.height
        min = min + cell.frame.size.height
        if  max > 0 && min != 0
        {
            let verticalEffect = InterpollationMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis, minimumRelativeValue: min, maximumRelativeValue: max)
            cell.celImageView.addMotionEffect(verticalEffect)
        }
        
        min = -image.size.width
        max = image.size.width
        max = max - cell.frame.size.width
        min = min + cell.frame.size.width
        if  max > 0 && min != 0
        {
            let horizontalEffect = InterpollationMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis, minimumRelativeValue: min, maximumRelativeValue: max)
            cell.celImageView.addMotionEffect(horizontalEffect)
        }
    }
    
    
    // MARK:- TableView Delegate & Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfContents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierInterpolation, forIndexPath: indexPath) as! CustomTableViewCell
        let imgName = self.arrayOfContents[indexPath.row] as String
        cell.celImageView?.image = UIImage(named:imgName)
        cell.clipsToBounds=true
        cell.titleLabel?.text = imgName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cCell = cell as! CustomTableViewCell
        let imgName = self.arrayOfContents[indexPath.row] as String
        let cellIndex = ("\(indexPath.row)")
        
        if  let arrayOfEffects = cCell.celImageView?.motionEffects
        {
            self.dictionaryOfAddedMotionEffect[cellIndex] = nil
            for  motionEffects in arrayOfEffects
            {
                cCell.celImageView .removeMotionEffect(motionEffects )
            }
        }
        
        if self.dictionaryOfAddedMotionEffect[cellIndex] == nil
        {
            interPolationMotionEffectAtCell(MyCell: cCell, image: UIImage(named:imgName)!)
            self.dictionaryOfAddedMotionEffect[cellIndex] = cellIndex
        }
    }


}
