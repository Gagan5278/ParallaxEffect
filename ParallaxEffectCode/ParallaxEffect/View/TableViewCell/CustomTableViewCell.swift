//
//  CustomTableViewCell.swift
//  ParallaxEffect
//
//  Created by Gagan Vishal Mishra on 14/10/15.
//  Copyright (c) 2015 Gagan Vishal Mishra. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var celImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- get overflow height of images
    func getOverFlowHeightOfImage()->CGFloat
    {
        return self.celImageView.image!.size.height - self.celImageView!.frame.size.height
    }

    //MARK:- Set offset for image
    func setImageOffset(imageOffset : CGPoint)
    {
        var  frame = self.celImageView.frame as CGRect
        frame.origin = imageOffset
        self.celImageView.frame  = frame
    }
}
