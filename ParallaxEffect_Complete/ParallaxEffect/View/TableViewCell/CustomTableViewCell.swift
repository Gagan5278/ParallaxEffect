//
//  CustomTableViewCell.swift
//  ParallaxEffect
//
//  Created by Vishal Mishra, Gagan on 14/10/15.
//  Copyright (c) 2015 Vishal Mishra, Gagan. All rights reserved.
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
    
    func getOverFlowHeightOfImage()->CGFloat
    {
        return self.celImageView.image!.size.height - self.celImageView!.frame.size.height
    }

    func setImageOffset(imageOffset : CGPoint)
    {
        var  frame = self.celImageView.frame as CGRect
        frame.origin = imageOffset
        self.celImageView.frame  = frame
    }
}
