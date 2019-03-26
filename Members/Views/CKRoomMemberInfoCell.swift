//
//  CKRoomMemberInfoCell.swift
//  Riot
//
//  Created by Hiếu Nguyễn on 1/22/19.
//  Copyright © 2019 matrix.org. All rights reserved.
//

import UIKit

class CKRoomMemberInfoCell: CKRoomMemberBaseCell {

    // MARK: - OUTLET

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - OVERRIDE

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = "Display name"
        contentLabel.text = "Uchiha Itachi"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
