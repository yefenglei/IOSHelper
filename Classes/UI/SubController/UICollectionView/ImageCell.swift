//
//  ImageCell.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 15/12/29.
//  Copyright © 2015年 叶锋雷. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    var image:String{
        get{
            return ""
        }
        set{
            self.imageView.image=UIImage(named: newValue)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.layer.borderWidth=3
        self.imageView.layer.borderColor=UIColor.whiteColor().CGColor
        self.imageView.layer.cornerRadius=3
        self.imageView.clipsToBounds=true
        
        // Initialization code
    }

}
