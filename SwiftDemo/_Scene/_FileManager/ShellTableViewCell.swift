//
//  ShellTableViewCell.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/12.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ShellTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var family: UILabel!
    @IBOutlet weak var distributed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoView.roundAllCorners(cornerRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
