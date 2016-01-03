//
//  WaterfallCell.swift
//  IOSHelper
//
//  Created by 叶锋雷 on 16/1/2.
//  Copyright © 2016年 叶锋雷. All rights reserved.
//

import UIKit

class WaterfallCell: UICollectionViewCell {
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    private var _shop:Shop?
    var shop:Shop?{
        get{
            return self._shop
        }
        set{
            self._shop=newValue
            self.imageView.sd_setImageWithURL(NSURL(string: newValue!.img), placeholderImage: UIImage(named: "loading"))
            self.labelPrice.text=shop?.price
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
