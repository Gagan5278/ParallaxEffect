//
//  ViewController.swift
//  ParallaxEffect
//
//  Created by Vishal Mishra, Gagan on 14/10/15.
//  Copyright (c) 2015 Vishal Mishra, Gagan. All rights reserved.
//

import UIKit
let cellIdentifier = "CellIdentifier"
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //TableView object to show images on cell
    @IBOutlet weak var customTable: UITableView!
    //Array to hold image names & used in cell rendering
    var arrayOfImages  : [String] = Array ()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //set title on navigation bar
        self.title = "Parallax Effect"
        for var i=1 ; i<=12 ; i++
        {
            arrayOfImages.append("img\(i)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     //MARK:- update cell for image height
    func updateImageViewCellOffset(cell : CustomTableViewCell)
    {
        let imageOverFlowHeight = cell.getOverFlowHeightOfImage()
        
        let cellOffsetY = cell.frame.origin.y - self.customTable.contentOffset.y
        let maxOffsetHeight = self.customTable.frame.size.height - cell.frame.size.height
        let verticalOffset = imageOverFlowHeight * (0.5 - cellOffsetY / maxOffsetHeight)
        
        cell.setImageOffset(CGPointMake(0, verticalOffset))
    }
    
     //MARK:- Table Delegates & Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! CustomTableViewCell
        cell.celImageView.image = UIImage(named: arrayOfImages[indexPath.row])
        cell.titleLabel.text = arrayOfImages[indexPath.row]
        cell.titleLabel.clipsToBounds=true
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        updateImageViewCellOffset(cell as! CustomTableViewCell)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selected = false
    }
    
    //MARK:- ScrollView Delegates
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for cell in self.customTable.visibleCells
        {
            let cCell = cell as! CustomTableViewCell
            updateImageViewCellOffset(cCell)
        }
    }
}



